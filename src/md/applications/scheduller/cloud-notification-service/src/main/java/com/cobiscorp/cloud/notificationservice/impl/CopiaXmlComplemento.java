package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.FileUtil;
import com.cobiscorp.cloud.scheduler.utils.FileZipMasive;
import com.cobiscorp.cloud.scheduler.utils.Util;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CopiaXmlComplemento extends Thread implements Job {
	private static final Logger logger = Logger.getLogger(CopiaXmlComplemento.class);
	private String tipoOperacion;
	private CopyFileJob copyFileJob;

	public CopiaXmlComplemento(String tipoOperacion, CopyFileJob copyFileJob) {
		super();
		this.tipoOperacion = tipoOperacion;
		this.copyFileJob = copyFileJob;
	}

	public CopiaXmlComplemento() {
		super();
	}

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		if (logger.isDebugEnabled()) {
			logger.debug("JobName para Copia de archivos de complemento a la capa web: " + jobExecutionContext.getJobDetail().getName());
		}
		try {

			CopiaXmlComplemento cpxmlRevolvente = new CopiaXmlComplemento("REVOLVENTE", copyFileJob);
			cpxmlRevolvente.start();

			CopiaXmlComplemento cpxmlGrupal = new CopiaXmlComplemento("GRUPAL", copyFileJob);
			cpxmlGrupal.start();

		} catch (Exception ex) {
			logger.error("Exception CopiaXmlComplemento: ", ex);
		}

	}

	@Override
	public void run() {
		Connection cn = null;
		CallableStatement executeSP = null;
		try {

			String estadoGENXML = "";
			String timbrarXML = "";
			String generarPdf = "";
			String enviarEmail = "";

			Integer numberFilesZip = 0;
			String nameZip = "";
			int sequential = 0;

			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, tipoOperacion);

			logger.debug("Tipo de Operacion CopiaXmlComplemento: " + tipoOperacion);
			logger.debug("result: " + result);

			while (result.next()) {
				estadoGENXML = result.getString(1);
				timbrarXML = result.getString(2);
				generarPdf = result.getString(3);
				enviarEmail = result.getString(4);

				logger.debug("- Generación de xml - estadoGENXML " + tipoOperacion + ": " + estadoGENXML);
				logger.debug("- Timbrado de xml - timbrarXML " + tipoOperacion + ": " + timbrarXML);
				logger.debug("- Generación de pdf - generarPdf " + tipoOperacion + ": " + generarPdf);
				logger.debug("- Envío de correo - enviarEmail " + tipoOperacion + ": " + enviarEmail);
			}

			logger.debug("Estado para el tipo de operacion CopiaXmlComplemento:--> " + timbrarXML + " " + tipoOperacion);

			if (timbrarXML.equalsIgnoreCase("SI")) {
				CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYCO);
				try {

					String pattern = obtenerPattern(copyFileJob, tipoOperacion);
					logger.error("pattern que ingresa a buscar CopiaXmlComplemento segun tipo Operacion " + tipoOperacion + ": " + pattern);

					// Nombre del zip
					nameZip = zipNameParameter(cn, executeSP);
					if (nameZip == null) {
						logger.debug("- valor del nameZip:" + nameZip);
						return;
					}

					// Cantidad de registros que van al zip
					numberFilesZip = numberFilesZipParameter(cn, executeSP);
					if (numberFilesZip <= 0) {
						logger.debug("- valor del numberFilesZip:" + numberFilesZip);
						return;
					}

					// Trae las rutas del archivo .properties
					File pathSourceFolder = new File(copyFileJob.getSourceFolder());
					String destinationFolderZip = copyFileJob.getDestinationFolder();
					String historicoFolderzip = copyFileJob.getWorkFolder();

					logger.debug("- pathSourceFolder:" + pathSourceFolder);
					logger.debug("- destinationFolderZip:" + destinationFolderZip);
					logger.debug("- historicoFolderzip:" + historicoFolderzip);

					if (createFolder(historicoFolderzip)) {
						historicoFolderzip = Util.validateDateFormat(historicoFolderzip);

						if (!pathSourceFolder.exists()) {
							logger.error("- el directorio: " + pathSourceFolder + " no existe");
							return;
						} else {
							logger.debug("- cantidad de archivos procesar: " + pathSourceFolder.listFiles().length);
						}

						Collection fileCollection = FileUtils.listFiles(pathSourceFolder, new WildcardFileFilter(pattern), null);

						logger.debug("- collection: " + fileCollection.size());

						while (fileCollection.size() > 0) {
							// Para el numero de registros
							ResultSet resultParamSec = executeNotificationGeneralParamSec(cn, executeSP, "S", "sb_facturacion_complemento");
							while (resultParamSec.next()) {
								sequential = resultParamSec.getInt(1);
							}

							File[] fileListCollection = new File[fileCollection.size()];
							ArrayList<File> listaLote = new ArrayList<File>();
							int iterator = 0;

							for (Object found : fileCollection) {
								String fileToZip = ((File) found).getName();
								fileListCollection[iterator] = (File) found;
								iterator = iterator + 1;
							}

							if (fileListCollection.length < numberFilesZip) {
								logger.debug("- fileListCollection.length >> " + fileListCollection.length);
								logger.debug("- loteZip >> " + numberFilesZip);
								numberFilesZip = fileListCollection.length;
							}

							// Inicio zipeado
							String nameCompleto = nameZip + "_" + sequential;

							// Va agregando uno a uno a la lista para el zip
							for (int i = 0; i < numberFilesZip; i++) {
								listaLote.add(fileListCollection[i]);
							}

							boolean respcreateZipMasive = FileZipMasive.createZipMasive(destinationFolderZip, nameCompleto, listaLote);

							if (respcreateZipMasive) {
								executeNotificationGeneralIngComplemento(cn, executeSP, "M", nameCompleto, "", "P"); // Para registrar el inicio

								for (File file : listaLote) {
									String ruta = historicoFolderzip + File.separator + file.getName();

									FileUtil.moveFile(file.getAbsolutePath(), ruta);

									validateCopyXmlHistory(file.getAbsolutePath(), ruta);

								}

								for (int i = 0; i < numberFilesZip; i++) {
									executeNotificationGeneralIngComplemento(cn, executeSP, "O", nameCompleto, fileListCollection[i].getName(), "");
								}

								fileCollection = FileUtils.listFiles(pathSourceFolder, new WildcardFileFilter(pattern), null);

								executeNotificationGeneralIngComplemento(cn, executeSP, "M", nameCompleto, "", "F"); // Para registrar que finalizo
							} else {
								logger.error("- Error creando archivos zip masivo");
							}
						}
					}
				} catch (Exception ex) {
					logger.error("- Error proceso de generacion archivos-->", ex);
				}
			} else {
				logger.error("- No se ejecuta ya que el parametro para timbrar CopiaXmlComplemento es : --> " + timbrarXML + "" + tipoOperacion);
			}

		} catch (Exception ex) {
			logger.error("- Exception: ", ex);

		} finally {
			try {
				logger.info("- Termino el run");
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("- Error al cerrar la conexión: ", e);
			}
		}
	}

	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String toperation) throws Exception {
		if (logger.isDebugEnabled())
			logger.debug("Ingresa executeNotification General copia XML para CopiaXmlComplemento");

		String query = "{ call cob_conta_super..sp_admin_est_cta(?) }";

		logger.debug("sqlcall: " + query + " [ " + toperation + " ]");

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("- ERROR executeNotificationGeneral-->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled())
				logger.debug("- Finaliza executeNotificationGeneral");
		}

	}

	public static ResultSet executeNotificationGeneralParam(Connection cn, CallableStatement executeSP, String operacion, String nemonico, String tabla) throws Exception {
		String query = "{ call cob_conta_super..sp_admin_conect_timb(?,?,?) }";

		logger.debug("sqlcall: " + query + " [ " + nemonico + " ]");

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operacion);
			executeSP.setString(2, tabla);
			executeSP.setString(3, nemonico);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error(" - ERROR executeNotificationGeneralParam -->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled())
				logger.info("- Finaliza executeNotificationGeneralParam");
		}

	}

	public static ResultSet executeNotificationGeneralParamSec(Connection cn, CallableStatement executeSP, String operacion, String tabla) throws Exception {
		String query = "{ call cob_conta_super..sp_admin_conect_timb(?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operacion);
			executeSP.setString(2, tabla);
			executeSP.execute();

			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("- ERROR executeNotificationGeneralParamSec-->", ex);
			throw ex;
		}
	}

	public static ResultSet executeNotificationGeneralIngComplemento(Connection cn, CallableStatement executeSP, String operacion, String archivoZip, String complemento, String estado)
			throws Exception {
		String query = "{ call cob_conta_super..sp_admin_conect_timb(?,?,?,?,?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operacion);
			executeSP.setString(2, "");
			executeSP.setString(3, "");
			executeSP.setString(4, archivoZip);
			executeSP.setString(5, "");
			executeSP.setString(6, complemento);
			executeSP.setString(7, estado);
			executeSP.execute();

			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR en executeNotificationGeneralIngComplemento", ex);
			throw ex;
		}

	}

	public String obtenerPattern(CopyFileJob copyFileJob, String tipoOpercion) {
		String pattern = null;

		String[] patterns = copyFileJob.getFileNamePattern().split("\\|");
		for (int i = 0; i < patterns.length; i++) {
			logger.info("- obtenerPattern copia Xml CopiaXmlComplemento: " + i + " " + patterns[i]);
		}

		if (tipoOpercion.equalsIgnoreCase("GRUPAL")) {
			pattern = patterns[0];
		}

		if (tipoOpercion.equalsIgnoreCase("REVOLVENTE")) {
			pattern = patterns[1];
		}

		return pattern;
	}

	// Se crea una carpeta para cada hora
	public boolean createFolder(String ruta) {
		boolean generate = true;
		File directory = new File(Util.validateDateFormat(ruta));
		if (!directory.exists()) {
			if (directory.mkdirs()) {
				generate = true;
			} else {
				generate = false;
			}
		}
		return generate;
	}

	// Para el nombre del archivo--zip name
	public String zipNameParameter(Connection cn, CallableStatement executeSP) {
		String nemonicoZipName = "NOPACO";
		String zipName = null;

		try {
			ResultSet resultNemonicoZipName = executeNotificationGeneralParam(cn, executeSP, "P", nemonicoZipName, null);
			if (resultNemonicoZipName != null) {
				while (resultNemonicoZipName.next()) {
					if (logger.isDebugEnabled())
						logger.error("- zipNameParameter:" + resultNemonicoZipName.toString());
					zipName = resultNemonicoZipName.getString(1);
				}
			}
		} catch (Exception e) {
			logger.error("- e.getMessage()" + e.getMessage());
		} finally {
			if (logger.isDebugEnabled())
				logger.debug("Finaliza zipNameParameter - valor a retornar es: " + zipName);
		}

		return zipName;
	}

	// Cantidad de registros dentro del zip
	public int numberFilesZipParameter(Connection cn, CallableStatement executeSP) {

		String nemonicoNumberFilesZip = "NUFAEM";
		Integer loteZip = 0;

		try {
			ResultSet resultParamNum = executeNotificationGeneralParam(cn, executeSP, "P", nemonicoNumberFilesZip, null);
			while (resultParamNum.next()) {
				logger.info("- numLoteParameter:" + resultParamNum.toString());
				loteZip = resultParamNum.getInt(1);
			}
		} catch (Exception e) {
			logger.error("- numLoteParameter: " + e.getMessage());
		} finally {
			if (logger.isDebugEnabled())
				logger.debug("- Finaliza numberFilesZipParameter - valor a retornar es: " + loteZip);
		}

		return loteZip;
	}

	private boolean validateCopyXmlHistory(String originPath, String destinityPath) {

		logger.debug("Inicia comprobación de copia");

		File fileOrigin = new File(originPath);
		File fileDestinity = new File(destinityPath);

		if (!fileDestinity.exists()) {
			FileUtil.moveFile(fileOrigin.getAbsolutePath(), fileDestinity.getAbsolutePath());
		} else {
			if (fileOrigin.exists()) {
				if (fileOrigin.delete()) {
					logger.debug("Se elimina el archivo " + fileOrigin.getAbsolutePath());
				} else {
					logger.debug("No se puede eliminar el archivo " + fileOrigin.getAbsolutePath());
				}
			} else {
				logger.debug("El archivo " + fileOrigin.getAbsolutePath() + " no existe.");
			}
		}

		logger.debug("Finaliza comprobación de copia");

		return true;
	}

}