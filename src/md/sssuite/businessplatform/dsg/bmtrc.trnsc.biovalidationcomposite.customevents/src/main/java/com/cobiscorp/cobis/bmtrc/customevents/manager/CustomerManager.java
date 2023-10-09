package com.cobiscorp.cobis.bmtrc.customevents.manager;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerAmountRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerAmountResponse;

public class CustomerManager extends BaseEvent {
	private static final String CUSTOMER_AMOUNT_REQUEST = "inCustomerAmountRequest";
	private static final String GET_CUSTOMER_AMOUNT = "CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount";
	private static final String CUSTOMER_AMOUNT_RESPONSE = "returnCustomerAmountResponse";

	private static final ILogger LOGGER = LogFactory.getLogger(CustomerManager.class);

	public CustomerManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerAmountResponse getLCRCustomerAmount(CustomerAmountRequest customerAmountRequest, ICommonEventArgs arg1) throws Exception {
		LOGGER.logDebug("Start getLCRCustomerAmount in CustomerManager");

		CallServices callService = new CallServices(getServiceIntegration());
		CustomerAmountResponse customerAmountResponse = (CustomerAmountResponse) callService.callServiceWithReturn(CUSTOMER_AMOUNT_REQUEST, customerAmountRequest,
				GET_CUSTOMER_AMOUNT, CUSTOMER_AMOUNT_RESPONSE, arg1);
		return customerAmountResponse;
	}
}
