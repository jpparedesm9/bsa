package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.extractOutputMap;

import cobiscorp.ecobis.businesstobusiness.dto.PaymentRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.common.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.dto.PaymentRequestDTO;
import com.cobiscorp.ecobis.cloud.service.util.Constants;

public class PaymentIntegration extends RestServiceBase {
	private final ILogger LOGGER = LogFactory.getLogger(PaymentIntegration.class);
	private final String className = "[PaymentIntegration] ";
	private ICTSServiceIntegration integration;
	private CommonsIntegration commonsIntegration;

	public PaymentIntegration(ICTSServiceIntegration integration) {
		super(integration); // TODO Auto-generated constructor stub
		this.integration = integration;
	}

	public void applyPayment(PaymentRequestDTO paymentRequestDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start applyPayment in " + className);
		}
		try {
			String processDate = null;
			commonsIntegration = new CommonsIntegration(integration);
			PaymentRequest paymentRequest = new PaymentRequest();

			paymentRequest.setCorrespondent(paymentRequestDto.getCorrespondent());
			paymentRequest.setReference(paymentRequestDto.getReference());
			paymentRequest.setPaymentAmount(paymentRequestDto.getPaymentAmount() == null ? null : String.valueOf(paymentRequestDto.getPaymentAmount()));
			paymentRequest.setTrnIdCorrespondent(paymentRequestDto.getTrnIdCorrespondent());
			paymentRequest.setPaymentUser(paymentRequestDto.getPaymentUser());
			processDate = commonsIntegration.getProcessDate(101);
			LOGGER.logDebug("processDate " + processDate);
			String[] partDate = processDate.split("/");
			if (partDate != null && partDate.length == 3) {
				LOGGER.logDebug("processDate string " +partDate[0] + partDate[1] + partDate[2]);
				paymentRequest.setPaymentDate(partDate[0] + partDate[1] + partDate[2]);
			}

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.setServiceId(Constants.SERV_APPLYPAYMENT);
			serviceRequestTO.addValue(Constants.IN_PAYMENTREQUEST, paymentRequest);
			ServiceResponse response = execute(Constants.SERV_APPLYPAYMENT, serviceRequestTO);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Outputs:" + extractOutputMap(response));
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish applyPayment in " + className);
			}
		}
	}
}
