package com.cobiscorp.cobis.assets.commons.sessions;

import java.util.UUID;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class LoanInstanceSession {
	private static final ILogger logger = LogFactory
			.getLogger(LoanInstanceSession.class);

	private LoanInstanceSession() {
	  }
	/**
	 * obtiene un codigo aleatorio
	 * 
	 * @return String en el metodo obtenerCodigoAleatorio
	 */
	public static String obtenerCodigoAleatorio(String id) {

		if (id != null && !"".endsWith(id.trim())) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Se obtiene el identificador aleatorio de designer");
			}
			return id.replace('-', '\0');
		} else {
			logger.logDebug("Se obtiene el identificador aleatorio del cotizador");
			return UUID.randomUUID().toString().replace('-', '\0')
					.substring(0, 16);
		}
	}

}
