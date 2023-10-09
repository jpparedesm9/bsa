package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
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

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CargaNegativeFile extends NotificationGeneric implements Job {
	private static final Logger logger = Logger.getLogger(CargaNegativeFile.class);
	private static final String JOB_ACRONYM = "CRGNF";

	private String from;
	private String to;
	private String cc;
	private static final String subject = "Carga de Información de Negative File a la base COBIS";
	private static final String messageOk = "CARGA EXITOSA DEL ARCHIVO DE NEGATIVE FILE !!";
	private static final String messageError = "La carga falló con el siguiente error:\n\r";
	private String attachment = null;
	private String nameFilter;

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
				logger.debug("NGF-JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			loadNegativeFile();
		} catch (Exception ex) {
			logger.error("Error en execute - loadNegativeFile: " + ex.getStackTrace());
			Email.send(from, to, cc, subject, messageError + ex.getMessage(), attachment);
		}
	}

	private void loadNegativeFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia loadNegativeFile");
		}

		boolean continueProcess = true;
		String internalError = null;

		String fileName;
		String webServerPath;
		String dbServerPath;
		String historyPath;
		File originalFile = null;
		File originalServer = null;

		/* JOB PROPERTIES */
		InputStream inputStreamPropertiesFile = null;

		try {

			try {
				inputStreamPropertiesFile = new FileInputStream("notification/properties/" + JOB_ACRONYM + ".properties");
			} catch (FileNotFoundException e) {
				logger.error("NGF-No se pudo encontrar el archivo de configuraci\u00f3n: " + e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			Properties properties = new Properties();
			try {
				properties.load(inputStreamPropertiesFile);
			} catch (IOException e) {
				logger.error("NGF-No se pudo cargar archivo de configuraci\u00f3n: " + e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cargar archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se carg\u00f3 el archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			try {
				inputStreamPropertiesFile.close();
			} catch (IOException e) {
				logger.error(e.toString());
				logger.error("NGF-No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n: " + e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM);
			}

			fileName = properties.getProperty("fileName");
			webServerPath = properties.getProperty("webServerPath");
			dbServerPath = properties.getProperty("dbServerPath");
			historyPath = properties.getProperty("historyPath");
			from = properties.getProperty("from");
			to = properties.getProperty("to");
			cc = properties.getProperty("cc");

			nameFilter = fileName;

			if (logger.isDebugEnabled()) {
				logger.debug("fileName: " + fileName);
				logger.debug("webServerPath: " + webServerPath);
				logger.debug("dbServerPath: " + dbServerPath);
				logger.debug("historyPath: " + historyPath);
				logger.debug("from: " + from);
				logger.debug("to: " + to);
				logger.debug("cc: " + cc);
			}

		} finally {
			if (inputStreamPropertiesFile != null) {
				try {
					inputStreamPropertiesFile.close();
				} catch (IOException e) {
					logger.error("NGF-No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n" + e.toString());
					internalError = "No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + JOB_ACRONYM;
					continueProcess = false;
				}
			}
		}

		if (continueProcess) {

			if (logger.isDebugEnabled()) {
				logger.debug("NGF-AAA-Inicio el pase de archivo del servidor web al de base de datos ");
			}

			try {

				if (logger.isDebugEnabled()) {
					logger.debug("NGF-Ruta webServerPath del servidor WEB:" + webServerPath);
				}

				originalFile = new File(webServerPath);

				if (logger.isDebugEnabled()) {
					logger.debug("NGF-Ruta originalFile del servidor WEB:" + originalFile);
				}

				// logger.debug("NGF----->>CopiaB-originalFile listFiles:" +
				// originalFile.listFiles(textFilter).length);

				File[] fileList = originalFile.listFiles(textFilter);
				if (logger.isDebugEnabled()) {
					logger.debug("NGF-lista fileList:" + fileList);
				}
				if (fileList != null && fileList.length != 0) {
					if (logger.isDebugEnabled()) {
						logger.debug("NGF-Numero de archivos para mover: " + fileList.length);
					}
					for (int x = 0; x < fileList.length; x++) {
						/* MOVE DOWNLOADED NEGATIVE-FILE TO DATABASE SERVER */
						File downloadedFile = new File(webServerPath + fileList[x].getName());
						if (logger.isDebugEnabled()) {
							logger.debug("NGF-downloadedFile:" + downloadedFile);
						}
						File nombreArchivo = new File(dbServerPath + fileList[x].getName());
						if (!nombreArchivo.exists()) {
							if (downloadedFile.renameTo(nombreArchivo)) {
								if (logger.isDebugEnabled()) {
									logger.debug("NGF1-Se movi\u00f3 el archivo de Negative File al servidor de base de datos");
								}
							} else {
								internalError = "No se puede mover el archivo " + webServerPath + fileList[x].getName() + " al servidor de base de datos";
								continueProcess = false;
							}
						} else {
							nombreArchivo.delete();
							if (downloadedFile.renameTo(nombreArchivo)) {
								if (logger.isDebugEnabled()) {
									logger.debug("NGF2-Se movi\u00f3 el archivo de Negative File al servidor de base de datos");
								}
							} else {
								internalError = "No se puede mover el archivo " + webServerPath + fileList[x].getName() + " al servidor de base de datos";
								continueProcess = false;
							}
						}
					}
				} else {
					internalError = ("No existe ning\u00FAn archivo para cargar al servidor");
					continueProcess = false;
				}
			} catch (Exception e) {
				logger.error("NGF-Ocurrio un problema al intentar pasar el archivo al servidor de base de datos: " + e.toString());
				logger.error("NGF-Ocurrio un problema al intentar pasar el archivo al servidor de base de datos: ", e);
				internalError = "Ocurri\u00f3 un problema al intentar pasar el archivo al servidor de base de datos";
				continueProcess = false;
			}

		}

		if (continueProcess) {

			if (logger.isDebugEnabled()) {
				logger.debug("Inicio de archivos para procesar ");
			}

			if (internalError == null) {
				try {

					/* LOAD NEGATIVE FILE INFORMATION TO DATABASE */
					if (logger.isDebugEnabled()) {
						logger.debug("NGF-Ruta dbServerPath de la base de datos:" + dbServerPath);
					}
					originalServer = new File(dbServerPath);
					if (logger.isDebugEnabled()) {
						logger.debug("NGF-Ruta originalServer de la base de datos:" + originalServer);
					}

					/* filtro */
					File[] fileList = originalServer.listFiles(textFilter);

					if (fileList != null && fileList.length != 0) {
						for (int x = 0; x < fileList.length; x++) {

							CallableStatement executeSP = null;
							Connection connection = null;

							try {

								try {
									connection = ConnectionManager.newConnection();
								} catch (SQLException e) {
									logger.error("NGF-No se pudo establecer la conexi\u00f3n a la base de datos: " + e.toString());
									internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
								} catch (Exception e) {
									logger.error("NGF-Exception-No se pudo establecer la conexi\u00f3n a la base de datos: " + e.toString());
									logger.error("NGF-Exception: ", e);
									internalError = "No se pudo establecer la conexi\u00f3n a la base de datos";
								}
								if (logger.isDebugEnabled()) {
									logger.debug("B-NGF-Se estableci\u00f3 la conexi\u00f3n a la base de datos");
								}

								String query = "{ ? = call cob_credito..sp_carga_negative_file(?) }";
								String nameFile = fileList[x].getName();
								if (internalError == null) {
									try {
										executeSP = connection != null ? connection.prepareCall(query) : null;

									} catch (SQLException e) {
										logger.error("NGF-No se pudo preparar la sentencia SQL para cargar la informaci\u00f3n de Negative File: " + e.toString());
										internalError = "No se pudo preparar la sentencia SQL para cargar la informaci\u00f3n de Negative File";
									}
									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Se prepar\u00F3 la sentencia SQL para la carga de informaci\u00F3n de Negative File");
									}
								}

								if (internalError == null) {
									try {
										if (executeSP != null) {
											if (logger.isDebugEnabled()) {
												logger.debug("NGF-Archivo a Enviar:" + nameFile);
											}
											executeSP.setString(2, nameFile);

										}
									} catch (SQLException e) {
										logger.error("NGF-No se pudo enviar el par\u00E1metro de Negative File en la base de datos." + e.toString());
										internalError = "No se pudo enviar el par\u00E1metro de Negative File en la base de datos.";
									}
									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Se ejecut\u00F3 el proceso de carga de informaci\u00F3n de Negative File en la base de datos");
									}
								}

								if (internalError == null) {
									try {
										if (executeSP != null) {
											executeSP.registerOutParameter(1, Types.INTEGER);
										}
									} catch (SQLException e) {
										logger.error("NGF-No se pudo registrar el valor de salida del procedimiento SQL: " + e.toString());
										internalError = "No se pudo registrar el valor de salida del procedimiento SQL";
									}
									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Se ejecut\u00F3 el proceso de registrar el valor de salida del procedimiento SQL");
									}
								}

								if (internalError == null) {
									try {
										if (executeSP != null) {
											executeSP.execute();
										}
									} catch (SQLException e) {
										logger.error("NGF-No se pudo cargar la informaci\u00f3n de Negative File en la base de datos: " + e.toString());
										internalError = "No se pudo cargar la informaci\u00f3n de Negative File en la base de datos.";
									}
									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Se ejecuto el proceso de carga de informaci\u00f3n de Negative File en la base de datos");
									}
								}

								if (internalError == null) {
									Integer returnValue = null;
									try {
										if (executeSP != null) {
											returnValue = executeSP.getInt(1);
											logger.debug("NGF-returnValue: " + returnValue);
										}
									} catch (SQLException e) {
										logger.error("NGF-No se pudo obtener la información de salida de los parámetros de la ejecución de la sentencia SQL: " + e.toString());
										internalError = "No se pudo obtener la informaci\u00F3n de salida de los par\u00E1metros de la ejecuci\u00F3n de la sentencia SQL";
									}

									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Valor de salida del procedimiento de carga de Negative File: " + (returnValue != null ? returnValue.toString() : null));
									}

									if (returnValue != null && returnValue != 0) {
										internalError = "No se pudo realizar la carga de la nueva informaci\u00F3n de Negative File. Se deja la informaci\u00F3n actual.";
									}
								}
							} finally {
								try {
									ConnectionManager.saveConnection(connection);
								} catch (Exception e) {
									logger.error("NGF-Error al cerrar la conexión: ", e);
								}
							}

							/* MOVE DOWNLOADED NEGATIVE-FILE TO DATABASE SERVER */
							if (internalError == null) {
								try {
									File workFile = new File(dbServerPath + fileList[x].getName());
									File history = null;
									history = changePathHistorical(historyPath, "\\Descarga\\", fileList[x].getName());
									
									if (logger.isDebugEnabled()) {
										logger.debug("NGF-Negative File history" + history);
										logger.debug("NGF-Negative File  workFile" + workFile);
									}

									//File fileHistory = new File(history + fileList[x].getName());
									if (!history.exists()) {
										if (workFile.renameTo(history)) {
											if (logger.isDebugEnabled()) {
												logger.debug("NGF1-Se movi\u00f3 el archivo Negative file a la carpeta de Historicos");
											}
										} else {
											if (logger.isDebugEnabled())
												logger.debug("NGF1-No se puede mover el archivo " + dbServerPath + fileList[x].getName() + " a historicos");
											internalError = "No se puede mover el archivo " + dbServerPath + fileList[x].getName() + " a historicos";
											continueProcess = false;
										}
									} else {
										history.delete();
										if (workFile.renameTo(history)) {
											if (logger.isDebugEnabled()) {
												logger.debug("NGF2-Se movi\u00f3 el archivo Negative file a la carpeta de Historicos");
											}
										} else {
											if (logger.isDebugEnabled())
												logger.debug("NGF2-No se puede mover el archivo " + dbServerPath + fileList[x].getName() + " a historicos");
											internalError = "No se puede mover el archivo " + dbServerPath + fileList[x].getName() + " a historicos";
											continueProcess = false;
										}
									}

									// Se mueven los archivos al Historial
									/*
									 * if (workFile.renameTo(history)) { if
									 * (logger.isDebugEnabled()) { logger.debug(
									 * "NGF-Se movi\u00f3 el archivo Negative file a la carpeta de Historicos"
									 * ); } } else { internalError =
									 * "No se puede mover el archivo " +
									 * dbServerPath + fileList[x].getName() +
									 * " a historicos"; }
									 */
								} catch (IOException e) {
									logger.error("NGF-No se puede mover el archivo a hist\u00f3ricos ", e);
									internalError = "No se puede mover el archivo a hist\u00f3ricos " + fileList[x].getName();
								}
							}
						}
					} else {
						throw new COBISInfrastructureRuntimeException("No existe ning\u00FAn archivo para procesar");
					}

				} catch (Exception e) {
					logger.error("NGF-Ocurrio un problema al procesar el archivo: " + e.toString());
					logger.error("NGF-Ocurrio un problema al procesar el archivo: ", e);
					internalError = "Ocurri\u00f3 un problema al procesar el archivo";
				}
			}

		}

		if (logger.isDebugEnabled()) {
			logger.debug("NGF-Mensaje de InternalError:" + internalError);
		}

		if (continueProcess && internalError == null) {
			logger.info(messageOk);
			Email.send(from, to, cc, subject, messageOk, attachment);
		} else {
			throw new COBISInfrastructureRuntimeException(internalError);
		}

	}

	FilenameFilter textFilter = new FilenameFilter() {
		public boolean accept(File dir, String name) {

			if (logger.isDebugEnabled())
				logger.debug("NGF-Inicia textFilter");

			logger.debug("NGF-Inicio-FilenameFilter");
			String fileExt;
			String startFileName;
			Integer index;
			Integer digit;
			index = nameFilter.indexOf(" ");
			fileExt = nameFilter.substring(nameFilter.indexOf("."), nameFilter.length());
			digit = (nameFilter.substring(0, nameFilter.indexOf(" ")).length());

			if (logger.isDebugEnabled()) {
				logger.debug("NGF-FilenameFilter-index:" + index);
				logger.debug("NGF-FilenameFilter-fileExt:" + fileExt);
				logger.debug("NGF-FilenameFilter-digit:" + digit);
			}

			if (name.endsWith(fileExt)) {
				startFileName = name.substring(0, index);
				if (startFileName.length() == digit) {
					try {
						Integer.parseInt(startFileName);
						return true;
					} catch (NumberFormatException e) {
						return false;
					}
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	};

	public static File changePathHistorical(String sourceFile, String type, String originalFile) throws IOException {

		try {
			DateFormat dateFormat = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
			Date date = new Date();
			String fileNameToHistorical = sourceFile + type + dateFormat.format(date) + originalFile;
			File fileToHistory = new File(fileNameToHistorical);

			if (logger.isDebugEnabled())
				logger.debug("Archivo para el historico: " + fileNameToHistorical);

			File historyInFolder = new File(fileToHistory.getParent());
			logger.debug("Ver el getParent historyNegativeInFolder: " + fileToHistory.getParent());
			logger.debug("Absolute Path de historyNegativeInFolder: " + historyInFolder.getAbsolutePath());

			if (!historyInFolder.exists()) {
				if (!historyInFolder.mkdirs()) {
					throw new COBISInfrastructureRuntimeException("No se puede crear la carpeta de entrada para historial");
				} else if (logger.isDebugEnabled()) {
					logger.debug("Creación de la carpeta de History: [" + historyInFolder.getAbsolutePath() + "]");
				}
			}
			return new File(fileNameToHistorical);
		} finally {
			// TODO
		}
	}

}
