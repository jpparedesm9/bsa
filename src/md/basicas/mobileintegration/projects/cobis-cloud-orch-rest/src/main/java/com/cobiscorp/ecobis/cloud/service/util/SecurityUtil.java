package com.cobiscorp.ecobis.cloud.service.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SecurityUtil {
	public static boolean validateMail(String email) {
		// Patrón para validar el email
		Pattern pattern = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");

		Matcher mather = pattern.matcher(email);

		if (mather.find() == true) {
			System.out.println("El email ingresado es válido.");
			return true;
		} else {
			System.out.println("El email ingresado es inválido.");
			return false;
		}
	}

	public static boolean validatePhone(String num) {
		boolean isNumeric = num.matches("[+-]?\\d*(\\.\\d+)?");
		System.out.println(isNumeric);
		return isNumeric;
	}
}
