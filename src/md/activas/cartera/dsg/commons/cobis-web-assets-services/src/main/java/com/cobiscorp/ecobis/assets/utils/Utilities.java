package com.cobiscorp.ecobis.assets.utils;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.assets.constants.Constants;
import com.cobiscorp.ecobis.assets.dto.StructureDTO;

public class Utilities {
	private static final ILogger logger = LogFactory.getLogger(Utilities.class);

	public static List<Map<String, StructureDTO>> getPaymentOperators(String operatorId) throws Exception {
		ReadConfigurationFile readConfigurationFile = new ReadConfigurationFile();
		List<Map<String, StructureDTO>> values = readConfigurationFile.readConfigFile(Constants.CONFIGPAYMENTOPERATORS, operatorId);
		logger.logDebug("values" + values);
		return values;
	}

	public static String getReference(String reference) {

		if (reference != null && reference.indexOf(Constants.SEPARATOR_REFERENCE) >= 0) {
			reference = reference.substring(reference.indexOf(Constants.SEPARATOR_REFERENCE) + 1, reference.length()).trim();
		}

		if (logger.isDebugEnabled())
			logger.logDebug("Reference: " + reference);

		return reference;
	}

	/**
	 * @param value
	 * @param format
	 * @param groupSeparator
	 * @param decimalSeparator
	 * @return
	 * @throws Exception
	 * @description Format String in money, float or double format to Double
	 */
	public static Double formatStringToDouble(String value, StructureDTO structure) throws Exception {

		if (value == null) {
			return null;
		}
		if (structure == null) {
			throw new Exception("No se encuentra definida la parametría para el campo monto.");
		}
		try {

			DecimalFormat decimalFormat = new DecimalFormat(structure.getFormat());
			DecimalFormatSymbols decimalFormatSymbols = decimalFormat.getDecimalFormatSymbols();

			decimalFormatSymbols.setDecimalSeparator(structure.getDecimalSeparator());
			decimalFormatSymbols.setGroupingSeparator(structure.getGroupSeparator());

			Number number = decimalFormat.parse(value);
			return number == null ? null : number.doubleValue();
		} catch (ParseException e) {
			logger.logError("formatStringToFloat ParseException: " + e);
			throw e;
		} catch (Exception ex) {
			logger.logError("formatStringToFloat Exception: " + ex);
			throw ex;
		}

	}

	/**
	 * @param value
	 * @param format
	 * @return
	 * @throws Exception
	 * @description Format String into Calendar date
	 */
	public static Calendar formatStringToCalendar(String value, StructureDTO structure) throws Exception {
		if (value == null) {
			return null;
		}
		Calendar calendar = null;
		Date date = null;
		try {
			
			if (structure == null) {
				throw new Exception("No se encuentra definida la parametría para el campo fecha de pago.");
			}
			DateFormat dateFormat = new SimpleDateFormat(structure.getFormat());
			date = dateFormat.parse(value);
			if (date == null) {
				return null;
			}
			calendar = Calendar.getInstance();
			calendar.setTime(date);
		} catch (ParseException e) {
			logger.logError("formatStringToCalendar ParseException: " + e);
			throw e;
		} catch (Exception ex) {
			logger.logError("formatStringToCalendar Exception: " + ex);
			throw ex;
		}

		return calendar;

	}

}
