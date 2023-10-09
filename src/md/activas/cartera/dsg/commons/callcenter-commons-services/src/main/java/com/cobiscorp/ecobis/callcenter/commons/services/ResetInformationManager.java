package com.cobiscorp.ecobis.callcenter.commons.services;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.RequestName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ServiceId;
import com.cobiscorp.ecobis.callcenter.commons.services.utils.CallServices;

import cobiscorp.ecobis.bussinescallcenter.dto.ResetInformationRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ResetInformationManager extends BaseEvent{
	
	private static final ILogger logger = LogFactory.getLogger(ResetInformationManager.class);

	public ResetInformationManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}
	
	public void resetImageMessage (ResetInformationRequest informationRequest, ICommonEventArgs arg1) throws BusinessException{
		
		logger.logDebug("ResetInformationRequest -- DTO: " + informationRequest);
		logger.logDebug("ResetInformationRequest -- DTO: " + informationRequest.getCodClienteReset());
		logger.logDebug("RequestName.RESET_IMG_MESSAGE_REQUEST: " + RequestName.RESET_IMG_MESSAGE_REQUEST);
		logger.logDebug("ServiceId.RESET_IMAGE_MESSAGE_CALL_CENTER: " + ServiceId.RESET_IMAGE_MESSAGE_CALL_CENTER);
		
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.RESET_IMG_MESSAGE_REQUEST, informationRequest, ServiceId.RESET_IMAGE_MESSAGE_CALL_CENTER, arg1);
	}
	
}
