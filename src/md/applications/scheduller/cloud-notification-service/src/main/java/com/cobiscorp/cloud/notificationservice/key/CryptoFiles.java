package com.cobiscorp.cloud.notificationservice.key;

import java.io.File;

import org.apache.log4j.Logger;

public class CryptoFiles {

    private static final Logger logger = Logger.getLogger(CryptoFiles.class);

    public boolean cryotoFile(String type, String sourceFile, String destinationFile) {
	
	boolean resp = true;

	String key = "";
	DecryptManager dc = new DecryptManager();

	key = dc.getPasswod();

	logger.debug("Encryption password: "+ key);
	
	if(key==null) {
	    resp=false;
	    return resp;
		 
	}
	
	File srcFile = new File(sourceFile);
	File dstFile = new File(destinationFile);

	if (type.contentEquals("E")) {
	    try {
		CryptoUtils.encrypt(key, srcFile, dstFile);
	    } catch (com.cobiscorp.cloud.scheduler.utils.CryptoException e) {
		logger.error("Error al encriptar el archivo: ",e);
		resp = false;

	    }
	}
	if (type.contentEquals("D")) {
	    try {
		CryptoUtils.decrypt(key, srcFile, dstFile);
	    } catch (com.cobiscorp.cloud.scheduler.utils.CryptoException e) {
		logger.error("Error al desencriptar el archivo: ", e);
		resp = false;
	    }
	}
	return resp;

    }

    private void messageError() {

	logger.debug("El comando debe ser: java -jar crypt.jar {MODO] [ARCHIVO_ORIGEN] [ARCHIVO_DESTINO]");
	logger.debug("MODO: E (cifrar) / D (descifrar)");

    }

}
