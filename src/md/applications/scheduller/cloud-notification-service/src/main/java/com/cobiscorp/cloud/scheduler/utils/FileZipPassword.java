package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

public class FileZipPassword {

	private static final Logger logger = Logger.getLogger(FileZipPassword.class);

	public static void createZip(CopyFileJob copyFileJob, String nameFileExtension, String password, boolean encriptado) throws ZipException {

		// variable para separar el tipo de documento
		String[] nameFile = nameFileExtension.split("\\.");
		logger.debug("createZip name File >> " + nameFile[0] );

		String rutaGuardar = copyFileJob.getDestinationFolder() + File.separator + nameFile[0] + ".zip";
		String rutaFile = copyFileJob.getSourceFolder() + File.separator + nameFileExtension;
		

		logger.debug("copyFileJob.getDestinationFolder() >> " + rutaGuardar);
		logger.debug("copyFileJob.getSourceFolder() >> " + rutaFile);

		try {
			
			//Eliminamos de la ruta si existiera el 
			File fileEliminate = new File(rutaGuardar);
			
			if(fileEliminate.delete()) {
				logger.debug("El fichero zip fue eliminado de la ruta >> " + rutaGuardar);
			}else {
				logger.debug("Fichero no encontrado");
			}
			
			ZipFile zipFile = new ZipFile(rutaGuardar);
			ArrayList<File> filesToAdd = new ArrayList<File>();
			filesToAdd.add(new File(rutaFile));
			ZipParameters parameters = new ZipParameters();
			parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE); // metodo de compresion
			parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
			parameters.setEncryptFiles(true);
			parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
			parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
			parameters.setPassword(password);

			zipFile.addFiles(filesToAdd, parameters);
	
		} catch (ZipException e) {
			// TODO: handle exception
			logger.error("No se pudo comprimir el archivo", e);
		}
		

	}

}
