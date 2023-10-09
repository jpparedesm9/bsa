package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.model.CustomerAccStatus;
import com.cobiscorp.cloud.scheduler.utils.AccountStatusNotification;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class EnvioEstadoCuenta extends NotificationGeneric implements Job {
	private static final Logger logger = Logger.getLogger(EnvioEstadoCuenta.class);
	// private static String packedPath = "";

	private static String filesPath = "C:/Cobis/VBatch/Credito/listados/estctagen/"; // xml,pdf(gen)
	private static String packedFilePath = ""; // C:/NOTIFICATIONSERVER/NS/resources/attachments/

	private static String filesToHistPath = "C:/Cobis/VBatch/Credito/listados/estctahist/";
	private static String packedPassword = "";
	private static final String EXTENSION_PDF = ".pdf";
	private static final String EXTENSION_XML = ".xml";
	private static final String CLMN_PSSWRD = "PASSWORD";
	private static final String CLMN_CSTMR = "CLIENTE";
	private static final String CLMN_FILE = "ARCHIVO";
	private static final String CLMN_EMAIL = "EMAIL";
	private static final String CLMN_NOMBRE = "NOMBRE";

	public EnvioEstadoCuenta() {
		logger.debug("se crea la clase EnvioEstadoCuenta");
	}

	@Override
	public List<?> xmlToDTO(File inputData) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa xmlToDTO");
		}
		return getCustomerList("Q");
	}

	private List<?> getCustomerList(String operation) {
		Connection cn = null;
		CallableStatement executeSP = null;
		ResultSet customerListRs = null;
		String query = "{ call cob_credito..sp_actualiza_est_cta_env(?,?,?) }";

		try {
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			executeSP.setInt(2, 0);
			executeSP.setString(3, "");

			executeSP.execute();
			customerListRs = executeSP.getResultSet();

			return setResultSetCustomerList(customerListRs);

		} catch (Exception ex) {
			logger.error("ERROR executeUpdateAccStatusSent -->", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza getCustomerList");
			}
		}
		return null;
	}

	private List<?> setResultSetCustomerList(ResultSet customerListRs) throws SQLException {
		List<CustomerAccStatus> custAccStatusList = new ArrayList<CustomerAccStatus>();
		while (customerListRs.next()) {
			CustomerAccStatus cas = new CustomerAccStatus();
			cas.setCliendId(customerListRs.getInt(CLMN_CSTMR));
			cas.setFilename(customerListRs.getString(CLMN_FILE));
			cas.setMail(customerListRs.getString(CLMN_EMAIL));
			cas.setClientName(customerListRs.getString(CLMN_NOMBRE) == null ? "" : customerListRs.getString(CLMN_NOMBRE));
			custAccStatusList.add(cas);
		}
		return custAccStatusList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		CustomerAccStatus cas = (CustomerAccStatus) inputDto;
		Map<String, Object> parameters = new HashMap<String, Object>();
		if (logger.isDebugEnabled()) {
			logger.debug("setParameterToSendMail() --> ClientId= " + cas.getCliendId());
			logger.debug("setParameterToSendMail() --> Mail= " + cas.getMail());
			logger.debug("setParameterToSendMail() --> Filename= " + cas.getFilename());
			logger.debug("setParameterToSendMail() --> Client Name= " + cas.getClientName());
		}
		parameters.put("EMAIL_TO", cas.getMail());
		parameters.put("SUBJECT", cas.getMailSubject());
		parameters.put("CLIENT_ID", cas.getCliendId());
		parameters.put("CLNT_NAME", cas.getClientName());
		return parameters;
	}

	@Override
	public void execute(JobExecutionContext ctxt) throws JobExecutionException {
		logger.debug("EnvioEstadoCuenta.execute() - INI - wtoledo");
		boolean packedStatus = false;
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.execute() - INI");
		}
		pathArchives();
		getPackedParameters();
		// Logica de comprimir los archivos con contraseña
		packedStatus = readCustomerZipFiles();
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.execute() - packedStatus = " + packedStatus);
		}
		if (packedStatus) {
			// Logica de envio de notificaciones
			AccountStatusNotification.generateNotification(ctxt.getJobDetail().getName(), null);
			moveFileToHistoricalFolder();
		}
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.execute() - FIN");
		}
	}

	public void moveFileToHistoricalFolder() {
		File dirSrc = new File(filesPath);
		File dirTrgt = createHistoricalFolder();

		if (dirSrc.isDirectory()) {
			File[] content = dirSrc.listFiles();
			for (int i = 0; i < content.length; i++) {
				if (validateAllowedFileExtension(content[i])) {
					if (dirTrgt.isDirectory()) {
						File fileTrgt = new File(dirTrgt, content[i].getName());
						if (fileTrgt.exists()) {
							fileTrgt.delete();
						}
						boolean success = content[i].renameTo(new File(dirTrgt, content[i].getName()));
						if (!success) {
							if (logger.isDebugEnabled()) {
								logger.debug("EnvioEstadoCuenta.copyFileToHistoricalFolder() - Error al pasar archivo a historico");
								logger.debug("EnvioEstadoCuenta.copyFileToHistoricalFolder() - Archivo = " + content[i].getName());
							}
						}
					} else {
						if (logger.isDebugEnabled()) {
							logger.debug("EnvioEstadoCuenta.moveFileToHistoricalFolder() - Error - no existe carpeta => " + dirTrgt);
						}
					}
				} else {
					if (logger.isDebugEnabled()) {
						logger.debug("EnvioEstadoCuenta.moveFileToHistoricalFolder() - Extension de Archivo No permitida => " + content[i].getName());
					}
				}
			}
		}
	}

	private File createHistoricalFolder() {
		File wDirTrgt = null;
		if (getProcessDate() != null) {
			if (logger.isDebugEnabled()) {
				logger.debug("moveFileToHistoricalFolder() Fecha Folder Historica => " + getProcessDate());
			}
			wDirTrgt = new File(filesToHistPath + getProcessDate());
			wDirTrgt.mkdirs();

		}
		return wDirTrgt;
	}

	private String getProcessDate() {
		Date myDate = new Date();
		SimpleDateFormat wDmyFormat = new SimpleDateFormat("yyyyMMdd");
		String wDmyDate = wDmyFormat.format(myDate);
		return wDmyDate;
	}

	private boolean validateAllowedFileExtension(File file) {
		if (EXTENSION_PDF.replace(".", "").equals(getFileExtension(file)) || EXTENSION_XML.replace(".", "").equals(getFileExtension(file))) {
			return true;
		}
		return false;
	}

	private String getFileExtension(File file) {
		String fileName = file.getName();
		if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
			return fileName.substring(fileName.lastIndexOf(".") + 1);
		}
		return "";
	}

	private boolean readCustomerZipFiles() {
		if (logger.isDebugEnabled()) {
			logger.debug("Ejecutar EnvioEstadoCuenta.readCustomerZipFiles() - INI");
			logger.debug("Ejecutar EnvioEstadoCuenta.readCustomerZipFiles() - filesPath= " + filesPath);
		}
		File f = new File(filesPath);
		Connection cn = null;
		CallableStatement executeSP = null;
		boolean wExistCustomer = false;
		Integer customerId = null;
		String pdfFileName = null;
		String xmlFileName = null;
		if (f.exists()) {
			File[] ficheros = f.listFiles();
			if (ficheros.length > 0) {
				try {
					cn = ConnectionManager.newConnection();
					for (int x = 0; x < ficheros.length; x++) {
						try {
							customerId = Integer.valueOf(stripExtension(ficheros[x].getName()));
						} catch (NumberFormatException e) {
							logger.debug("readCustomerZipFiles() :: CustomerId Incorrecto");
							customerId = -1;
						}
						if (!customerId.equals(-1) && validateAllowedFileExtension(ficheros[x])) {
							wExistCustomer = true;
							pdfFileName = stripExtension(ficheros[x].getName());
							xmlFileName = stripExtension(ficheros[x].getName());

							executeUpdateAccStatusSent(cn, executeSP, customerId, xmlFileName);
							if (logger.isDebugEnabled()) {
								logger.debug("readCustomerZipFiles() :: NombreArchivo= " + stripExtension(ficheros[x].getName()));
								logger.debug("readCustomerZipFiles() :: NombreArchivoSinExt= " + ficheros[x].getName());
							}
							zipWithPasswordCustomerFiles(customerId, xmlFileName, pdfFileName);
						}
					}
				} catch (Exception e) {
					logger.error("ERROR readCustomerZipFiles -->", e);
				} finally {
					try {
						ConnectionManager.saveConnection(cn);
					} catch (Exception e) {
						logger.error("Error al cerrar la conexión: ", e);
					}
					if (logger.isDebugEnabled()) {
						logger.debug("Finaliza readCustomerZipFiles");
					}
				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.debug("EnvioEstadoCuenta.readCustomerZipFiles() - No existen archivos por procesar");
				}
			}

		} else {
			logger.debug("No existe Directorio");
			// System.out.println("No existe Directorio");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Ejecutar EnvioEstadoCuenta.readCustomerZipFiles() - FIN");
		}
		return wExistCustomer;
	}

	static String stripExtension(String str) {
		if (str == null)
			return null;
		int pos = str.lastIndexOf(".");
		if (pos == -1)
			return str;
		return str.substring(0, pos);
	}

	private static void zipWithPasswordCustomerFiles(Integer customerId, String xmlFileName, String pdfFileName) throws ZipException {
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.zipWithPasswordCustomerFiles - INI");
		}
		ZipFile zipFile = new ZipFile(packedFilePath + xmlFileName + ".zip");
		ArrayList<File> filesToAdd = new ArrayList<File>();
		File fileXml = new File(filesPath + xmlFileName + EXTENSION_XML);
		File filePdf = new File(filesPath + pdfFileName + EXTENSION_PDF);
		if (fileXml.exists()) {
			filesToAdd.add(fileXml);
		}
		if (filePdf.exists()) {
			filesToAdd.add(filePdf);
		}
		ZipParameters parameters = new ZipParameters();
		parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
		parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
		parameters.setEncryptFiles(true);
		parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
		parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.zipWithPasswordCustomerFiles() --> PWD=" + packedPassword);
		}
		parameters.setPassword(packedPassword);
		zipFile.addFiles(filesToAdd, parameters);
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.zipWithPasswordCustomerFiles - FIN");
		}
	}

	public ResultSet executeUpdateAccStatusSent(Connection cn, CallableStatement executeSP, Integer clientId, String xmlFileName) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeUpdateAccStatusSent");
		}
		String query = "{ call cob_credito..sp_actualiza_est_cta_env(?,?,?) }";

		try {
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "I");
			executeSP.setInt(2, clientId);
			executeSP.setString(3, xmlFileName);

			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR executeUpdateAccStatusSent -->", ex);
			throw ex;
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (SQLException e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza executeUpdateAccStatusSent");
			}
		}
	}

	private void getPackedParameters() {
		Connection cn = null;
		CallableStatement executeSP = null;
		ResultSet result = null;
		String query = "{ call cob_credito..sp_actualiza_est_cta_env(?,?,?) }";
		if (logger.isDebugEnabled()) {
			logger.debug("EnvioEstadoCuenta.getPackedParameter() - INI");
		}
		try {
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "S");
			executeSP.setInt(2, 0);
			executeSP.setString(3, "");

			executeSP.execute();
			result = executeSP.getResultSet();
			if (result != null) {
				while (result.next()) {
					packedPassword = result.getString(CLMN_PSSWRD);
					if (logger.isDebugEnabled()) {
						logger.debug("EnvioEstadoCuenta.getPackedParameter() - passwordColumn= " + packedPassword);
					}
				}
			}

		} catch (Exception ex) {
			logger.error("ERROR getPackedParameter -->", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza getPackedParameter");
			}
		}
	}

	private static void pathArchives() {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa EnvioEstadoCuenta.pathArchives - INI");
		}
		ConfigManager config = ConfigManager.getInstance();
		packedFilePath = config.getPDFPath();
	}

}
