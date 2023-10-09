package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import com.cobiscorp.cloud.alfresco.service.AlfrescoService;
import com.cobiscorp.cloud.configuration.ConfigAlfreso;

public class DownloadAlfrescoFile {
	private static final Logger logger = Logger.getLogger(DownloadAlfrescoFile.class);

	private static String FOLDERDOWLOAND = "descargas";

	public static String getAlfrescoFile(String workFolder, String groupId, String processIntanceId, String customerId, String fileName, String folder, Date date, String fileNameLocal)
			throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("Field workFolder: " + workFolder);
			logger.debug("Field groupId: " + groupId);
			logger.debug("Field processIntanceId: " + processIntanceId);
			logger.debug("Field customerId: " + customerId);
			logger.debug("Field folder: " + folder);
			logger.debug("Field fileName: " + fileName);
			logger.debug("Field fileNameLocal: " + fileNameLocal);
			logger.debug("Field date: " + date);
		}

		if (workFolder.endsWith(File.separator)) {
			workFolder = workFolder.substring(0, workFolder.length() - 1);
		}
		
		String pathLocalFolder = workFolder + File.separator + getDatePath(date) + File.separator + FOLDERDOWLOAND + File.separator + processIntanceId + File.separator + folder;
		String pathAlfrescoFile = null;
		String pathLocalFile = null;

		try {

			if (folder.equals("Inbox")) {
				pathAlfrescoFile = folder + "/" + processIntanceId + "/" + fileName;
			} else if (folder.equals("Customer")) {
				if (groupId != null && !groupId.equals("")) {
					pathAlfrescoFile = folder + "/" + groupId + "/" + processIntanceId + "/" + customerId + "/" + fileName;
				} else {
					pathAlfrescoFile = folder + "/" + processIntanceId + "/" + customerId + "/" + fileName;
				}

				pathLocalFolder = pathLocalFolder + File.separator + customerId;

			} else {
				logger.debug("The folder is not the same:" + folder);
				throw new Exception("Error the folder does not match the alfresco folder ");
			}

			// Load settings for alfresco
			ConfigAlfreso alfreso = ConfigAlfreso.getInstance();

			// Download files from alfresco
			AlfrescoService alfrescoService = new AlfrescoService();
			byte[] fileDownload = alfrescoService.getFile(alfreso.getLibrary(), pathAlfrescoFile, "", alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain());

			// Generate File Local
			if (fileDownload != null) {
				File folderLocal = new File(pathLocalFolder);

				if (!folderLocal.exists()) {
					folderLocal.mkdirs();
				}

				pathLocalFile = pathLocalFolder + File.separator + fileNameLocal;
				if (logger.isDebugEnabled()) {
					logger.debug("Path pathLocalFolder: " + pathLocalFolder);
					logger.debug("Path pathAlfrescoFile: " + pathLocalFolder);
					logger.debug("Path pathLocalFile: " + pathLocalFolder);
				}

				File fileLocal = new File(pathLocalFile);

				// Check if the file exists
				if (fileLocal.exists()) {
					logger.debug(String.format("file %s exists", fileLocal.getAbsolutePath()));
					if (fileLocal.delete()) {
						logger.debug(String.format("file %s delete", pathLocalFile));
					}
				}

				// Generate file on path
				FileUtils.writeByteArrayToFile(fileLocal, fileDownload);
			} else {
				logger.debug("There is no file in alfresco");
			}

		} catch (IOException e) {
			logger.error(e);
			throw new Exception("Error creating file", e);

		}

		return pathLocalFile;
	}

	private static String getDatePath(Date proccessDateF) {

		Calendar calendarGenF = Calendar.getInstance();
		calendarGenF.setTime(proccessDateF);
		String diaInter = String.valueOf(calendarGenF.get(Calendar.DAY_OF_MONTH));
		String mesInter = String.valueOf(calendarGenF.get(Calendar.MONTH) + 1);
		String anioInter = String.valueOf(calendarGenF.get(Calendar.YEAR));

		if (mesInter.length() == 1)
			mesInter = '0' + mesInter;

		if (diaInter.length() == 1)
			diaInter = '0' + diaInter;

		return anioInter + File.separator + mesInter + File.separator + diaInter;

	}

}
