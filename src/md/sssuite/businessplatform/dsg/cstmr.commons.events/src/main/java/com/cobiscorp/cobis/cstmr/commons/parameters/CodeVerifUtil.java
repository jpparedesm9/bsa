package com.cobiscorp.cobis.cstmr.commons.parameters;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class CodeVerifUtil {
	
	private static final ILogger LOGGER = LogFactory.getLogger(CodeVerifUtil.class);
	public static boolean validateMail(String email) {
		// Patrón para validar el email
		Pattern pattern = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");

		Matcher mather = pattern.matcher(email);

		if (mather.find()) {
			LOGGER.logInfo("El email ingresado es válido.");
			return true;
		} else {
			LOGGER.logInfo("El email ingresado es inválido.");
			return false;
		}
	}

	public static boolean validatePhone(String num) {
		boolean isNumeric = num.trim().matches("[+-]?\\d*(\\.\\d+)?");
		LOGGER.logInfo("Número de Telefono - isNumeric=" + isNumeric);
		return isNumeric;
	}

}
