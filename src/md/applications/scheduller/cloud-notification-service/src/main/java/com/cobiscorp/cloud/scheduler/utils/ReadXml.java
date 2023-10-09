package com.cobiscorp.cloud.scheduler.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import org.apache.log4j.Logger;

public abstract class ReadXml {
	private static final Logger logger = Logger.getLogger(ReadXml.class);

	public static boolean read(File xmlFile) {

		try {
			logger.debug("Inicia el READ");

			BufferedReader reader = new BufferedReader(new FileReader(xmlFile));
			String line = null;
			StringBuilder stringBuilder = new StringBuilder();
			String ls = System.getProperty("line.separator");

			try {
				while ((line = reader.readLine()) != null) {
					stringBuilder.append(line);
					stringBuilder.append(ls);
				}

				logger.debug("El archivo contiene: " + stringBuilder.toString());

				if (stringBuilder.toString().startsWith("NO_DATA")) {
					logger.debug("Retorna falso");
					return false;
				} else {
					logger.debug("Retorna true");
					return true;
				}

			} finally {
				reader.close();
			}

		} catch (Exception e) {
			logger.error("Error al convertir xml a Documento");

		}
		return true;
	}
}
