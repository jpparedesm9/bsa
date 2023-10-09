package cobiscorp.ecobis.integrationengine.conciliation.bussiness.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Util {
	private static final ILogger LOGGER = LogFactory.getLogger(Util.class);

	public static Calendar convertDateToCalendar(Date date) {
		Calendar calendar = Calendar.getInstance();

		try {
			if (date == null) {
				return null;
			}
			calendar.setTime(date);
		} catch (Exception ex) {
			LOGGER.logError(ex);
		}
		return calendar;
	}

	public static Date convertStringToDate(String dateInString) {
		Date date = null;
		SimpleDateFormat formatter = new SimpleDateFormat("MMddyyyy");

		try {
			if (dateInString == null || dateInString.length() != 8) {
				return null;
			}
			date = formatter.parse(dateInString);
		} catch (ParseException error) {
			LOGGER.logError(error);
		}
		return date;
	}
}
