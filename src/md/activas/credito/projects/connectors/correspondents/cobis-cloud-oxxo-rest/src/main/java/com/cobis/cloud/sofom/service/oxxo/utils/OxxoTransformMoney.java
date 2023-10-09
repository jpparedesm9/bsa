package com.cobis.cloud.sofom.service.oxxo.utils;

import java.math.BigDecimal;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class OxxoTransformMoney {
	public OxxoTransformMoney() {
	}

	private static final ILogger logger = LogFactory.getLogger(OxxoTransformMoney.class);

	public static int convertInt(String numCent) {
		int numero = 0;

		try {
			numCent = numCent == null ? "0" : numCent;
			BigDecimal bd = new BigDecimal(numCent).multiply(new BigDecimal(100));
			numero = bd.intValue();
		} catch (Exception e) {
			logger.logError("Error en el metod convertInt", e);
		}

		return numero;
	}

}
