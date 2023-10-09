package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.pdfbox.io.MemoryUsageSetting;
import org.apache.pdfbox.multipdf.PDFMergerUtility;

public class MergeDocumentPdf {
	private static final Logger LOGGER = Logger.getLogger(MergeDocumentPdf.class);
	private static final String EXTENSION = ".pdf";

	private MergeDocumentPdf() {
		throw new IllegalStateException("Utility class");
	}

	public static String generateMergeDocument(List<File> filesDocuments, String pathDestination, String nameFile) throws Exception {
		LOGGER.debug("Start method generateMergeDocument");
		String response = null;

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("filesDocuments: " + filesDocuments);
			LOGGER.debug("pathDestination: " + pathDestination);
			LOGGER.debug("nameFile: " + nameFile);
		}

		// Validate required fields
		if (!validateFields(filesDocuments, pathDestination, nameFile)) {
			LOGGER.debug("The fields are mandatory");
			return response;
		}

		String pathFile = pathDestination + File.separator + nameFile + EXTENSION;

		try {

			File fileFinaly = new File(pathFile);

			if (fileFinaly.exists()) {
				if (fileFinaly.delete()) {
					LOGGER.debug("Existing file in the path: " + fileFinaly.getAbsolutePath());
					LOGGER.debug("Removing file from path " + fileFinaly.getAbsolutePath());
				}
			}

			PDFMergerUtility pdfMergerUtility = new PDFMergerUtility();
			pdfMergerUtility.setDestinationFileName(pathFile);

			// The files are added to merge them into a single file.
			for (File file : filesDocuments) {
				LOGGER.debug("Adding file: " + file.getAbsolutePath());
				pdfMergerUtility.addSource(file);
			}

			pdfMergerUtility.mergeDocuments(MemoryUsageSetting.setupMainMemoryOnly());
			response = pathFile;

		} catch (FileNotFoundException e) {
			throw new FileNotFoundException("Error: file not checked");
		} catch (IOException e) {
			throw new IOException("Error: the file could not be saved.");
		}
		LOGGER.debug("End method generateMergeDocument");
		return response;

	}

	private static boolean validateFields(List<File> filesDocuments, String pathDestination, String nameFile) {

		if (filesDocuments == null || filesDocuments.isEmpty()) {
			LOGGER.debug("Empty list or list size is zero");
			return false;
		}

		if (pathDestination == null || pathDestination.equals("")) {
			LOGGER.debug("Destination path does not exist");
			return false;
		}

		if (nameFile == null || nameFile.equals("")) {
			LOGGER.debug("File name does not exist");
			return false;
		}
		return true;
	}

}
