package com.cobiscorp.ecobis.callcenter.commons.services;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.RequestName;
import com.cobiscorp.ecobis.callcenter.commons.constants.ServiceId;

import cobiscorp.ecobis.bussinescallcenter.dto.AutorizedDispositionRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.CallCenterQuestionRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class AutorizeDispositionManager extends BaseEvent {
	
	private static final ILogger logger = LogFactory.getLogger(AutorizeDispositionManager.class);

	public AutorizeDispositionManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public Map<String, Object> AutorizationDispositionMsm(AutorizedDispositionRequest autorizedDispositionRequest, ICommonEventArgs arg1) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.AUTORIZE_DISPOSITION_REQUEST, autorizedDispositionRequest);
		String message = "";
		@SuppressWarnings("unchecked")
		Map<String, Object> applicationResponse=null;
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.AUTORIZE_DISPOSITION_CALL_CENTER, serviceRequestApplicationTO);

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
