package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;
import org.apache.wicket.util.upload.DiskFileItem;
import org.apache.wicket.util.upload.FileItem;

import com.cobiscorp.cloud.alfresco.service.AlfrescoService;
import com.cobiscorp.cloud.configuration.ConfigAlfreso;

public class UploadAlfrescoFile {
	private static final Logger logger = Logger.getLogger(UploadAlfrescoFile.class);

	public static boolean uploadAlfrescoFile(File file, String groupId, String processIntanceId, String customerId, String fileName, String folder) throws Exception {

		boolean response = false;

		if (logger.isDebugEnabled()) {
			logger.debug("Field file: " + file);
			logger.debug("Field groupId: " + groupId);
			logger.debug("Field processIntanceId: " + processIntanceId);
			logger.debug("Field customerId: " + customerId);
			logger.debug("Field folder: " + folder);
			logger.debug("Field fileName: " + fileName);
		}

		if (file == null) {
			logger.error("The file field is mandatory, please provide it for this run.");
			return response;
		}

		// Load settings for alfresco
		ConfigAlfreso alfreso = ConfigAlfreso.getInstance();

		// Create File Item
		FileItem item = getFileIte(file, "application/pdf");

		AlfrescoService alfrescoService = new AlfrescoService();

		if (folder.equals("Inbox")) {
			logger.debug("CREATE FOLDER1 " + alfrescoService.createFolder(alfreso.getLibrary(), "Inbox", alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain()));
			logger.debug("Se creo el folder 1");
			logger.debug("CREATE FOLDER2 " + alfrescoService.createFolder(alfreso.getLibrary(), "Inbox/" + processIntanceId, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain()));
			logger.debug("Se creo el folder 2");
			logger.debug("Resultado es "
					+ alfrescoService.saveFile(alfreso.getLibrary() + "/" + "Inbox" + "/" + processIntanceId, fileName, item, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain()));
			logger.debug("fin subida de archivo");
			response = true;
		}

		if (folder.equals("Customer")) {
			String path = "/" + groupId;
			alfrescoService.createFolder(alfreso.getLibrary(), "Customer" + path, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain());
			path = path + "/" + processIntanceId;
			alfrescoService.createFolder(alfreso.getLibrary(), "Customer" + path, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain());
			path = path + "/" + customerId;
			alfrescoService.createFolder(alfreso.getLibrary(), "Customer" + path, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain());
			alfrescoService.saveFile(alfreso.getLibrary() + "/" + "Customer" + path, fileName, item, alfreso.getUser(), alfreso.getPassword(), alfreso.getEndpointDomain());
			response = true;
		}

		return response;
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

	private static FileItem getFileIte(File pathFile, String contentType) throws Exception {

		FileItem fileItem = null;

		if (pathFile == null) {
			System.out.println("Archivo no existente");
			return null;
		}

		if (contentType == null || "".equals(contentType)) {
			System.out.println("Tipo de contenido no existente");
			return null;
		}

		try {
			System.out.println("Inicio de prueba de fileItem");
			// This is a sample inputStream, use your own.
			InputStream inputStream = new FileInputStream(pathFile.getAbsoluteFile());

			int availableBytes = inputStream.available();
			String pathFileTmp = pathFile.getCanonicalPath() + File.separator + "tmp" + File.separator + pathFile.getName();

			// Write the inputStream to a FileItem
			File outFile = new File(pathFileTmp); // This is your tmp file, the code stores the file here in order to avoid storing
													// it in memory
			fileItem = new DiskFileItem(pathFile.getName(), contentType, false, outFile.getName(), availableBytes, outFile, null); // You link
																																	// FileItem to the
																																	// tmp outFile
			OutputStream outputStream = fileItem.getOutputStream(); // Last step is to get FileItem's output stream, and write your inputStream in it.
																	// This is the way to write to your FileItem.

			int read = 0;
			byte[] bytes = new byte[1024];
			while ((read = inputStream.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}

			// Don't forget to release all the resources when you're done with them, or you may encounter memory/resource leaks.
			inputStream.close();
			outputStream.flush(); // This actually causes the bytes to be written.
			outputStream.close();

			// NOTE: You may also want to delete your outFile if you are done with it and dont want to take space on disk.

		} catch (Exception e) {
			throw new Exception(e);
		}

		return fileItem;

	}

}
