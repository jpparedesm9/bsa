package com.cobis.cloud.sofom.service.oxxo;

import javax.ws.rs.core.Response;

import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaRequest;

public interface OxxoService {
	Response consulta(String token, String client);

	Response pay(String token, OlsPagoRequest olsPagoRequest);

	Response reverse(String token, OlsReversaRequest olsReversaRequest);
}
