package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessResp;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class BusinessManager  extends BaseEvent {

	public BusinessManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public Integer createBusiness(CustomerBusinessRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		addressRequest.setChannel("CWC");
		Object object = callService.callServiceWithOutput(RequestName.BUSINESS_REQUEST, addressRequest, ServiceId.CREATE_BUSINESS, Outputs.BUSINESSID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}
	
	public void updateBusiness(CustomerBusinessRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		businessRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.BUSINESS_REQUEST, businessRequest, ServiceId.UPDATE_BUSINESS, arg1);

	}
	
	public void deleteBusiness(CustomerBusinessRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		businessRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.BUSINESS_REQUEST, businessRequest, ServiceId.DELETE_BUSINESS, arg1);
	}
	
	public CustomerBusinessResp[] searchBusiness(CustomerBusinessRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		CustomerBusinessResp[] business = callService.callServiceWithReturnArray(RequestName.BUSINESS_REQUEST, businessRequest, ServiceId.SEARCH_BUSINESS,
				ReturnName.BUSINESS_RESPONSE, arg1);
		return business == null ? new CustomerBusinessResp[0] : business;
	}
	
	public CustomerBusinessResp searchAddressHome(CustomerBusinessRequest addressHomeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		CustomerBusinessResp addressHomeResponse = (CustomerBusinessResp) callService.callServiceWithReturn(RequestName.BUSINESS_REQUEST, addressHomeRequest, ServiceId.SEARCH_ADDRESSHOME,
				ReturnName.BUSINESS_RESPONSE, arg1);
		return addressHomeResponse;
	}

}
