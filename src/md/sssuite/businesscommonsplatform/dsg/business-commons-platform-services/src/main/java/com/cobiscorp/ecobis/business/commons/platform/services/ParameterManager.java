package com.cobiscorp.ecobis.business.commons.platform.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientResponse;

public class ParameterManager extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ParameterManager.class);

	public ParameterManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public ParameterResponse getParameterFromManager(int mode, String parameterNemonic, String productNemonic) throws BusinessException, Exception {
		LOGGER.logDebug("start getParameterFromManager");
		ParameterRequest parameterRequest = new ParameterRequest();
		parameterRequest.setMode(mode);
		parameterRequest.setParameterNemonic(parameterNemonic);
		parameterRequest.setProductNemonic(productNemonic);
		return getParameterFromManager(parameterRequest);
	}

	public ParameterResponse getParameter(int mode, String parameterNemonic, String productNemonic, ICommonEventArgs arg1) throws BusinessException, Exception {
		ParameterRequest parameterRequest = new ParameterRequest();
		parameterRequest.setMode(mode);
		parameterRequest.setParameterNemonic(parameterNemonic);
		parameterRequest.setProductNemonic(productNemonic);
		return getParameter(parameterRequest, arg1);
	}

	public ParameterResponse getParameter(ParameterRequest parameterRequest, ICommonEventArgs arg1) throws BusinessException, Exception {
		CallServices callServices = new CallServices(getServiceIntegration());
		return (ParameterResponse) callServices.callServiceWithReturn(RequestName.INPARAMETERREQUEST, parameterRequest, ServiceId.PARAMETERMANAGEMENT,
				ReturnName.RETURNPARAMETERRESPONSE, arg1);

	}

	public ParameterResponse getParameterFromManager(ParameterRequest parameterRequest) throws BusinessException, Exception {
		LOGGER.logDebug("start getParameterFromManager ..");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INPARAMETERREQUEST, parameterRequest);
		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.PARAMETERMANAGEMENT, serviceRequestTO);
		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponse.getData();		
			return (ParameterResponse) dataResponse.getValue(ReturnName.RETURNPARAMETERRESPONSE);
		}
		return null;
		
	}
}