package com.cobiscorp.ecobis.customer.commons.bl.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class UtilFunction {

	public static int getEdad(Date fechaNacimiento) {
		Calendar c = new GregorianCalendar();
		if (fechaNacimiento != null) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		StringBuilder result = new StringBuilder();
		if (fechaNacimiento != null) {
			result.append(sdf.format(fechaNacimiento));
			c.setTime(fechaNacimiento);
		}
		}
		return calcularEdad(c);
	}

	private static int calcularEdad(Calendar fechaNac) {
		Calendar today = Calendar.getInstance();
		int diffYear = today.get(Calendar.YEAR) - fechaNac.get(Calendar.YEAR);
		int diffMonth = today.get(Calendar.MONTH) - fechaNac.get(Calendar.MONTH);
		int diffDay = today.get(Calendar.DAY_OF_MONTH) - fechaNac.get(Calendar.DAY_OF_MONTH);
		// Si está en ese año pero todavía no los ha cumplido
		if (diffMonth < 0 || (diffMonth == 0 && diffDay < 0)) {
			diffYear = diffYear - 1;
		}
		return diffYear;
	}

}
