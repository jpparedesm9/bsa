package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;

import com.cobiscorp.cloud.scheduler.utils.dto.DataArchivo;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.jcraft.jsch.SftpException;

public class UploadFileJob extends FileExchangeJob {
	private static final Logger LOGGER = Logger.getLogger(UploadFileJob.class);
	private String proceso;
	String actualPatterns = null;

	public UploadFileJob(Job process) {
		super(process);
		proceso = null;
	}

	public FileExchangeResponse uploadFiles(String proceso) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("proceso: " + proceso);
		}
		this.proceso = proceso;
		ReportarArchivos.getInstance().limpiarArchivos(proceso);
		return uploadFiles();
	}

	public FileExchangeResponse uploadFiles() {
		boolean continueProcess = true;
		String internalError = null;

		try {
			try {
				/* Se inicia la conexión */
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo iniciar la conexi\u00f3n");
			}
			try {
				LOGGER.debug("La carpeta de cargas es : " + getRemoteUploadPath());
				getChannelSftp().cd(getRemoteUploadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para carga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para carga");
			}

			LOGGER.debug("directorio Origen de archivos: " + getWorkFolder());
			File f = new File(getWorkFolder());
			if (!f.exists()) {
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta local para carga");
			}

			FilenameFilter textFilter = new FilenameFilter() {
				public boolean accept(File dir, String name) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("actualPatterns: " + actualPatterns);
						LOGGER.debug("name: " + name);
						LOGGER.debug("dir: " + dir);
					}

					String fileExt;
					
					String startFileName;
					String halfName;
					Integer index;
					Integer digit;
					index = actualPatterns.indexOf("?");
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("index: " + index);
					}
					fileExt = (actualPatterns.indexOf(".") > 0)  ? actualPatterns.substring(actualPatterns.indexOf("."), actualPatterns.length()) : "#";
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("fileExt: " + fileExt);
					}
					startFileName = actualPatterns.substring(0, index);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("startFileName: " + startFileName);
					}
					digit = (actualPatterns.indexOf(".") > 0) ? (actualPatterns.substring(index, actualPatterns.indexOf(".")).length())
							: actualPatterns.substring(index, actualPatterns.length()).length();
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("digit: " + digit);
					}

					if (name.endsWith(fileExt)) {
						if (name.startsWith(startFileName)) {
							halfName = name.substring(index, name.indexOf("."));
							if (halfName.length() == digit) {
								try {
									Float.parseFloat(halfName);
									return true;
								} catch (NumberFormatException e) {
									return byNumberPattern(name);
								}
							} else {
								return false;
							}
						} else {
							return false;
						}
					} else {
						if (name.startsWith(startFileName)) {
							halfName = name.substring(index, name.length());
							if (halfName.length() == digit) {
								try {
									Float.parseFloat(halfName);
									return true;
								} catch (NumberFormatException e) {
									return byNumberPattern(name);
								}
							} else {
								return false;
							}
						} else {
							return false;
						}
					}
				}
			};

			File workFile = null;
			// File[] fileList = f.listFiles(textFilter);

			String[] patterns = getFileNameUpload().split("\\|");

			// File[] fileList = f.listFiles(new WildcardFileFilter(patterns[0]));
			List<File> fileList = new ArrayList<File>();
			for (int i = 0; i < patterns.length; i++) {
				actualPatterns = patterns[i];
				LOGGER.debug("Paso34 : " + actualPatterns);
				fileList.addAll(new ArrayList<File>(Arrays.asList(f.listFiles(textFilter))));
			}

			LOGGER.debug("Paso el filtro ");

			if (fileList.size() != 0) {
				for (File actualFile : fileList) {
					try {
						workFile = new File(getWorkFolder() + actualFile.getName());
						LOGGER.debug("El archivo a subir es " + actualFile.getName());
						getChannelSftp().put(workFile.toString(), actualFile.getName());
						workFile.delete();
						if (proceso != null) {
							DataArchivo da = new DataArchivo();
							da.setDestino(getRemoteUploadPath());
							da.setArchivo(actualFile.getName());
							da.setTamano(actualFile.length());
							da.setFecha(new Date());
							ReportarArchivos.getInstance().addArchivo(proceso, da);
						}
					} catch (SftpException e) {
						LOGGER.error("No se puede cargar la informaci\u00f3n del archivo " + actualFile.getName() + ":", e);
						throw new COBISInfrastructureRuntimeException("No se puede cargar el archivo " + actualFile.getName());
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se carga en el servidor el archivo " + actualFile.getName());
					}
				}
			} else {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA CARGAR");
			}
		} finally {

			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	private boolean byNumberPattern(String filename) {
		String patternMatch = actualPatterns.replaceAll("\\?", "[0-9]");
		Pattern pattern = Pattern.compile(patternMatch);
		Matcher matcher = pattern.matcher(filename);
		if (matcher.find())
			return true;
		return false;
	}
	
	public FileExchangeResponse uploadFilesWithDatePatter() {
		boolean continueProcess = true;
		String internalError = null;
		try {
			try {
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo iniciar la conexi\u00f3n");
			}
			try {
				LOGGER.error("La carpeta de cargas es : " + getRemoteUploadPath());
				getChannelSftp().cd(getRemoteUploadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para carga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para carga");
			}

			File f = new File(getUploadPath());
			if (!f.exists()) {
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta local para carga: " + getUploadPath());
			}

			String nameUploadFile = Util.validateDateFormat(getFileNameUpload());
			File upFile = new File(getUploadPath() + nameUploadFile);
			LOGGER.debug("Archivo a cargar: " + getUploadPath() + nameUploadFile);
			if (!upFile.exists()) {
				throw new COBISInfrastructureRuntimeException("Error archivo a cargar no existe");
			}

			List<File> fileList = new ArrayList<File>();
			fileList.add(upFile);

			LOGGER.debug("Paso el filtro ");

			if (fileList.size() != 0) {
				for (File actualFile : fileList) {
					try {
						LOGGER.debug("El archivo a subir es " + actualFile.getAbsolutePath().toString() + actualFile.getName());
						getChannelSftp().put(actualFile.getAbsolutePath().toString(), actualFile.getName());
					} catch (SftpException e) {
						LOGGER.error("No se puede cargar la informaci\u00f3n del archivo " + actualFile.getName() + ":", e);
						throw new COBISInfrastructureRuntimeException("No se puede cargar el archivo " + actualFile.getName());
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se carga en el servidor el archivo " + actualFile.getName());
					}
				}
			} else {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA CARGAR");
			}
		} finally {
			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public void chageNameUpload() {
		File f = new File(getUploadPath());
		if (!f.exists()) {
			throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta local para carga");
		}
		FilenameFilter textFilter = new FilenameFilter() {
			public boolean accept(File dir, String name) {
				String fileExt;
				String startFileName;
				String halfName;
				Integer index;
				Integer digit;
				index = actualPatterns.indexOf("?");
				fileExt = actualPatterns.substring(actualPatterns.indexOf("."), actualPatterns.length());
				startFileName = actualPatterns.substring(0, index);
				digit = (actualPatterns.substring(index, actualPatterns.indexOf(".")).length() + getToUploadExtract());

				LOGGER.debug("fileExt " + fileExt);
				LOGGER.debug("startFileName " + startFileName);
				LOGGER.debug("digit " + digit);

				if (name.endsWith(fileExt)) {
					if (name.startsWith(startFileName)) {
						halfName = name.substring(index, name.indexOf("."));
						if (halfName.length() == digit) {
							try {
								Float.parseFloat(halfName);
								LOGGER.debug("actualPatterns actual: " + actualPatterns);
								LOGGER.debug("name que pasa: " + name);
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
				} else {
					return false;
				}
			}
		};

		String fileExt;
		String finalFileName;
		String fileName;

		File originFile = null;
		File workFile = null;
		File historyFile = null;

		String[] patterns = getFileNameUpload().split("\\|");

		// File[] fileList = f.listFiles(new WildcardFileFilter(patterns[0]));
		List<File> fileList = new ArrayList<File>();
		for (int i = 0; i < patterns.length; i++) {
			actualPatterns = patterns[i];
			fileList.addAll(new ArrayList<File>(Arrays.asList(f.listFiles(textFilter))));
		}

		LOGGER.debug("Paso el filtro ");

		if (fileList.size() != 0) {
			for (File actualFile : fileList) {
				try {
					originFile = new File(getUploadPath() + actualFile.getName());
					/* mover a HISTORICO */
					try {
						historyFile = changePathHistorical(getHistoryPath(), "\\Carga\\", actualFile.getName());
						copyFile(originFile, historyFile);
					} catch (IOException e) {
						LOGGER.error("No se puede mover el archivo a hist\u00f3ricos " + actualFile.getName() + ":", e);
						throw new COBISInfrastructureRuntimeException("No se puede mover el archivo a hist\u00f3ricos " + actualFile.getName());
					}

					fileName = actualFile.getName();
					fileExt = fileName.substring(fileName.indexOf("."), fileName.length());
					finalFileName = fileName.substring(0, fileName.indexOf(".") - getToUploadExtract());
					finalFileName = finalFileName + fileExt;

					workFile = new File(getWorkFolder() + finalFileName);
					copyFile(originFile, workFile);
					originFile.delete();
				} catch (IOException e) {
					LOGGER.error("No se puede mover el archivo desde IEN a la carpeta de trabajo " + actualFile.getName() + ":", e);
					throw new COBISInfrastructureRuntimeException("No se puede mover el archivo desde IEN a la carpeta de trabajo " + actualFile.getName());
				}
			}
		} else {
			throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA CARGAR");
		}

	}

	public FileExchangeResponse uploadFilesPattern() {
		boolean continueProcess = true;
		String internalError = null;
		try {
			try {
				/* Se inicia la conexión */
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo iniciar la conexi\u00f3n");
			}
			try {
				LOGGER.debug("La carpeta de cargas es : " + getRemoteUploadPath());
				getChannelSftp().cd(getRemoteUploadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para carga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para carga");
			}

			File f = new File(getWorkFolder());
			if (!f.exists()) {
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta local para carga");
			}

			File workFile = null;

			String[] patterns = getFileNameUpload().split("\\|");
			LOGGER.debug("patterns" + patterns);

			for (int i = 0; i < patterns.length; i++) {
				System.out.println("patterns" + i + "" + patterns[i]);
			}

			Collection fileCollection = FileUtils.listFiles(f, new WildcardFileFilter(patterns[0]), null);
			for (int i = 1; i < patterns.length; i++) {
				fileCollection.addAll(FileUtils.listFiles(f, new WildcardFileFilter(patterns[i]), null));

			}

			if (fileCollection.size() == 0) {
				LOGGER.debug("No existe archivos en el directorio origen: " + getWorkFolder());
				return new FileExchangeResponse(true, "No existe archivos a procesar");
			}

			File[] fileList = new File[fileCollection.size()];
			int iterador = 0;
			for (Object found : fileCollection) {
				String fileToZip = ((File) found).getName();
				LOGGER.debug("obeto a ziper" + ((File) found).getName());
				fileList[iterador] = (File) found;
				iterador = iterador + 1;
				LOGGER.debug("iterador++  " + iterador);
			}

			LOGGER.debug("Paso el filtro  por pattern");
			if (fileList.length != 0) {

				for (File actualFile : fileList) {
					try {
						workFile = new File(getWorkFolder() + actualFile.getName());
						LOGGER.debug("El archivo a subir es " + actualFile.getName());
						getChannelSftp().put(workFile.toString(), actualFile.getName());
						File historyFile = new File(getHistoryPath() + actualFile.getName());

						LOGGER.debug("Archivo historico " + historyFile.getAbsolutePath());
						try {
							copyFile(workFile, historyFile);
							workFile.delete();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							LOGGER.error("No se puede mover el archivo a Historicos " + actualFile.getName() + ":", e);
						}

					} catch (SftpException e) {
						LOGGER.error("No se puede cargar la informaci\u00f3n del archivo " + actualFile.getName() + ":", e);
						throw new COBISInfrastructureRuntimeException("No se puede cargar el archivo " + actualFile.getName());
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se carga en el servidor el archivo " + actualFile.getName());
					}
				}
			} else {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA CARGAR");
			}
		} finally {

			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public String getProceso() {
		return proceso;
	}

	public void setProceso(String proceso) {
		this.proceso = proceso;
	}

	public FileExchangeResponse uploadFilesR(String proceso) {
		this.proceso = proceso;
		ReportarArchivos.getInstance().limpiarArchivos(proceso);
		return uploadFilesR();
	}

	public FileExchangeResponse uploadFilesR() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa uploadFilesR");
		}

		boolean continueProcess = true;
		String internalError = null;

		try {
			try {
				/* Se inicia la conexión */
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo iniciar la conexi\u00f3n");
			}
			try {
				LOGGER.debug("La carpeta de cargas es : " + getRemoteUploadPath());
				getChannelSftp().cd(getRemoteUploadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para carga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para carga");
			}

			LOGGER.debug("directorio Origen de archivos: " + getWorkFolder());
			File f = new File(getWorkFolder());
			if (!f.exists()) {
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta local para carga");
			}

			FilenameFilter textFilter = new FilenameFilter() {
				public boolean accept(File dir, String name) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("actualPatterns: " + actualPatterns);
						LOGGER.debug("name: " + name);
						LOGGER.debug("dir: " + dir);
					}

					String fileExt;

					String startFileName;
					String halfName;
					Integer index;
					Integer digit;
					index = actualPatterns.indexOf(".");
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("index: " + index);
					}
					fileExt = (actualPatterns.indexOf(".") > 0) ? actualPatterns.substring(actualPatterns.indexOf("."), actualPatterns.length()) : "#";
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("fileExt: " + fileExt);
					}
					startFileName = actualPatterns.substring(0, index);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("startFileName: " + startFileName);
					}
					digit = (actualPatterns.indexOf(".") > 0) ? (actualPatterns.substring(index, actualPatterns.indexOf(".")).length())
							: actualPatterns.substring(index, actualPatterns.length()).length();
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("digit: " + digit);
					}

					if (name.endsWith(fileExt)) {
						if (name.startsWith(startFileName)) {
							halfName = name.substring(index, name.indexOf("."));
							if (LOGGER.isDebugEnabled()) {
								LOGGER.debug("halfName1: " + halfName);
							}
							if (halfName.length() == digit) {
								try {
									Float.parseFloat(halfName);
									return true;
								} catch (NumberFormatException e) {
									return byNumberPattern(name);
								}
							} else {
								return false;
							}
						} else {
							return false;
						}
					} else {
						if (name.startsWith(startFileName)) {
							halfName = name.substring(index, name.length());
							if (LOGGER.isDebugEnabled()) {
								LOGGER.debug("halfName2: " + halfName);
							}
							if (halfName.length() == digit) {
								try {
									Float.parseFloat(halfName);
									return true;
								} catch (NumberFormatException e) {
									return byNumberPattern(name);
								}
							} else {
								return false;
							}
						} else {
							return false;
						}
					}
				}
			};

			File workFile = null;

			String[] patterns = getFileNameUpload().split("\\|");

			List<File> fileList = new ArrayList<File>();
			for (int i = 0; i < patterns.length; i++) {
				actualPatterns = patterns[i];
				LOGGER.debug("Paso34 : " + actualPatterns);
				fileList.addAll(new ArrayList<File>(Arrays.asList(f.listFiles(textFilter))));
			}

			LOGGER.debug("Paso el filtro ");

			if (fileList.size() != 0) {
				for (File actualFile : fileList) {
					try {
						workFile = new File(getWorkFolder() + actualFile.getName());
						LOGGER.debug("El archivo a subir es " + actualFile.getName());
						getChannelSftp().put(workFile.toString(), actualFile.getName());
						workFile.delete();
						if (proceso != null) {
							DataArchivo da = new DataArchivo();
							da.setDestino(getRemoteUploadPath());
							da.setArchivo(actualFile.getName());
							da.setTamano(actualFile.length());
							da.setFecha(new Date());
							ReportarArchivos.getInstance().addArchivo(proceso, da);
						}
					} catch (SftpException e) {
						LOGGER.error("No se puede cargar la informaci\u00f3n del archivo " + actualFile.getName() + ":", e);
						throw new COBISInfrastructureRuntimeException("No se puede cargar el archivo " + actualFile.getName());
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Se carga en el servidor el archivo " + actualFile.getName());
					}
				}
			} else {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA CARGAR");
			}
		} finally {

			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}
}
