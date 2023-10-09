package com.cobiscorp.cloud.scheduler.utils;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

/***
 * Esta clase permite setear un mapa de parametros para los reportes validado
 * valores
 *
 * @author CobisCorp
 *
 */

public final class Util {
	private static final Logger LOGGER = Logger.getLogger(Util.class);

	private static String CURRENT_PROCESS_DATE = "{CPD:";
	private static String PREVIOUS_PROCESS_DATE = "{PPD:";
	private static String SYSTEM_DATE = "{SD:";

	public static String monthDescription(Calendar c1) {
		String month = "";
		if (c1.get(Calendar.MONTH) == 0) {
			month = "ENERO";
		} else if (c1.get(Calendar.MONTH) == 1) {
			month = "FEBRERO";
		} else if (c1.get(Calendar.MONTH) == 2) {
			month = "MARZO";
		} else if (c1.get(Calendar.MONTH) == 3) {
			month = "ABRIL";
		} else if (c1.get(Calendar.MONTH) == 4) {
			month = "MAYO";
		} else if (c1.get(Calendar.MONTH) == 5) {
			month = "JUNIO";
		} else if (c1.get(Calendar.MONTH) == 6) {
			month = "JULIO";
		} else if (c1.get(Calendar.MONTH) == 7) {
			month = "AGOSTO";
		} else if (c1.get(Calendar.MONTH) == 8) {
			month = "SEPTIEMBRE";
		} else if (c1.get(Calendar.MONTH) == 9) {
			month = "OCTUBRE";
		} else if (c1.get(Calendar.MONTH) == 10) {
			month = "NOVIEMBRE";
		} else if (c1.get(Calendar.MONTH) == 11) {
			month = "DICIEMBRE";
		}
		return month;
	}

	public static String numberCero(Integer c) {
		String numberCero = "";
		if (c < 10) {
			numberCero = "0" + String.valueOf(c);
		} else {
			numberCero = String.valueOf(c);
		}
		return numberCero;
	}

	public static String fechaProceso(Connection cn, Integer formato) {
		CallableStatement executeSP = null;
		String resultado = null;

		try {

			String query = "{ call cobis..sp_fecha_proceso(?,?) }";

			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "S");
			executeSP.setInt(2, formato);

			ResultSet result = executeSP.executeQuery();

			while (result.next()) {
				resultado = result.getString(1);
			}

			return resultado;
		} catch (Exception e) {
			LOGGER.error("ERROR fechaProceso", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza fechaProceso");
			}
		}
		return null;
	}

	private static String fechaProceso(String datePattern, String dateDefinition) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia fechaProceso");
		}

		Connection cn = null;
		CallableStatement executeSP;

		try {
			cn = ConnectionManager.newConnection();

			String query = "{ call cobis..sp_fecha_proceso(?, ?) }";

			executeSP = cn.prepareCall(query);

			String dateParameter = null;
			if (dateDefinition.contentEquals(CURRENT_PROCESS_DATE)) {
				dateParameter = "S";
			}
			if (dateDefinition.contentEquals(PREVIOUS_PROCESS_DATE)) {
				dateParameter = "L";
			}
			executeSP.setString(1, dateParameter);
			executeSP.setInt(2, 111); // yyyy/MM/dd

			ResultSet result = executeSP.executeQuery();

			String fechaProceso = null;
			while (result.next()) {
				fechaProceso = result.getString(1);
			}

			DateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			Date processDate = format.parse(fechaProceso);

			DateFormat dateFormat = new SimpleDateFormat(datePattern);
			return dateFormat.format(processDate);
		} catch (Exception e) {
			LOGGER.error("ERROR fechaProcesoAnterior", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
		}

		return null;
	}

	public static String fechaProcesoAnterior(String datePattern) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia fechaProcesoAnterior");
		}

		return fechaProceso(datePattern, PREVIOUS_PROCESS_DATE);
	}

	public static String fechaProcesoActual(String datePattern) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia fechaProcesoActual");
		}

		return fechaProceso(datePattern, CURRENT_PROCESS_DATE);
	}

	public static String fechaSistema(String datePattern) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia fechaSistema");
		}

		DateFormat dateFormat = new SimpleDateFormat(datePattern);
		return dateFormat.format(new Date());
	}

	public static String validateDateFormat(String dateText) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia validateDateFormat");
		}
		if (dateText != null) {
			if (dateText.contains(CURRENT_PROCESS_DATE)) {
				String datePattern = dateText.substring(dateText.indexOf(CURRENT_PROCESS_DATE) + CURRENT_PROCESS_DATE.length(), dateText.indexOf("}"));
				return dateText.replace(CURRENT_PROCESS_DATE + datePattern + "}", fechaProcesoActual(datePattern));
			}
			if (dateText.contains(PREVIOUS_PROCESS_DATE)) {
				String datePattern = dateText.substring(dateText.indexOf(PREVIOUS_PROCESS_DATE) + PREVIOUS_PROCESS_DATE.length(), dateText.indexOf("}"));
				return dateText.replace(PREVIOUS_PROCESS_DATE + datePattern + "}", fechaProcesoAnterior(datePattern));
			}
			if (dateText.contains(SYSTEM_DATE)) {
				String datePattern = dateText.substring(dateText.indexOf(SYSTEM_DATE) + SYSTEM_DATE.length(), dateText.indexOf("}"));
				return dateText.replace(SYSTEM_DATE + datePattern + "}", fechaSistema(datePattern));
			}
		}
		return dateText;
	}

	public static String getDay(String processDate) {
		Calendar date = stringToCalendar(processDate);
		String dia = null;
		if (date != null) {

			if (date.get(Calendar.DAY_OF_MONTH) < 10) {
				dia = "0" + String.valueOf(date.get(Calendar.DAY_OF_MONTH));
			} else {
				dia = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
			}
		}
		return dia;

	}

	public static String getYear(String processDate) {
		Calendar date = stringToCalendar(processDate);
		String anio = null;
		if (date != null) {
			anio = String.valueOf(date.get(Calendar.YEAR));
		}
		return anio;
	}

	public static String getMonth(String processDate) {
		String result = "";
		Calendar date = stringToCalendar(processDate);
		if (date != null) {
			int month = date.get(Calendar.MONTH);

			switch (month) {
			case 0: {
				result = "Enero";
				break;
			}
			case 1: {
				result = "Febrero";
				break;
			}
			case 2: {
				result = "Marzo";
				break;
			}
			case 3: {
				result = "Abril";
				break;
			}
			case 4: {
				result = "Mayo";
				break;
			}
			case 5: {
				result = "Junio";
				break;
			}
			case 6: {
				result = "Julio";
				break;
			}
			case 7: {
				result = "Agosto";
				break;
			}
			case 8: {
				result = "Septiembre";
				break;
			}
			case 9: {
				result = "Octubre";
				break;
			}
			case 10: {
				result = "Noviembre";
				break;
			}
			case 11: {
				result = "Diciembre";
				break;
			}
			default: {
				result = "ERROR";
				break;
			}
			}
		}
		return result;
	}

	public static Calendar stringToCalendar(String date) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Fecha a Convertir: " + date);
		}
		if (date != null && date != "") {
			Calendar cal = Calendar.getInstance();
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				cal.setTime(sdf.parse(date));
				return cal;
			} catch (Exception e) {
				LOGGER.error("ERROR AL CONVERTIR FECHA: ", e);
				return null;
			}
		}
		return null;
	}

	public static String getStringCurrencyFormated(Double amount) {
		NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("es", "MX"));
		return formatter.format(amount);
	}

	public static String fechaN(Calendar calendar) {
		SimpleDateFormat formateador = new SimpleDateFormat("dd 'de' MMMM 'del' yyyy", new Locale("es", "ES"));
		return formateador.format(calendar.getTime());
	}

}