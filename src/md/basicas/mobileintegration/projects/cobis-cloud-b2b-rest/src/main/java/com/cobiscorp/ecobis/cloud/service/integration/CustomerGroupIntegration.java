package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.extractValue;
import cobiscorp.ecobis.businesstobusiness.dto.CustomerGroupRequest;
import cobiscorp.ecobis.businesstobusiness.dto.CustomerGroupResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.common.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.util.Constants;

public class CustomerGroupIntegration extends RestServiceBase {
	private final ILogger LOGGER = LogFactory.getLogger(CustomerGroupIntegration.class);
	private final String className = "[CustomerGroupIntegration] ";

	public CustomerGroupIntegration(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	public CustomerGroupResponse[] searchClientGroupByName(String name, String type, int sequential) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start searchClientGroupByName in " + className);
		}
		try {
			CustomerGroupRequest customerGroupRequest = new CustomerGroupRequest();
			customerGroupRequest.setCustomerGroupName(name);
			customerGroupRequest.setType(type);
			customerGroupRequest.setSequential(sequential);
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.setServiceId(Constants.SERV_SEARCHCUSTOMERGROUPBYNAME);
			serviceRequestTO.addValue(Constants.IN_CUSTOMERGROUPREQUEST, customerGroupRequest);
			ServiceResponse response = execute(Constants.SERV_SEARCHCUSTOMERGROUPBYNAME, serviceRequestTO);

			return extractValue(response, Constants.RETURN_CUSTOMERGROUPRESPONSE, CustomerGroupResponse[].class);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish searchClientGroupByName in " + className);
			}
		}
	}

}
