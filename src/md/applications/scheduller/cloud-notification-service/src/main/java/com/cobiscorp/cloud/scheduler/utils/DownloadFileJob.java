package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

public class DownloadFileJob extends FileExchangeJob {
	private static final Logger LOGGER = Logger.getLogger(DownloadFileJob.class);

	public DownloadFileJob(Job process) {
		super(process);
	}

	public FileExchangeResponse downloadFiles() {

		boolean continueProcess = true;
		String internalError = null;

		Vector<ChannelSftp.LsEntry> lsEntries;
		OutputStream outputStreamFile = null;
		OutputStream historyStreamFile = null;

		try {
			try {
				/* Se inicia la conexión */
				connectProvider();
			} catch (Exception e) {
				LOGGER.error("No se pudo inciar la conexi\u00f3n: ", e);
				throw new COBISInfrastructureRuntimeException("No se pudo iniciar la conexi\u00f3n");
			}
			
			try {
				LOGGER.error("La carpeta de descargas es : " + getRemoteDownloadPath());
				getChannelSftp().cd(getRemoteDownloadPath());
			} catch (SftpException e) {
				LOGGER.error("Error al dirigirse a la carpeta remota para descarga:", e);
				throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para descarga");
			}

			try {
				LOGGER.error("El archivo de descarga es : " + getDownloadFilePattern());
				lsEntries = getChannelSftp().ls(getDownloadFilePattern());
			} catch (SftpException e) {
				LOGGER.error("Error al buscar archivos para descarga:", e);
				throw new COBISInfrastructureRuntimeException("Error al buscar archivos para descarga");
			}

			if (lsEntries.isEmpty()) {
				throw new COBISInfrastructureRuntimeException("NO EXISTE NING\u00daN ARCHIVO PARA DESCARGAR");
			}

			SftpATTRS sftpATTRS = null;
			String fileName;
			File ienFile = null;
			File workFile = null;
			File historyFile = null;
			for (ChannelSftp.LsEntry lsEntry : lsEntries) {
				fileName = lsEntry.getFilename();

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
				
				try {
					LOGGER.error("La carpeta de historico es : " + getRemoteDownloadHistoryPath());
					getChannelSftp().cd(getRemoteDownloadHistoryPath());
				} catch (SftpException e) {
					LOGGER.error("Error al dirigirse a la carpeta remota para historico:", e);
					throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para historico");
				}
				
				File fileHistory = null;
				InputStream inputStream = null;
				
				try{
					fileHistory = new File(getWorkFolder() + fileName);
					
					inputStream = new FileInputStream(fileHistory);
				}catch(FileNotFoundException e){
					LOGGER.error("No se pudo asignar el archivo que se moverá a historicos " + fileName + ":", e);
					throw new COBISInfrastructureRuntimeException("No se pudo asignar el archivo que se moverá a historicos: " + fileName);
				}
				
				try {
					LOGGER.error("La ruta del archivo para Historicos es : " + fileHistory.getAbsolutePath());
					LOGGER.error("El nombre del archivo para Historicos es : " + fileName);
					getChannelSftp().put(inputStream, fileHistory.getName());
				} catch (SftpException e) {
					LOGGER.error("No se puede copiar a Historico el archivo " + fileName + ":", e);
					throw new COBISInfrastructureRuntimeException("No se puede copiar a Historico el archivo " + fileName);
				}
				
				try {
					inputStream.close();
				} catch (IOException e) {
					LOGGER.error("No se puede cerrar el archivo " + fileName + ":", e);
					throw new COBISInfrastructureRuntimeException("No se puede cerrar el archivo " + fileName);
				}
				
				try {
					LOGGER.error("La carpeta de descargas es : " + getRemoteDownloadPath());
					getChannelSftp().cd(getRemoteDownloadPath());
				} catch (SftpException e) {
					LOGGER.error("Error al dirigirse a la carpeta remota para descarga:", e);
					throw new COBISInfrastructureRuntimeException("Error al dirigirse a la carpeta remota para descarga");
				}
				
				try {
					workFile = new File(getWorkFolder() + fileName);
					historyFile = changePathHistorical(getHistoryPath(), "\\Descarga\\", fileName);
					copyFile(workFile, historyFile);
				} catch (IOException e1) {
					throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo a Historicos: " + fileName);
				}

				try {
					ienFile = new File(getDownloadPath() + fileName);
					copyFile(workFile, ienFile);
					workFile.delete();
				} catch (IOException e1) {
					throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo a Historicos: " + fileName);
				}

				/* DELETE ORIGINAL FILE AT HOST */
				try {
					getChannelSftp().rm(fileName);
				} catch (SftpException e) {
					LOGGER.error(e.toString());
					e.printStackTrace();
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Se elimin\u00f3 el archivo de Domiciliaci\u00f3n del servidor anfitri\u00f3n");
				}
			}
		} finally {

			if (outputStreamFile != null) {
				try {
					outputStreamFile.close();
				} catch (IOException e) {
					LOGGER.error(e.toString());
					internalError = "No se pudo cerrar el canal de escritura del archivo de Listas Negras descargado";
					continueProcess = false;
				}
			}
			if (getChannelSftp() != null && getChannelSftp().isConnected())
				getChannelSftp().disconnect();
			if (getSessionConnect() != null && getSessionConnect().isConnected())
				getSessionConnect().disconnect();
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}
}
