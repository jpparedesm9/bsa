package com.cobiscorp.ecobis.mobile.commons.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.MobileFilterRequest;
import cobiscorp.ecobis.mobilemanagement.dto.MobileRequest;
import cobiscorp.ecobis.mobilemanagement.dto.MobileResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;
import com.cobiscorp.ecobis.mobile.commons.services.utils.CallServices;

public class MobileManager  extends BaseEvent {

	public MobileManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public Integer createMobiles(MobileRequest mobilesRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.MOBILES_REQUEST, mobilesRequest, ServiceId.CREATE_MOBILES, Outputs.MOBILESID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}
	
	public void updateMobiles(MobileRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.MOBILES_REQUEST, businessRequest, ServiceId.UPDATE_MOBILES, arg1);

	}
	
	public void deleteMobiles(MobileRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.MOBILES_REQUEST, businessRequest, ServiceId.DELETE_MOBILES, arg1);
	}
	
	public MobileResponse[] searchMobiles(MobileRequest businessRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		MobileResponse[] business = callService.callServiceWithReturnArray(RequestName.MOBILES_REQUEST, businessRequest, ServiceId.SEARCH_MOBILES, ReturnName.MOBILES_RESPONSE,
				arg1);
		return business == null ? new MobileResponse[0] : business;
	}

	public MobileResponse[] searchMobilesByFilter(MobileFilterRequest mobileFilterRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		MobileResponse[] business = callService.callServiceWithReturnArray(RequestName.MOBILES_BY_FILTER_REQUEST, mobileFilterRequest, ServiceId.SEARCH_MOBILES_BY_FILTER,
				ReturnName.MOBILES_RESPONSE, arg1);
		return business == null ? new MobileResponse[0] : business;
	}
}
