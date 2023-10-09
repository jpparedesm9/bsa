package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.constants.Constants;

/**
 * @author srojas
 * 
 */
public class Utils {

	private static final ILogger logger = LogFactory.getLogger(Utils.class);

	public static final Map<Integer, String> formatMap = new HashMap<Integer, String>();

	public static int mapIndex = 0;

	public static void initFormatMap() {
		if (formatMap.size() == 0) {
			formatMap.put(0, Constants.CTS_FORMAT_DATE);
			formatMap.put(1, Constants.BRANCH_FORMAT_DATE);
		}
	}

	// Get SQL code date format
	public static String getDateFormatter(Integer key) {
		if (formatMap.containsKey(key)) {
			return formatMap.get(key);
		}
		return null;

	}

	public static Date parseDate(String requestDate) {
		initFormatMap();
		if (requestDate != null && !requestDate.trim().equals("")) {

			while (mapIndex < formatMap.size()) {
				try {
					DateFormat simpleDateFormat = new SimpleDateFormat(formatMap.get(mapIndex));
					return simpleDateFormat.parse(requestDate);
				} catch (ParseException pex) {
					mapIndex = mapIndex + 1;
				}

			}
		}
		mapIndex = 0;
		return null;

	}

	public static String formatContextDate(Date requestDate) {
		if (requestDate != null) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.SIMPLE_FORMAT_DATE);
			return simpleDateFormat.format(requestDate);

		}
		return null;
	}

	public static Date parseContextDate(String requestDate) {
		if (requestDate != null) {
			try {
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.SIMPLE_FORMAT_DATE);
				return simpleDateFormat.parse(requestDate);
			} catch (ParseException pex) {
				logger.logError("parseContextDate: Cannot parse date " + requestDate);
				return null;
			}

		}
		return null;
	}

	public static String replaceLongTimeDate(String requestDate) {
		if (requestDate != null) {
			if ((requestDate.contains("12:00:00:000"))) {
				if (logger.isTraceEnabled()) {
					logger.logDebug("S->valor request date " + requestDate);
				}

			} else {
				if (logger.isTraceEnabled()) {
					logger.logDebug("N->valor request date " + requestDate);
				}

				if (requestDate.contains("00:00:00.000")) {
					requestDate = requestDate.replaceAll("00:00:00.000", "23:59:00.000");
				} else {
					requestDate = requestDate.concat(" 23:59");
				}

			}
		}
		return requestDate;
	}

	public static String replaceShortTimeDate(String requestDate) {
		if (requestDate != null) {
			if (requestDate.contains("00:00")) {
				requestDate = requestDate.replaceAll("00:00", "23:59");
			}

		}
		return requestDate;
	}

}
