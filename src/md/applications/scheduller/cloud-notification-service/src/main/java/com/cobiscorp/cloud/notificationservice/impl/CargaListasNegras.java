package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.FileChannel;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CargaListasNegras extends NotificationGeneric implements Job {
	private static final Logger logger = Logger.getLogger(CargaListasNegras.class);
	private static final String JOB_ACRONYM = "CRGLN";

	private String from;
	private String to;
	private String cc;
	private static final String subject = "Carga de Información de Listas Negras a la base COBIS";
	private static final String messageOk = "CARGA EXITOSA DEL ARCHIVO DE LISTAS NEGRAS !!";
	private static final String messageError = "La carga falló con el siguiente error:\n\r";
	private String attachment = null;

	@Override
	public List<?> xmlToDTO(File inputData) {
		return null;
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
		return null;
	}

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		try {
			if (logger.isDebugEnabled()) {
				logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			loadBlackList();
		} catch (Exception ex) {
			logger.error(ex);
			Email.send(from, to, cc, subject, messageError + ex.getMessage(), attachment);
		}
	}

	private void loadBlackList() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia loadBlackList");
		}

		boolean continueProcess = true;
		String internalError = null;

		String zipFileName;
		String webServerPath;
		String dbServerPath;
		String historyPath;
		File zipFile = null;
		File unzippedFile = null;

		/* JOB PROPERTIES */
		InputStream inputStreamPropertiesFile = null;

		try {

			try {
				inputStreamPropertiesFile = new FileInputStream("notification/" + JOB_ACRONYM + ".properties");
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			Properties properties = new Properties();
			try {
				properties.load(inputStreamPropertiesFile);
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cargar archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se carg\u00f3 el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			try {
				inputStreamPropertiesFile.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			zipFileName = properties.getProperty("zipFileName");
			webServerPath = properties.getProperty("webServerPath");
			dbServerPath = properties.getProperty("dbServerPath");
			historyPath = properties.getProperty("historyPath");
			from = properties.getProperty("from");
			to = properties.getProperty("to");
			cc = properties.getProperty("cc");

			if (logger.isTraceEnabled()) {
				logger.trace("zipFileName: " + zipFileName);
				logger.trace("webServerPath: " + webServerPath);
				logger.trace("dbServerPath: " + dbServerPath);
				logger.trace("historyPath: " + historyPath);
				logger.trace("from: " + from);
				logger.trace("to: " + to);
				logger.trace("cc: " + cc);
			}

		} finally {
			if (inputStreamPropertiesFile != null) {
				try {
					inputStreamPropertiesFile.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM;
					continueProcess = false;
				}
			}
		}

		if (continueProcess) {

			/* MOVE DOWNLOADED BLACK-LIST FILE TO DATABASE SERVER */
			File downloadedFile = new File(webServerPath + zipFileName);
			if (downloadedFile.renameTo(new File(dbServerPath + zipFileName))) {
				if (logger.isDebugEnabled()) {
					logger.debug("Se movi\u00f3 el archivo de Listas Negras al servidor de base de datos");
				}
			} else {
				throw new COBISInfrastructureRuntimeException("No se puede mover el archivo " + webServerPath + zipFileName + " al servidor de base de datos");
			}

		}

		if (continueProcess) {

			/* UNZIP BLACK LIST FILE */
			ZipInputStream zipInputStream = null;
			FileOutputStream fileOutputStreamUnzippedFile = null;

			try {

				zipFile = new File(dbServerPath + zipFileName);
				try {
					zipInputStream = new ZipInputStream(new FileInputStream(dbServerPath + zipFileName));
				} catch (FileNotFoundException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo " + dbServerPath + zipFileName);
				}

				ZipEntry zipEntry;
				try {
					zipEntry = zipInputStream.getNextEntry();
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo extraer el contenido del archivo empaquetado de Listas Negras");
				}

				while (zipEntry != null) {
					String zippedFileName = zipEntry.getName();

					if (zippedFileName.compareToIgnoreCase(zipFileName.substring(0, zipFileName.indexOf(".zip"))) != 0) {
						logger.error("El archivo empaquetado " + zippedFileName + " no es el esperado");
					} else {

						unzippedFile = new File(zipFile.getParent() + File.separator + zippedFileName);

						try {
							fileOutputStreamUnzippedFile = new FileOutputStream(unzippedFile);
						} catch (FileNotFoundException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo crear el archivo desempaquetado de Listas Negras");
						}

						int len;
						byte[] buffer = new byte[1024];
						try {
							while ((len = zipInputStream.read(buffer)) > 0) {
								fileOutputStreamUnzippedFile.write(buffer, 0, len);
							}
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo leer el archivo empaquetado de Listas Negras");
						}

						try {
							fileOutputStreamUnzippedFile.close();
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de escritura al archivo desempaquetado de Listas Negras");
						}

					}

					try {
						zipEntry = zipInputStream.getNextEntry();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo extraer el contenido del archivo empaquetado de Listas Negras");
					}
				}

			} finally {
				if (zipInputStream != null) {
					try {
						zipInputStream.close();
					} catch (IOException e) {
						logger.error(e.toString());
						internalError = "No se pudo cerrar el canal de lectura del archivo empaquetado de Listas Negras";
						continueProcess = false;
					}
				}
				if (fileOutputStreamUnzippedFile != null) {
					try {
						fileOutputStreamUnzippedFile.close();
					} catch (IOException e) {
						logger.error(e.toString());
						internalError = "No se pudo cerrar el canal de escritura al archivo desempaquetado de Listas Negras";
						continueProcess = false;
					}
				}
			}
		}

		if (continueProcess) {

			/* LOAD BLACK LIST INFORMATION TO DATABASE */
			CallableStatement executeSP = null;
			Connection connection = null;

			try {

				try {
					connection = ConnectionManager.newConnection();
				} catch (SQLException e) {
					logger.error(e.toString());
					internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
				} catch (Exception e) {
					logger.error("Exception: ", e);
					internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
				}
				if (logger.isDebugEnabled()) {
					logger.debug("Se estableci\u00f3 la conexi\u00f3n a la base de datos");
				}

				String query = "{ ? = call cob_credito..sp_carga_lista_negra() }";

				if (internalError == null) {
					try {
						executeSP = connection != null ? connection.prepareCall(query) : null;
					} catch (SQLException e) {
						logger.error(e.toString());
						internalError = "No se pudo preparar la sentencia SQL para cargar la informaci\u00f3n de Listas Negras";
					}
					if (logger.isDebugEnabled()) {
						logger.debug("Se preparó la sentencia SQL para la carga de información de Listas Negras");
					}
				}

				if (internalError == null) {
					try {
						if (executeSP != null) {
							executeSP.registerOutParameter(1, Types.INTEGER);
						}
					} catch (SQLException e) {
						logger.error(e.toString());
						internalError = "No se pudo registrar el valor de retorno del procedimiento SQL";
					}
				}

				if (internalError == null) {
					try {
						if (executeSP != null) {
							executeSP.execute();
						}
					} catch (SQLException e) {
						logger.error(e.toString());
						internalError = "No se pudo cargar la informaci\u00f3n de Listas Negras en la base de datos.";
					}
					if (logger.isDebugEnabled()) {
						logger.debug("Se ejecutó el proceso de carga de información de Listas Negras en la base de datos");
					}
				}

				if (internalError == null) {
					Integer returnValue = null;
					try {
						if (executeSP != null) {
							returnValue = executeSP.getInt(1);
						}
					} catch (SQLException e) {
						logger.error(e.toString());
						internalError = "No se pudo obtener la información de retorno de los parámetros de la ejecución de la sentencia SQL";
					}
					if (logger.isDebugEnabled()) {
						logger.debug("Valor de retorno del procedimiento de carga de Listas Negras: " + (returnValue != null ? returnValue.toString() : null));
					}

					if (returnValue != null && returnValue != 0) {
						internalError = "No se pudo realizar la carga de la nueva información de Listas Negras. Se deja la información actual.";
					}
				}

			} finally {
				try {
					ConnectionManager.saveConnection(connection);
				} catch (Exception e) {
					logger.error("Error al cerrar la conexión: ", e);
				}
			}
		}
		if (continueProcess) {

			/* COPY BLACK-LIST FILE TO HISTORICAL REPOSITORY */
			FileChannel srcChannelZipFile = null;
			FileChannel dstChannelZipFileHistoric = null;

			try {

				DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String currentDate = dateFormat.format(new Date());

				try {
					srcChannelZipFile = new FileInputStream(zipFile).getChannel();
				} catch (FileNotFoundException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo " + zipFile.getAbsolutePath());
				}

				try {
					dstChannelZipFileHistoric = new FileOutputStream(new File(historyPath + currentDate + "_" + zipFileName)).getChannel();
				} catch (FileNotFoundException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el destino " + historyPath);
				}

				try {
					dstChannelZipFileHistoric.transferFrom(srcChannelZipFile, 0, srcChannelZipFile.size());
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo " + zipFileName + " a Hist\u00f3ricos");
				}
				if (logger.isDebugEnabled()) {
					logger.debug("Se copi\u00f3 el archivo a los hist\u00f3ricos");
				}

			} finally {
				if (srcChannelZipFile != null) {
					try {
						srcChannelZipFile.close();
					} catch (IOException e) {
						logger.error(e.toString());
						internalError = "No se pudo cerrar el canal de lectura del archivo descargado de Listas Negras";
						continueProcess = false;
					}
				}
				if (dstChannelZipFileHistoric != null) {
					try {
						dstChannelZipFileHistoric.close();
					} catch (IOException e) {
						logger.error(e.toString());
						internalError = "No se pudo cerrar el canal de escritura del archivo de Listas Negras en Hist\u00f3ricos";
						continueProcess = false;
					}
				}
			}
		}

		if (continueProcess) {

			/* DELETE BLACK-LIST FILE PROCESSED */
			if (unzippedFile.delete()) {
				if (logger.isDebugEnabled()) {
					logger.debug("Se elimin\u00f3 de la carpeta de trabajo el archivo de Listas Negras ya procesado");
				}
			} else {
				throw new COBISInfrastructureRuntimeException("No se puede eliminar el archivo " + unzippedFile.getAbsolutePath() + " del servidor de base de datos");
			}

			/* DELETE BLACK-LIST FILE PROCESSED */
			if (zipFile.delete()) {
				if (logger.isDebugEnabled()) {
					logger.debug("Se elimin\u00f3 de la carpeta de trabajo el archivo empaquetado de Listas Negras");
				}
			} else {
				throw new COBISInfrastructureRuntimeException("No se puede eliminar el archivo " + zipFile.getAbsolutePath() + " del servidor de base de datos");
			}

		}

		if (continueProcess && internalError == null) {
			logger.info(messageOk);
			Email.send(from, to, cc, subject, messageOk, attachment);
		} else {
			throw new COBISInfrastructureRuntimeException(internalError);
		}

	}
}
