package com.cobis.cloud.sofom.service.oxxo.response;

import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoResponse;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaResponse;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoValidator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class OlsResponseError {
	public OlsResponseError() {
	}

	private static final ILogger logger = LogFactory.getLogger(OlsResponseError.class);

	public static OlsPagoResponse errorPagoResponse(OlsPagoRequest olsPagoRequest) {

		logger.logDebug("Inicio ejecucion metodo errorPagoResponse");

		OlsPagoResponse olsPagoResponse = new OlsPagoResponse();

		try {

			if (OxxoValidator.validate(olsPagoRequest) != null) {
				olsPagoResponse.setMessageTicket("NO SE PUDO REALIZAR EL PAGO ");
				olsPagoResponse.setAccount("");
				olsPagoResponse.setCode(OxxoValidator.validate(olsPagoRequest).getCode());
				olsPagoResponse.setErrorDesc(OxxoValidator.validate(olsPagoRequest).getDescription());
			}
		} catch (Exception e) {
			logger.logDebug("Error al validar: ", e);
		}
		logger.logDebug("RESPUESTA DEL PAGO: " + olsPagoResponse.toString());
		return olsPagoResponse;
	}

	public static OlsReversaResponse errorReverseResponse(OlsReversaRequest olsReversaRequest) {

		logger.logDebug("Inicio ejecucion de metodo errorReverseResponse");

		OlsReversaResponse olsReverseResponse = new OlsReversaResponse();

		try {

			logger.logDebug("REVERSE: " + olsReversaRequest.toString());

			if (OxxoValidator.validate(olsReversaRequest) != null) {

				olsReverseResponse.setCode(OxxoValidator.validate(olsReversaRequest).getCode());
				olsReverseResponse.setErrorDesc(OxxoValidator.validate(olsReversaRequest).getDescription());
				olsReverseResponse.setMessageTicket("NO SE PUDO REALIZAR EL REVERSO");

			} else {
				olsReverseResponse = null;
			}
		} catch (Exception e) {
			logger.logDebug("Error al validar: ", e);
		}

		return olsReverseResponse;

	}

}
