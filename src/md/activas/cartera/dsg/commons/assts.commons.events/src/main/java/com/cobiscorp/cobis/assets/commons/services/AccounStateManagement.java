package com.cobiscorp.cobis.assets.commons.services;

import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.AccountStatusRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.utils.Function;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class AccounStateManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(AccounStateManagement.class);

	public AccounStateManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean getCreateStateAccount(AccountStatusRequest accountStatusRequest, ICommonEventArgs arg1, BehaviorOption options) {
		Boolean flag = false;
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue("inAccountStatusRequest", accountStatusRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, Parameter.CREATE_STATE_ACCOUNT, serviceRequestApplicationTO);

		logger.logDebug("getCreateStateAccount serviceResponse**" + serviceResponse);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("getCreateStateAccount result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("getCreateStateAccount serviceResponseTo success");
				flag = true;
			} else {
				arg1.getMessageManager().showErrorMsg(Function.getSpsMessages(serviceResponse.getMessages()));
				logger.logDebug("getCreateStateAccount serviceResponseTo doesn't success");
			}
		} else {
			if (serviceResponse != null)
				logger.logDebug("getCreateStateAccount result" + serviceResponse.isResult());
			arg1.getMessageManager().showErrorMsg(Function.getSpsMessages(serviceResponse.getMessages()));
		}
		return flag;
	}

	public Integer generateSequential(AccountStatusRequest accountStatusRequest, ICommonEventArgs arg1, BehaviorOption options) {
		Integer sequential = 0;
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(Parameter.ACCOUNT_STATUS_REQUEST, accountStatusRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, Parameter.EXECUTION_OPTIONS, serviceRequestApplicationTO);

		logger.logDebug("-->>Inicio AccounStateManagement - generateSequential serviceResponse:" + serviceResponse);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("-->>AccounStateManagement getCreateStateAccount result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("-->>AccounStateManagement getCreateStateAccount - isSuccess - NumBanco:" + accountStatusRequest.getBanco());

				@SuppressWarnings("unchecked")
				Map<String, Object> accountStatusResponse = (Map<String, Object>) serviceResponseTo.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (accountStatusResponse.get("@o_mensaje") != null) {
					arg1.getMessageManager().showErrorMsg(accountStatusResponse.get("@o_mensaje").toString() + " - " + accountStatusRequest.getBanco());
				}
				if (accountStatusResponse.get("@o_secuencial") != null) {
					return sequential = Integer.parseInt(accountStatusResponse.get("@o_secuencial").toString());
				}
			}
		} else {
			if (serviceResponse != null)
				logger.logDebug("-->>AccounStateManagement getCreateStateAccount result" + serviceResponse.isResult());
			arg1.getMessageManager().showErrorMsg(Function.getSpsMessages(serviceResponse.getMessages()));
		}
		logger.logDebug("-->>Fin AccounStateManagement getCreateStateAccount -- sequential:" + sequential);
		return sequential;
	}
}
