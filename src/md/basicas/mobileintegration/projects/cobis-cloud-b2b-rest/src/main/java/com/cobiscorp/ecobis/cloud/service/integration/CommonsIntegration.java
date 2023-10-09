package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.DateRequest;
import cobiscorp.ecobis.systemconfiguration.dto.DateResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.common.RestServiceBase;

public class CommonsIntegration extends RestServiceBase{
	public CommonsIntegration(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	private final ILogger LOGGER = LogFactory.getLogger(CommonsIntegration.class);

	public String getProcessDate(int dateFormat) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("getProcessDate --->" + dateFormat);
		DateRequest dateRequestDTO = new DateRequest();
		dateRequestDTO.setDateFormat(dateFormat);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inDateRequest", dateRequestDTO);
		ServiceResponse serviceResponse = this.execute("SystemConfiguration.ParameterManagement.ProcessDate", serviceRequestTO);

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("getProcessDate --->" + dateFormat);
		ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
		return ((DateResponse) serviceItemsResponseTO.getValue("returnDateResponse")).getProcessDate();

	}
}
