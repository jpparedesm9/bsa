package com.cobiscorp.cobis.customer.reports.commons;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Functions {
	private static final ILogger logger = LogFactory.getLogger(Functions.class);

	public static String fecha1() {
		// SimpleDateFormat formateador = new SimpleDateFormat("dd MMMM yyyy", new Locale("es", "ES"));
		return null;// formateador.format(SessionContext.getProcessDate());
	}

	public static String fecha() {
		// SimpleDateFormat formateador = new SimpleDateFormat("EEEE, dd 'de' MMMM yyyy", new Locale("es", "ES"));
		return null; // formateador.format(SessionContext.getProcessDate());
	}

	public static String fechaActual() {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		return null; // formatter.format(SessionContext.getProcessDate());
	}

	public static String fechaC(Calendar calendar) {
		SimpleDateFormat formateador = new SimpleDateFormat("dd, MMMM 'del' yyyy", new Locale("es", "ES"));
		return formateador.format(calendar.getTime());
	}

	public static String fechaN(Calendar calendar) {
		SimpleDateFormat formateador = new SimpleDateFormat("dd 'de' MMMM 'del' yyyy", new Locale("es", "ES"));
		return formateador.format(calendar.getTime());
	}

	public static String fechaCL(Calendar calendar) {
		SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy", new Locale("es", "ES"));
		return formateador.format(calendar.getTime());
	}

	public static String convertCalendarToString(Calendar calendar, String formatCode) {

		Date date = null;

		String stringDate = "";
		SimpleDateFormat formatDate;
		try {
			date = calendar.getTime();
			formatDate = new SimpleDateFormat(formatCode);
			stringDate = formatDate.format(date);
		} catch (Exception ex) {
			logger.logError("ERROR convertDateToString: ", ex);
		}
		return stringDate;
	}

	// Creación de un formato con separadores de decimales y millares, con 2 decimales
	public static String changeCurrency(double valor) {
		DecimalFormat formato = new DecimalFormat("#,##0.00");
		String valorFormateado = formato.format(valor);
		// Muestra en pantalla el valor 123.456,79 teniendo en cuenta que se usa la puntuación española
		return valorFormateado;
	}

	public static String changeCurrency(BigDecimal value) {
		if (value != null) {
			DecimalFormat formato = new DecimalFormat("#,##0.00");
			return formato.format(value);
		}
		return null;
	}

	public static String eliminateSpace(String code) {
		String noChainWhite = "";
		for (int x = 0; x < code.length(); x++) {
			if (code.charAt(x) != ' ')
				noChainWhite += code.charAt(x);
		}
		return noChainWhite;
	}

	// Redondea
	public static BigDecimal round(BigDecimal value) {
		BigDecimal bdTest = value.setScale(2, BigDecimal.ROUND_HALF_UP);
		logger.logDebug("***** decimal -- el value bigdecimal antes: " + value);
		logger.logDebug("***** decimal -- el value bigdecimal redondeado: " + bdTest);
		return bdTest;
	}

	// Obtiene los valores decimales
	public static Double decimal(BigDecimal valueDecimal) {
		valueDecimal = valueDecimal.subtract(new BigDecimal(valueDecimal.longValue())).multiply(new BigDecimal(100));
		logger.logDebug("***** decimal -- el value bigdecimal redondeado es despues: " + valueDecimal);
		return valueDecimal.doubleValue();
	}

	public static boolean tryParseInt(String value) {
		try {
			Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static String getDataFromList(Object[] objectList, String separator, String field, boolean pushIsEmpty, boolean pushIsNull) {
		String valueList = "";
		boolean addSeparator;
		if (objectList != null && objectList.length > 0) {
			@SuppressWarnings("rawtypes")
			Class userClass = objectList[0].getClass();
			for (int i = 0; i < objectList.length; i++) {
				addSeparator = false;
				try {
					java.lang.reflect.Field userField = userClass.getDeclaredField(field);
					userField.setAccessible(true);

					if (userField.get(objectList[i]) != null) {
						if (userField.get(objectList[i]).toString().trim().length() > 0) { // SI TIENE ALGUN VALOR
							valueList = valueList + userField.get(objectList[i]).toString();
							addSeparator = true;
						} else if (pushIsEmpty) {
							valueList = valueList + userField.get(objectList[i]).toString();
							addSeparator = true;
						}
					} else if (pushIsNull) {
						addSeparator = true;
					}

					if (addSeparator && (i < (objectList.length - 1))) {
						valueList = valueList + separator + " ";
					}
				} catch (SecurityException e) {
					logger.logError("SecurityException -> getDataFromList: " + field, e);
				} catch (NoSuchFieldException e) {
					logger.logError("NoSuchFieldException -> getDataFromList: " + field, e);
				} catch (IllegalArgumentException e) {
					logger.logError("IllegalArgumentException -> getDataFromList: " + field, e);
				} catch (IllegalAccessException e) {
					logger.logError("IllegalAccessException -> getDataFromList: " + field, e);
				}
			}
		}
		if ((!pushIsEmpty || !pushIsNull) && valueList.length() > 2 && valueList.endsWith(separator + " ")) {
			valueList = valueList.substring(0, valueList.length() - 2);
		}
		return valueList;
	}

	public static String getDataFromList(List<?> objectList, String separator, String field, boolean pushIsEmpty, boolean pushIsNull) {
		if (objectList != null && objectList.size() > 0) {
			return Functions.getDataFromList(objectList.toArray(), separator, field, pushIsEmpty, pushIsNull);
		}
		return "";
	}

	public static Calendar toCalendar(Date date) {
		Calendar initalDate = Calendar.getInstance();
		initalDate.setTime(date);
		return initalDate;
	}

	public static String toCamellFormat(String value) {
		if (value != null && !value.isEmpty()) {
			value = value.toLowerCase();
			char[] caracteres = value.toCharArray();
			if (caracteres != null && caracteres.length > 0) {
				caracteres[0] = Character.toUpperCase(caracteres[0]);
				// el -2 es para evitar una excepción al caernos del arreglo
				for (int i = 0; i < value.length() - 2; i++)
					if (caracteres[i] == ' ' || caracteres[i] == '.' || caracteres[i] == ',')// Es 'palabra'
						caracteres[i + 1] = Character.toUpperCase(caracteres[i + 1]);// Reemplazamos
				return new String(caracteres);
			}
		}
		return value;
	}

	// public static String getFullDebtorName(DebtorResponse debtorResponseDto, char option) {
	// return (debtorResponseDto.getDebtorName() != null) ? debtorResponseDto.getDebtorName() : "";
	// }

	public static String getStringCurrencyFormated(Double amount) {
		NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "MX"));
		return formatter.format(amount);
	}

	public static String changeStringDateFormat(String date, String initformat, String finalFormat) {
		String finalDate = null;
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("fecha ini: " + date);
			}
			Date resultDate = convertStringToDate(date, initformat);
			DateFormat df = new SimpleDateFormat(finalFormat);
			finalDate = df.format(resultDate);
			if (logger.isDebugEnabled()) {
				logger.logDebug("fecha fin: " + finalDate);
			}
		} catch (Exception ex) {
			logger.logError("ERROR: ", ex);
		}
		return finalDate;
	}

	public static Date convertStringToDate(String stringDate, String format) {
		Date date = null;
		SimpleDateFormat formatDate;

		try {
			formatDate = new SimpleDateFormat(format);
			date = formatDate.parse(stringDate);

		} catch (Exception ex) {
			logger.logError("ERROR: ", ex);
		}

		return date;
	}

	public static String convertDoubleStringMoney(Double amount) {
		String value = String.format("%,.2f", amount);
		return value;
	}
}