package com.cobis.cloud.sofom.service.oxxo.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class OxxoValidateDate {
	public OxxoValidateDate() {
	}

	private static final ILogger logger = LogFactory.getLogger(OxxoValidator.class);

	public static boolean verificaDate(String fecha, int maxLength) {
		boolean flag = false;
		if (fecha.length() == maxLength) {
			String anio = fecha.substring(0, 4);
			String mes = fecha.substring(4, 6);
			String dia = fecha.substring(6, 8);
			String hora = fecha.substring(8, 10);
			String min = fecha.substring(10, 12);
			String seg = fecha.substring(12, 14);

			String fechaTrans = anio + "/" + mes + "/" + dia + " " + hora + ":" + min + ":" + seg;

			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			simpleDateFormat.setLenient(false);
			try {
				Date fechaVer = simpleDateFormat.parse(fechaTrans);

				if (fechaVer != null) {
					flag = true;
				}
			} catch (ParseException e) {
				logger.logError("FORMATO DE FECHA INVALIDA", e);
			}

		}

		return flag;
	}

}
