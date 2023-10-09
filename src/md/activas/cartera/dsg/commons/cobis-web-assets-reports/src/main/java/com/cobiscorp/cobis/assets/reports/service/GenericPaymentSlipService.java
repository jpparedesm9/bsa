package com.cobiscorp.cobis.assets.reports.service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.GenericPaymentSlipResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class GenericPaymentSlipService extends BaseService {

	private static final ILogger LOGGER = LogFactory.getLogger(GenericPaymentSlipService.class);

	public GenericPaymentSlipResponse queryGenericPaymentSlip(LoanRequest loanRequest, ICTSServiceIntegration serviceIntegration) throws Exception {

		LOGGER.logDebug("----->>>Inicio GenericPaymentSlipService -- queryGenericPaymentSlip");
		ServiceResponseTO serviceResponseTo = null;
		try {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_GENERIC_PAYMENT_SLIP);
			serviceReportRequestTO.getData().put(ConstantValue.IN_LOAN_REQUEST, loanRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					GenericPaymentSlipResponse genericPaymentSlipResponse = (GenericPaymentSlipResponse) serviceResponseTo
							.getValue(ConstantValue.RETURN_GENERICPAYMENTSLIP_RESPONSE);
					return genericPaymentSlipResponse;
				} else {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("Error ejecucion servicio queryGenericPaymentSlip");
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Error en " + ConstantValue.SERVICE_GENERIC_PAYMENT_SLIP, ex);
			util.error(serviceResponseTo);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finaliza " + ConstantValue.SERVICE_GENERIC_PAYMENT_SLIP);
		}
		return null;
	}
}
