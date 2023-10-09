package com.cobiscorp.cobis.assets.commons.services;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ReturnName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.regularizepayments.dto.PaymentMethodRequest;
import cobiscorp.ecobis.regularizepayments.dto.PaymentMethodResponse;

public class PagosObjetadosServices extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(PagosObjetadosServices.class);

	public PagosObjetadosServices(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		LOGGER.logDebug("serviceIntegration != null" + (serviceIntegration != null));
	}

	public PaymentMethodResponse[] queryProductList(PaymentMethodRequest request) {
		LOGGER.logDebug("getServiceIntegration():..... " + getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.PAYMENT_METHOD_REQUEST, request);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_PAYMENT_METHODS,
				serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (PaymentMethodResponse[]) serviceResponseItemsTO.getValue(ReturnName.PAYMENT_METHOD_RESPONSE);
		} else {
			LOGGER.logError("Error en el servicio de consulta lista de productos");
			return null;
		}

	}

}
