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
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaReporteConsultados implements Job{
	
	private static final Logger LOGGER = Logger.getLogger(CopiaReporteConsultados.class);
	private static final String JOB_ACRONYM = "CPYRCC";

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			loadReportClients();
		} catch (Exception ex) {
			LOGGER.error(ex);
		}
	}
	
	@SuppressWarnings("resource")
	private void loadReportClients() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia loadReportClients");
		}

		boolean continueProcess = true;
		String internalError = null;

		String zipFileName = null;
		String webServerPath;
		String dbServerPath;
		String historyPath;
		
		File zipFile = null;
		File dropFile = null;
		
		FileInputStream fileInputStreamZip = null;
		ZipOutputStream zipOutputStream = null;
		
		/* JOB PROPERTIES */
		InputStream inputStreamPropertiesFile = null;

		try {

			try {
				inputStreamPropertiesFile = new FileInputStream("notification/properties/" + JOB_ACRONYM + ".properties");
			} catch (FileNotFoundException e) {
				LOGGER.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			Properties properties = new Properties();
			try {
				properties.load(inputStreamPropertiesFile);
			} catch (IOException e) {
				LOGGER.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cargar archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Se carg\u00f3 el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			try {
				inputStreamPropertiesFile.close();
			} catch (IOException e) {
				LOGGER.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			webServerPath = properties.getProperty("webServerPath");
			dbServerPath = properties.getProperty("dbServerPath");
			historyPath = properties.getProperty("historyPath");

			if (LOGGER.isTraceEnabled()) {
				LOGGER.trace("webServerPath: " + webServerPath);
				LOGGER.trace("dbServerPath: " + dbServerPath);
				LOGGER.trace("historyPath: " + historyPath);
			}

		} finally {
			if (inputStreamPropertiesFile != null) {
				try {
					inputStreamPropertiesFile.close();
				} catch (IOException e) {
					LOGGER.error(e.toString());
					internalError = "No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM;
					continueProcess = false;
				}
			}
		}
		
		if (continueProcess) {
			
			java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			
			CallableStatement executeSP = null;
			Connection connection = null;

			try {

				try {
					connection = ConnectionManager.newConnection();
				} catch (SQLException e) {
					LOGGER.error(e.toString());
					internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
				} catch (Exception e) {
					LOGGER.error("Exception: ", e);
					internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se estableci\u00f3 la conexi\u00f3n a la base de datos");
				}

				String query = "{ ? = call cobis..sp_reporte_clientes_consultados(?) }";

				if (internalError == null) {
					try {
						executeSP = connection != null ? connection.prepareCall(query) : null;
					} catch (SQLException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo preparar la sentencia SQL para generar el reporte de clientes consultados. ";
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se preparó la sentencia SQL para la generacion del reporte de clientes consultados. ");
					}
				}

				if (internalError == null) {
					try {
						if (executeSP != null) {
							executeSP.registerOutParameter(1, Types.INTEGER);
							executeSP.setDate(2, date);
						}
					} catch (SQLException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo registrar el valor de retorno del procedimiento SQL";
					}
				}

				if (internalError == null) {
					try {
						if (executeSP != null) {
							executeSP.execute();
						}
					} catch (SQLException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo generar el reporte de clientetes consultados en la base de datos.";
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se ejecutó el proceso para la generacion del reporte en la base de datos");
					}
				}

				if (internalError == null) {
					Integer returnValue = null;
					try {
						if (executeSP != null) {
							returnValue = executeSP.getInt(1);
						}
					} catch (SQLException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo obtener la información de retorno de los parámetros de la ejecución de la sentencia SQL";
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Valor de retorno del procedimiento de reportes de clientes consultados: " + (returnValue != null ? returnValue.toString() : null));
					}

					if (returnValue != null && returnValue != 0) {
						continueProcess = false;
						internalError = "No se pudo realizar la generacion del reporte de clientes consultados.";
					}
				}

			} finally {
				try {
					ConnectionManager.saveConnection(connection);
				} catch (Exception e) {
					LOGGER.error("Error al cerrar la conexión: ", e);
				}
			}
		}
		
		if (continueProcess) {
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			Date date = new Date();
	        String currentDate = dateFormat.format(date);
			String fileName = "REPORTE_CLIENTES_" + currentDate + ".txt";
			
			try {
				zipFileName = fileName.replace(".txt", ".zip");

				dropFile = new File(dbServerPath + fileName);
				zipFile = new File(dbServerPath + zipFileName);

				try {
					zipOutputStream = new ZipOutputStream(new FileOutputStream(dbServerPath + zipFileName));
				} catch (FileNotFoundException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo zip " + dbServerPath + zipFileName);
				}

				ZipEntry entrada = new ZipEntry(fileName);
				try {
					zipOutputStream.putNextEntry(entrada);
				} catch (IOException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo zip" + dbServerPath + zipFileName);
				}

				try {
					fileInputStreamZip = new FileInputStream(dbServerPath + entrada.getName());
				} catch (FileNotFoundException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo zip " + dbServerPath + entrada.getName());
				}

				int len;
				byte[] buffer = new byte[1024];

				try {
					while (0 < (len = fileInputStreamZip.read(buffer))) {
						zipOutputStream.write(buffer, 0, len);
					}
				} catch (IOException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo crear el archivo zip de Reporte clientes consultados");
				}

				try {
					zipOutputStream.closeEntry();
				} catch (IOException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de lectura del archivo de reporte clientes consultados");
				}

				try {
					zipOutputStream.close();
				} catch (IOException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de escritura el archivo de reporte clientes consultados");
				}

			} finally {
				if (fileInputStreamZip != null) {
					try {
						fileInputStreamZip.close();
					} catch (IOException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo cerrar el canal de lectura del archivo empaquetado del reporte de clientes consultados. ";
						continueProcess = false;
					}
				}
				if (zipOutputStream != null) {
					try {
						zipOutputStream.close();
					} catch (IOException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo cerrar el canal de escritura al archivo desempaquetado del reporte de clientes consultados. ";
						continueProcess = false;
					}
				}
			}
		}
		
		if (continueProcess) {

			/* COPY REPORTS OF CONSULTED CLIENTS FILE TO HISTORICAL REPOSITORY */
			FileChannel srcChannelZipFile = null;
			FileChannel dstChannelZipFileHistoric = null;
			try {

				try {
					srcChannelZipFile = new FileInputStream(zipFile).getChannel();
				} catch (FileNotFoundException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo " + zipFile.getAbsolutePath());
				}

				try {
					dstChannelZipFileHistoric = new FileOutputStream(new File(historyPath + zipFileName)).getChannel();
				} catch (FileNotFoundException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede encontrar el destino " + historyPath);
				}

				try {
					dstChannelZipFileHistoric.transferFrom(srcChannelZipFile, 0, srcChannelZipFile.size());
				} catch (IOException e) {
					LOGGER.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo " + zipFileName + " a Hist\u00f3ricos");
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se copi\u00f3 el archivo a los hist\u00f3ricos");
				}

			} finally {
				if (srcChannelZipFile != null) {
					try {
						srcChannelZipFile.close();
					} catch (IOException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo cerrar el canal de lectura del archivo";
						continueProcess = false;
					}
				}
				if (dstChannelZipFileHistoric != null) {
					try {
						dstChannelZipFileHistoric.close();
					} catch (IOException e) {
						LOGGER.error(e.toString());
						internalError = "No se pudo cerrar el canal de escritura del archivo en Hist\u00f3ricos";
						continueProcess = false;
					}
				}
			}
		}
		
		if (continueProcess) {
			/* MOVE DOWNLOADED REPORTS OF CONSULTED CLIENTS FILE TO DATABASE SERVER */
			File moveFile = new File(dbServerPath + zipFileName);
			if (moveFile.renameTo(new File(webServerPath + zipFileName))) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se movi\u00f3 el archivo zip del reporte de clientes consultados al servidor de FTP");
				}
			} else {
				throw new COBISInfrastructureRuntimeException("No se puede mover el archivo " + webServerPath + zipFileName + " al servidor FTP");
			}
		}

		if (continueProcess) {
			/* DELETE REPORTS OF CONSULTED CLIENTS FILE PROCESSED */
			if (dropFile.delete()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se elimin\u00f3 de la carpeta de trabajo el reporte de clientes consultados ya procesado");
				}
			} else {
				throw new COBISInfrastructureRuntimeException("No se puede eliminar el archivo " + dropFile.getAbsolutePath() + " del servidor de base de datos");
			}
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Se generó el reporte de clientes consultados exitosamente. ");
			}
		}
	}
}
