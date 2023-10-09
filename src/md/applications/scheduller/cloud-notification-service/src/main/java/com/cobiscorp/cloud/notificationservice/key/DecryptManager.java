package com.cobiscorp.cloud.notificationservice.key;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.impl.GenerateArchCifMcCollect;
import com.cobiscorp.cobis.commons.crypt.ReadAlgn;

public class DecryptManager {

    private static final Logger logger = Logger.getLogger(DecryptManager.class);

    private static DecryptManager configManager;

    // Credentials Encrypting
    private String passwod;

    public DecryptManager() {
	try {
	    initProperties();

	} catch (IOException e) {
	    logger.error("Error al tener la configuracion",e);

	}
    }

    public static DecryptManager getInstance() {
	if (configManager == null) {
	    configManager = new DecryptManager();
	}
	return configManager;
    }

    public void initProperties() throws IOException {

	try {
	    passwod = getPwdCredentials();

	} catch (Exception e) {
	    throw new IOException(e);

	}

    }

    public String getPwdCredentials() {

	String returnValue = null;
	String algnFile = "notification/key/encryptar.algncon";

	try {
	    File file = new File(algnFile);

	    if (!file.exists()) {
		logger.debug("No existe archivo de configuracion " + algnFile);
	    } else {
		ReadAlgn wAlgReader = new ReadAlgn(algnFile);
		Properties wProperties = wAlgReader.leerParametros();

		returnValue = wProperties.getProperty("p");

	    }
	} catch (Exception ex) {
	    logger.error("Error al obtener credenciales" , ex);

	}

	return returnValue;
    }

    public String getPasswod() {
	return passwod;
    }

    public void setPasswod(String passwod) {
	this.passwod = passwod;
    }

}
