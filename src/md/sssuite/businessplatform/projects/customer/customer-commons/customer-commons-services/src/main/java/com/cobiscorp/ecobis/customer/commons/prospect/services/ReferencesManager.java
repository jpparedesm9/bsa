package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class ReferencesManager  extends BaseEvent {

	public ReferencesManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public Integer createReferences(CustomerReferenceRequest referencesRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.REFERENCES_REQUEST, referencesRequest, ServiceId.CREATE_REFERENCES, Outputs.REFERENCESID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}
	
	public void updateReferences(CustomerReferenceRequest referencesRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.REFERENCES_REQUEST, referencesRequest, ServiceId.UPDATE_REFERENCES, arg1);

	}
	
	public void deleteReferences(CustomerReferenceRequest referencesRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.REFERENCES_REQUEST, referencesRequest, ServiceId.DELETE_REFERENCES, arg1);
	}
	
	public CustomerReferenceResponse[] searchReferences(CustomerReferenceRequest referencesRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		CustomerReferenceResponse[] business = callService.callServiceWithReturnArray(RequestName.REFERENCES_REQUEST, referencesRequest, ServiceId.SEARCH_REFERENCES,
				ReturnName.REFERENCES_RESPONSE, arg1);
		return business == null ? new CustomerReferenceResponse[0] : business;
	}

}
