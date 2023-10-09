package com.cobiscorp.cloud.configuration;

import java.io.File;

import com.cobiscorp.cloud.utils.CryptoException;
import com.cobiscorp.cloud.utils.CryptoUtils;

public class CryptoFiles {

    public void cryotoFile(String type, String sourceFile, String destinationFile) {

	String key = "";
	DecryptManager dc = new DecryptManager();

	if ((!type.contentEquals("E")) && (!type.contentEquals("D"))) {
	    messageError();
	    return;
	}

	if ((sourceFile.equals("")) || (destinationFile.equals(""))) {
	    messageError();
	    return;
	}

	key = dc.getPasswod();

	File srcFile = new File(sourceFile);
	File dstFile = new File(destinationFile);

	if (type.contentEquals("E")) {
	    try {
		CryptoUtils.encrypt(key, srcFile, dstFile);
	    } catch (CryptoException e) {
		System.out.println(e);
		e.printStackTrace();
		return;
	    }
	}
	if (type.contentEquals("D")) {
	    try {
		CryptoUtils.decrypt(key, srcFile, dstFile);
	    } catch (CryptoException e) {
		System.out.println(e);
		e.printStackTrace();
	    }
	}

    }

    private void messageError() {
	System.out.println("El comando debe ser: java -jar crypt.jar {MODO] [ARCHIVO_ORIGEN] [ARCHIVO_DESTINO]");
	System.out.println("MODO: E (cifrar) / D (descifrar)");
    }

}
