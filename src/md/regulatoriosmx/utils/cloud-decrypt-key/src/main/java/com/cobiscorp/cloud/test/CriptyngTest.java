package com.cobiscorp.cloud.test;

import com.cobiscorp.cloud.configuration.CryptoFiles;

public class CriptyngTest {

    public static void main(String[] args) {

	if (args.length != 3) {
	    System.out.println("El comando debe ser: java -jar cloud-decrypt-key-1.0.0.jar {MODO] [ARCHIVO_ORIGEN] [ARCHIVO_DESTINO]");
	    System.out.println("MODO: E (cifrar) / D (descifrar)");
	    return;
	}

	String mode = args[0];
	String srcFileName = args[1];
	String dstFileName = args[2];
	if ((!mode.contentEquals("E")) && (!mode.contentEquals("D"))) {
	    System.out.println("El comando debe ser: java -jar crypt.jar {MODO] [ARCHIVO_ORIGEN] [ARCHIVO_DESTINO]");
	    System.out.println("MODO: E (cifrar) / D (descifrar)");
	    return;
	}	
	CryptoFiles cf = new CryptoFiles();
	cf.cryotoFile(mode, srcFileName, dstFileName);

    }

}
