package com.cobiscorp.cloud.configuration;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;

public class DecryptManager {

    private static DecryptManager configManager;

    // Credentials Encrypting
    private String passwod;

    public DecryptManager() {
	try {
	    initProperties();

	} catch (IOException e) {
	    System.out.println("Error al tener la configuracion");

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
	String algnFile = "./key/encryptar.algncon";

	System.out.println(algnFile);

	try {
	    File file = new File(algnFile);
	    System.out.println(file.exists());

	    if (!file.exists()) {
		System.out.println("No existe archivo de configuracion " + algnFile);
	    } else {
		ReadAlgn wAlgReader = new ReadAlgn(algnFile);
		Properties wProperties = wAlgReader.leerParametros();

		returnValue = wProperties.getProperty("p");

	    }
	} catch (Exception ex) {
	    System.out.println("Error al obtener credenciales" + ex);

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
