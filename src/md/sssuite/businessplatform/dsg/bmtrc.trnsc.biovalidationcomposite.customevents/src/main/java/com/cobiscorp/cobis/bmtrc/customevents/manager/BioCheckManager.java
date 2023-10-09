package com.cobiscorp.cobis.bmtrc.customevents.manager;

import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckRequest;
import cobiscorp.ecobis.customerbiocheck.dto.CustomerBiocheckResponse;

public class BioCheckManager extends BaseEvent {
	private static final String RETURN_CUSTOMER_BIOCHECK = "returnCustomerBiocheckResponse";
	private static final String GET_WITHOUTFRINGERPRINT_SERVICE = "CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint";
	private static final String CUSTOMER_BIOCHECK_REQUEST = "inCustomerBiocheckRequest";

	public BioCheckManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerBiocheckResponse[] getWithoutFingerPrint(Integer customerId, Integer processInstance,
			String customerType, ICommonEventArgs args) {
		CustomerBiocheckRequest customerRequest = new CustomerBiocheckRequest();
		customerRequest.setCustomerType(customerType);
		customerRequest.setEnte(customerId);
		customerRequest.setOperation("Q");
		customerRequest.setInstance(processInstance);
		CallServices callService = new CallServices(getServiceIntegration());
		return (CustomerBiocheckResponse[]) callService.callServiceWithReturn(CUSTOMER_BIOCHECK_REQUEST,
				customerRequest, GET_WITHOUTFRINGERPRINT_SERVICE, RETURN_CUSTOMER_BIOCHECK, args);

	}

	public String validateData(Integer customerId, Integer processInstance, String customerType,
			ICommonEventArgs args) {
		CustomerBiocheckRequest customerRequest = new CustomerBiocheckRequest();
		customerRequest.setCustomerType(customerType);
		customerRequest.setEnte(customerId);
		customerRequest.setOperation("V");
		customerRequest.setInstance(processInstance);
		CallServices callService = new CallServices(getServiceIntegration());
		return (String) callService.callServiceWithOutput(CUSTOMER_BIOCHECK_REQUEST, customerRequest,
				GET_WITHOUTFRINGERPRINT_SERVICE, "@o_respuesta", args);

	}
}
