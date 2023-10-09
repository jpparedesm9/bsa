package com.cobiscorp.ecobis.callcenter.commons.services;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.RequestName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ReturnName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ServiceId;
import com.cobiscorp.ecobis.callcenter.commons.services.utils.CallServices;

import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;


public class CallCenterQuestionsManager extends BaseEvent {
	
	private static final ILogger logger = LogFactory.getLogger(CallCenterQuestionsManager.class);

	public CallCenterQuestionsManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}


	public CallCenterQuestionResponse[] searchCallCenterQuestion(CallCenterQuestionRequest callCenterQuestionRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		CallCenterQuestionResponse[] callCenter = callService.callServiceWithReturnArray(RequestName.CALL_CENTER_QUESTION_REQUEST, callCenterQuestionRequest, ServiceId.SEARCH_CALL_CENTER_QUESTION, ReturnName.CALL_CENTER_QUESTION_RESPONSE, arg1);
		return callCenter == null ? new CallCenterQuestionResponse[0] : callCenter;
	}
	
	public Map<String, Object> validationQuestionMsm(CallCenterQuestionRequest callCenterQuestionRequest, ICommonEventArgs arg1) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.CALL_CENTER_QUESTION_REQUEST, callCenterQuestionRequest);
		String message = "";
		@SuppressWarnings("unchecked")
		Map<String, Object> applicationResponse=null;
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.VALIDATION_CALL_CENTER_QUESTION, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				
				 applicationResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				//message = applicationResponse.get("@o_error_mens").toString();
			} else {
				
				//MessageManagement.show(serviceResponse, arg1, options);
			}

		} else {
			//MessageManagement.show(serviceResponse, arg1, options);
		}
		return applicationResponse;
	}
	
	
	
	
}
