package com.cobis.cloud.sofom.service.seguros.integration;

import static com.cobis.cloud.sofom.service.seguros.utils.ServiceResponseUtil.extractValue;

import com.cobis.cloud.sofom.service.seguros.common.RestServiceBase;
import com.cobis.cloud.sofom.service.seguros.dto.CollectionResponse;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.google.gson.Gson;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mccollect.dto.CollectPaymentsRequest;
import cobiscorp.ecobis.mccollect.dto.CollectPaymentsResponse;
import cobiscorp.ecobis.mccollect.dto.PaymentSolidarityRequest;

public class SegurosIntegration extends RestServiceBase {

    private final ILogger logger = LogFactory.getLogger(SegurosIntegration.class);
    private final String className = "[SegurosIntegration] ";

    public SegurosIntegration(ICTSServiceIntegration integration) {
	super(integration);

    }

    public CollectPaymentsResponse[] searchListPaymentsCollect(String numberPayments) {

	if (logger.isDebugEnabled()) {
	    logger.logDebug("Start searchListPaymentsCollect of class: " + className);
	}

	ServiceRequestTO requestTO = new ServiceRequestTO();
	CollectPaymentsRequest paymentsCollect = new CollectPaymentsRequest();
	paymentsCollect.setNumPrestamo(numberPayments);
	paymentsCollect.setOperacion("Q");
	requestTO.setServiceId("PaymentsCollect.PaymentsCollect.QueryListCollect");
	requestTO.addValue("inCollectPaymentsRequest", paymentsCollect);
	ServiceResponse response = execute("PaymentsCollect.PaymentsCollect.QueryListCollect", requestTO);
	logger.logDebug(requestTO);
	return extractValue(response, "returnCollectPaymentsResponse", CollectPaymentsResponse[].class);

    }

    public void insertTempPaymentSolidarity(PaymentSolidarityRequest paymentSolidarityRequest) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.setServiceId("McCollect.PaymentsCollect.InsertPaymentSolidarity");
		serviceRequestTO.addValue("inPaymentSolidarityRequest", paymentSolidarityRequest);
		ServiceResponse serviceResponse = this.execute("McCollect.PaymentsCollect.InsertPaymentSolidarity", serviceRequestTO);

		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[updatePaymentSolidarity][ServiceResponse]:" + gson.toJson(serviceResponse));
		}
        
		logger.logDebug("Inserccion en tablas paymentSolidarityRequest Operation---> " + paymentSolidarityRequest.getOperation());
		logger.logDebug("Inserccion en tablas paymentSolidarityRequest---> " + serviceRequestTO.getData());

	}
    
    public ServiceResponse validatePaymentSolidarity(PaymentSolidarityRequest paymentSolidarityRequest) {
    	ServiceRequestTO requestTo = new ServiceRequestTO();
    	requestTo.addValue("inPaymentSolidarityRequest", paymentSolidarityRequest);
    	return executeNormal("McCollect.PaymentsCollect.ValidatePaymentSolidarity", requestTo);
    }
    
    public ServiceResponse updatePaymentSolidarity(PaymentSolidarityRequest paymentSolidarityRequest) {
    	ServiceRequestTO requestTo = new ServiceRequestTO();
    	requestTo.addValue("inPaymentSolidarityRequest", paymentSolidarityRequest);
    	return executeNormal("McCollect.PaymentsCollect.UpdatePaymentSolidarity", requestTo);
    }
    

}
