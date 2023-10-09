package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.log4j.Logger;

public class FileZipMasive {

	private static final Logger logger = Logger.getLogger(FileZipMasive.class);

	public static boolean createZipMasive(String destinationFolder, String nameZip, List<File> files) throws IOException {

		boolean response = false;

		if (logger.isDebugEnabled()) {
			logger.debug("Inicio método createZipMasive para compresión por lotes de archivos");
			logger.debug("Nombre del Zip: " + nameZip);
			logger.debug("Cantidad de archivos por lote: " + files.size());
		}

		if (files != null) {

			String pathSaveZip = destinationFolder + File.separator + nameZip + ".zip";

			if (new File(pathSaveZip).delete()) {
				logger.debug("El fichero zip fue eliminado de la ruta " + pathSaveZip);
				logger.debug("Inicia compresión de lote");
			} else {
				logger.debug("Fichero " + pathSaveZip + " no encontrado");
				logger.debug("Inicia compresión de lote");
			}

			FileOutputStream fos = new FileOutputStream(pathSaveZip);
			ZipOutputStream zipOut = new ZipOutputStream(fos);
			for (File srcFile : files) {
				FileInputStream fis = new FileInputStream(srcFile);
				ZipEntry zipEntry = new ZipEntry(srcFile.getName());
				zipOut.putNextEntry(zipEntry);

				byte[] bytes = new byte[1024];
				int length;
				while ((length = fis.read(bytes)) >= 0) {
					zipOut.write(bytes, 0, length);
				}
				fis.close();
			}
			zipOut.close();
			fos.close();

			logger.debug("Termina compresión de lote");

			response = true;
		}
		logger.debug("Finaliza método createZipMasive para compresión por lotes de archivos");
		return response;

	}

}
