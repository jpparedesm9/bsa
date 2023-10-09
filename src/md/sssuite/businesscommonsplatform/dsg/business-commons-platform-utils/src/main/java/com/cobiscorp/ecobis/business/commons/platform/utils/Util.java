package com.cobiscorp.ecobis.business.commons.platform.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;

public class Util {

	private static final ILogger LOGGER = LogFactory.getLogger(Util.class);

	public static Date getProcessDate() {
		try {

			return new SimpleDateFormat("MM/dd/yyyy").parse(ServerParamUtil.getProcessDate());

		} catch (ParseException pex) {
			return new Date();
		}
	}

	public static Date addDaysToDate(int numeroDias, Date fechaInicio) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fechaInicio == null ? getProcessDate() : fechaInicio);
		calendar.add(Calendar.DAY_OF_YEAR, numeroDias);
		return calendar.getTime();

	}

	public static int substractsDates(Date fechaInicio, Date fechaFin, ICommonEventArgs arg1) {
		Long diffDates = 0L;
		if (fechaInicio != null && fechaFin != null) {
			if (fechaFin.before(fechaInicio)) {
				arg1.getMessageManager().showErrorMsg("La Fecha de Vigencia debe ser mayor o igual a la Fecha de Proceso");

			} else {

				diffDates = fechaFin.getTime() - fechaInicio.getTime();

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("diffDates 0--->" + diffDates);
			}

		}

		diffDates = Math.round(Double.valueOf(diffDates) / Double.valueOf(1000 * 60 * 60 * 24));
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("diff-->" + diffDates);
		return diffDates.intValue();

	}
}
