package com.cobiscorp.ecobis.callcenter.commons.services;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.RequestName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ReturnName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ServiceId;
import com.cobiscorp.ecobis.callcenter.commons.services.utils.CallServices;

import cobiscorp.ecobis.bussinescallcenter.dto.LoginCallCenterRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.LoginCallCenterResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoginCallCenterManager extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(LoginCallCenterManager.class);

	public LoginCallCenterManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public LoginCallCenterResponse searchLoginClient(LoginCallCenterRequest loginCallCenterRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		LoginCallCenterResponse loginCallCenterResponse = (LoginCallCenterResponse) callService.callServiceWithReturn(RequestName.LOGIN_CALL_CENTER_REQUEST, loginCallCenterRequest, ServiceId.SEARCH_LOGIN_CALL_CENTER, ReturnName.LOGIN_CALL_CENTER_RESPONSE, arg1);
		return loginCallCenterResponse;
	}

	public LoginCallCenterResponse[] searchLoginClientList(LoginCallCenterRequest loginCallCenterRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		LoginCallCenterResponse[] loginCallCenterResponse = callService.callServiceWithReturnArray(RequestName.LOGIN_CALL_CENTER_REQUEST, loginCallCenterRequest, ServiceId.SEARCH_LOGIN_CALL_CENTER, ReturnName.LOGIN_CALL_CENTER_RESPONSE, arg1);
		return loginCallCenterResponse == null ? new LoginCallCenterResponse[0] : loginCallCenterResponse;
	}

}
