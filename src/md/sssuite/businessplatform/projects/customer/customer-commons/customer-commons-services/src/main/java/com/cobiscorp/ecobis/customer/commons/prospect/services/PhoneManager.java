package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class PhoneManager extends BaseEvent {

	public PhoneManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public TelephoneResponse createPhone(TelephoneRequest phoneRequest, ICommonEventArgs arg1) throws BusinessException {
		phoneRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		return (TelephoneResponse) callService.callServiceWithReturn(RequestName.PHONE_REQUEST, phoneRequest, ServiceId.CREATE_PHONE, ReturnName.PHONE_RETURN, arg1);
	}

	public void updatePhone(TelephoneRequest phoneRequest, ICommonEventArgs arg1) throws BusinessException {
		phoneRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.PHONE_REQUEST, phoneRequest, ServiceId.UPDATE_PHONE, arg1);
	}

	public void deletePhone(TelephoneRequest phoneRequest, ICommonEventArgs arg1) throws BusinessException {
		phoneRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.PHONE_REQUEST, phoneRequest, ServiceId.DELETE_PHONE, arg1);
	}

	public TelephoneResponse[] searchPhones(TelephoneRequest phoneRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		return (TelephoneResponse[]) callService.callServiceWithReturn(RequestName.PHONE_REQUEST, phoneRequest, ServiceId.SEARCH_PHONE, ReturnName.PHONE_RETURN, arg1);

	}
}
