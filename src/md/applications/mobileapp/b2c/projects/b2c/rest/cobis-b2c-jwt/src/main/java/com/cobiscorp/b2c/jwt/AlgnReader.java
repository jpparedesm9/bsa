package com.cobiscorp.b2c.jwt;

import java.util.Properties;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;

public class AlgnReader {
	
	private static final String LOGIN = "l";
	private static final String PAS = "p";
	private static final String SERVER = "s";
	private Properties wProperties;
	private String seedPath;
	
	public AlgnReader(String seedPath) {
		this.seedPath = seedPath;
	}

	public void init() {
		String algnFile = System.getProperty("COBIS_HOME") + seedPath;
		ReadAlgn wAlgReader = new ReadAlgn(algnFile);
		this.wProperties = wAlgReader.leerParametros();
	}

	public String readSeed() {
		if (wProperties == null) {
			init();
		}
		String user = wProperties.getProperty(LOGIN);
		String pass = wProperties.getProperty(PAS);
		String server = wProperties.getProperty(SERVER);
		return user.concat(pass).concat(server);
	}

}
