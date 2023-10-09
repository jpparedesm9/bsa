package com.cobiscorp.ecobis.cobiscloudbiometric.util.impl;

import java.io.BufferedReader;
import java.io.IOException;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Utils {

	private static ILogger LOGGER = LogFactory.getLogger(Utils.class);
	
	public static String readBufferReader(BufferedReader reader) throws IOException {
		StringBuilder response = new StringBuilder();
		String responseLine = null;
		try {
			while ((responseLine = reader.readLine()) != null) {
				response.append(responseLine.trim());
			}

		} catch (IOException ex) {
			
			LOGGER.logError("[Utils readBufferReader] + catch:", ex);
			throw ex;
		}
		return response.toString();
	}
	
	public static void printDbgLog(String msgStr) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(msgStr);
		}
	}
	
	

}