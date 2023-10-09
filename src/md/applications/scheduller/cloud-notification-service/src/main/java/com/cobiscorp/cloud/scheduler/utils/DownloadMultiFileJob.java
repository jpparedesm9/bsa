package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Vector;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;

import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

public class DownloadMultiFileJob extends FileExchangeJob {
	private static final Logger LOGGER = Logger.getLogger(DownloadMultiFileJob.class);

	public DownloadMultiFileJob(Job process) {
		super(process);
	}

	private String[] getPatterns(String getDownloadFilePattern) {

		String[] patterns = getDownloadFilePattern.split("\\|");

		for (int i = 0; i < patterns.length; i++) {
			LOGGER.debug("Patterns # " + i + " " + patterns[i]);

		}

		return patterns;
	}

	private String downloadSFTP(LsEntry lsEntry) {
		LOGGER.debug("Inica descarga del SFTP");

		OutputStream outputStreamFile = null;
		String fileName;
		SftpATTRS sftpATTRS = null;

		try {

			fileName = lsEntry.getFilename();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Archivo actual en proceso: " + fileName);
			}

			try {
				sftpATTRS = getChannelSftp().lstat(fileName);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("sftpATTRS " + fileName + ": " + sftpATTRS.toString());
				}
			} catch (SftpException e) {
				LOGGER.error("Error al querer ver atributos del archivo " + fileName + ":", e);
				throw new COBISInfrastructureRuntimeException("Error al querer ver atributos del archivo " + fileName);
			}

			try {
				outputStreamFile = new FileOutputStream(getWorkFolder() + fileName);
			} catch (FileNotFoundException e) {
				LOGGER.error("No se puede crear el archivo de descarga " + fileName + ":", e);
				throw new COBISInfrastructureRuntimeException("No se puede crear el archivo de descarga " + fileName);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Se cre\u00f3 el archivo de descarga " + fileName);
			}

			try {
				getChannelSftp().get(fileName, outputStreamFile);
			} catch (SftpException e) {
				LOGGER.error("No se puede descargar la informaci\u00f3n del archivo en la carpeta local " + fileName + ":", e);
				throw new COBISInfrastructureRuntimeException("No se puede descargar la informaci\u00f3n del archivo en la carpeta local " + fileName);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Se descarg\u00f3 la informaci\u00f3n del archivo " + fileName);
			}

			try {
				outputStreamFile.close();
			} catch (IOException e) {
				LOGGER.error("No se puede cerrar el archivo " + fileName + ":", e);
				throw new COBISInfrastructureRuntimeException("No se puede cerrar el archivo " + fileName);
			}

		} finally {
			if (outputStreamFile != null) {
				try {
					outputStreamFile.close();
				} catch (IOException e) {
					LOGGER.error(e.toString());
				}
			}
		}

		LOGGER.debug("Finaliza descarga del SFTP");

		return fileName;

	}

	private FileExchangeResponse decompressZipInWorkFolder(String pathFile, String nameFile) {
		LOGGER.debug("Incia Proceso de descompresión");

		File workZipFile = null;
		FileExchangeResponse fileExchangeResponseZip = new FileExchangeResponse(true, "");
		String errorMessage = null;

		try {
			workZipFile = new File(pathFile + nameFile);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Archivo de trabajo: " + workZipFile.getAbsolutePath());

			}
			fileExchangeResponseZip = FileUtil.extractZipFile(pathFile, nameFile);

		} catch (Exception e) {

			errorMessage = "No se puede descomprimir el zip y copiar para procesar " + nameFile;

			fileExchangeResponseZip.setSuccess(false);
			fileExchangeResponseZip.setErrorMessage(errorMessage);

			LOGGER.error(errorMessage, e);
			throw new COBISInfrastructureRuntimeException("No se puede descomprimir el zip y copiar para procesar " + nameFile);

		}
		LOGGER.debug("Finaliza Proceso de descompresión");

		return fileExchangeResponseZip;

	}

	private FileExchangeResponse getFiles(Vector<LsEntry> lsEntries, String nombreFile, boolean diferentContent) {

		LOGGER.debug("Ingreso a obtener el listado de pattner: " + nombreFile);

		boolean continueProcess = true;
		String internalError = null;

		String fileName = null;
		boolean deleteFileSftp = false;

		for (ChannelSftp.LsEntry lsEntry : lsEntries) {

			// Descarga del archivo
			fileName = downloadSFTP(lsEntry);
			LOGGER.debug("Archivo descargado: " + fileName);

			if (fileName == null) {
				continueProcess = false;
				internalError = "No se puede obtener el nombre del archivo descargado";
				return new FileExchangeResponse(continueProcess, internalError);
			}

			// Descompresion de archivo zip

			FileExchangeResponse fileExchangeResponseZip = decompressZipInWorkFolder(getWorkFolder(), fileName);

			if (!fileExchangeResponseZip.isSuccess()) {
				continueProcess = false;
				internalError = "No se puede descomprimir el archivo " + fileName;
				return new FileExchangeResponse(continueProcess, internalError);

			}

			// Copiar y eliminación de archivos

			try {
				deleteFileSftp = copyFilesToFolderInProgress(diferentContent, fileName);
			} catch (IOException e1) {
				LOGGER.error(e1.toString());
				continueProcess = false;
				internalError = "No se logro copiar los archivos a procesar de " + fileName;
				return new FileExchangeResponse(continueProcess, internalError);
			}

			/* DELETE ORIGINAL FILE AT HOST */
			if (deleteFileSftp) {
				try {

					getChannelSftp().rm(fileName);
				} catch (SftpException e) {
					LOGGER.error(e.toString());

				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se elimin\u00f3 el archivo de facturaci\u00f3n del servidor anfitri\u00f3n");
				}
			}

		}

		return new FileExchangeResponse(continueProcess, internalError);

	}

	public FileExchangeResponse downloadFiles(boolean diferentNameContent) {

		FileExchangeResponse fileExchangeResponse = null;
		Vector<ChannelSftp.LsEntry> lsEntries = null;

		try {
			try {
				// Inicia conexión
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo inciar la conexi\u00f3n");
			}

			try {
				LOGGER.debug("La carpeta de descargas es : " + getRemoteDownloadPath());
				getChannelSftp().cd(getRemoteDownloadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para descarga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para descarga");
			}

			try {
				LOGGER.error("El pattern para descarga es: " + getDownloadFilePattern());
				String[] patterns = getPatterns(getDownloadFilePattern());
				LOGGER.error("Inicia metodo de descarga de archivos");
				for (String nameFile : patterns) {
					lsEntries = getChannelSftp().ls(nameFile);
					if (!lsEntries.isEmpty()) {
						fileExchangeResponse = getFiles(lsEntries, nameFile, diferentNameContent);
					}
				}

			} catch (SftpException e) {
				LOGGER.error("Error al buscar archivos para descarga:", e);
				throw new COBISInfrastructureRuntimeException("Error al buscar archivos para descarga");
			}

			if (lsEntries == null || lsEntries.isEmpty()) {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA DESCARGAR");
			}

		} finally {

			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return fileExchangeResponse;
	}

	public File[] getListFiles(String workFolder, String fileNamePattern) {
		File[] fileList = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia getlistFiles");
		}

		File directory = new File(workFolder);

		if (!directory.exists() || !directory.isDirectory()) {
			LOGGER.debug("No existe el directorio origen: " + workFolder);
			return fileList;
		}

		String[] patterns = fileNamePattern.split("\\|");

		for (int i = 0; i < patterns.length; i++) {
			LOGGER.debug("patterns" + i + "" + patterns[i]);
		}

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));

		}
		if (fileCollection.isEmpty()) {
			LOGGER.debug("No existen archivos para copiar");
		}
		fileList = new File[fileCollection.size()];
		int iterador = 0;
		for (Object found : fileCollection) {
			String fileToZip = ((File) found).getName();
			System.out.println("obeto a ziper" + ((File) found).getName());
			fileList[iterador] = (File) found;
			iterador = iterador + 1;
			System.out.println("iterador++  " + iterador);
		}

		return fileList;
	}

	public boolean copyFilesToFolderInProgress(boolean diferentContent, String fileName) throws IOException {
		LOGGER.debug("Inicia metodo de copia de lista del contenido del zip");
		LOGGER.debug("El contenido del zip es diferente al nombre del zip: " + diferentContent);
		LOGGER.debug("Nombre del zip a trabajar: " + fileName);

		boolean response = false;
		File workFileXml = null;
		File inProcessFile = null;
		File workZipFile = new File(getWorkFolder() + fileName);
		String historyPathZip = Util.validateDateFormat(getDestinationFolderZip());
		createFolder(historyPathZip);
		File zipFileDestination = new File(historyPathZip + fileName);

		LOGGER.debug("Ruta para el zip original: " + workZipFile.getAbsolutePath());
		LOGGER.debug("Ruta para el historico del zip: " + zipFileDestination.getAbsolutePath());

		if (diferentContent) {
			File[] listXml = getListFiles(getWorkFolder(), getFileContentPatternZip());
			if (listXml != null) {
				LOGGER.debug("Cantidad de archivos a copiar [ " + listXml.length + " ]");
				for (File file : listXml) {
					File destFile = new File(getHistoryPath() + file.getName());
					copyFile(file, destFile);

					if (destFile.exists()) {
						if (file.delete()) {
							LOGGER.debug("Eliminacion exitosa: " + file.getAbsolutePath());
						} else {
							LOGGER.error("Eliminacion fallida: " + file.getAbsolutePath());
						}
					}
				}
				if (workZipFile.exists()) {
					copyFile(workZipFile, zipFileDestination);
					if (zipFileDestination.exists()) {
						if (workZipFile.delete()) {
							LOGGER.debug("Eliminacion exitosa: " + workZipFile.getAbsolutePath());
						} else {
							LOGGER.error("Eliminacion fallida: " + workZipFile.getAbsolutePath());
						}

					}

				}

				response = true;

			}

		} else {
			String fileNameXml = fileName.replace("zip", "xml");
			workFileXml = new File(getWorkFolder() + fileNameXml); // Archivo xml
			inProcessFile = new File(getHistoryPath() + fileNameXml);
			copyFile(workFileXml, inProcessFile);
			if (inProcessFile.exists()) {
				if (workZipFile.exists()) {
					copyFile(workZipFile, zipFileDestination);
					if (zipFileDestination.exists()) {
						if (workZipFile.delete()) {
							LOGGER.debug("Eliminacion exitosa: " + workZipFile.getAbsolutePath());
						} else {
							LOGGER.error("Eliminacion fallida: " + workZipFile.getAbsolutePath());
						}

					}

				}
				if (workFileXml.delete()) {
					LOGGER.debug("Eliminacion exitosa: " + workFileXml.getAbsolutePath());
				} else {
					LOGGER.error("Eliminacion fallida: " + workFileXml.getAbsolutePath());
				}

				response = true;
			}

		}

		LOGGER.debug("Finaliza metodo de copia de lista del contenido del zip");

		return response;
	}

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

}
