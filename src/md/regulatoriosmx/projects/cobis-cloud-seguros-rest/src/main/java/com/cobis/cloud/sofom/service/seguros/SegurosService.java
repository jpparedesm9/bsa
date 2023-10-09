package com.cobis.cloud.sofom.service.seguros;

import javax.ws.rs.core.Response;

import com.cobis.cloud.sofom.service.seguros.dto.SolidarityPaymentRequest;

public interface SegurosService {
	Response consulta(String loanNumber);
	Response updateSolidarityPayment(SolidarityPaymentRequest solidarityPaymentRequest);
}
