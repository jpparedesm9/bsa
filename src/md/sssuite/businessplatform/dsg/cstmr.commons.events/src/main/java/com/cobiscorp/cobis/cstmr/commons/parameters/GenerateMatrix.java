package com.cobiscorp.cobis.cstmr.commons.parameters;

import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

public class GenerateMatrix extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(GenerateMatrix.class);

	public GenerateMatrix(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public String generateMatrix(CustomerRequest customerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.IN_CUSTOMER_REQUEST, customerRequest);
		String message = "";
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.GENERATE_MATRIX, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				message = applicationResponse.get("@o_error_mens").toString();
			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}

		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return message;
	}
}
