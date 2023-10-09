package com.cobiscorp.ecobis.cobiscloudonboard.util.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudonboard.util.constants.Parameter;

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

	public static String padRightZeros(String inputString, int length) {
		if (inputString.length() >= length) {
			return inputString;
		}
		StringBuilder sb = new StringBuilder();
		while (sb.length() < length - inputString.length()) {
			sb.append(Parameter.CHR_TO_FILL);
		}
		// sb.append(inputString);
		return inputString + sb.toString();
	}

	public static Object getOutputs(Map<String, Object> outputs, String output) {
		return outputs.get(output) == null ? null : outputs.get(output).toString();
	}

	public static String removeAccents(String word) {
		word = word.toUpperCase();

		word = word.replace('Á', 'A');
		word = word.replace('É', 'E');
		word = word.replace('Í', 'I');
		word = word.replace('Ó', 'O');
		word = word.replace('Ú', 'U');
		LOGGER.logDebug("removeAccents :: word=" + word);

		/*word = word.replace('-', ' ');
		word = word.replace('_', ' ');
		word = word.replace('.', ' ');*/
		
		return word;
	}

	public static String removeSpaces(String word) {
		word = word.trim(); // elimina espacios del inicio y final
		word = word.replaceAll(" +", " "); // elimina espacios intermedios

		return word;
	}
}