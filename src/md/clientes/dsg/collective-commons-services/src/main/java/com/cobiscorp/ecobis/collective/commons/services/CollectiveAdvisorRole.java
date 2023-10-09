package com.cobiscorp.ecobis.collective.commons.services;

import java.util.Map;

import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.constants.RequestName;
import com.cobiscorp.ecobis.collective.commons.constants.ReturnName;
import com.cobiscorp.ecobis.collective.commons.constants.ServiceId;
import com.cobiscorp.ecobis.collective.commons.services.utils.CallServices;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.AdvisorRoleRequest;
import cobiscorp.ecobis.collective.dto.AdvisorRoleResponse;
import cobiscorp.ecobis.collective.dto.OfficialByRoleResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveAdvisorRoleResponse;

public class CollectiveAdvisorRole extends BaseEvent{
	private ICTSServiceIntegration serviceIntegration;
	
	public CollectiveAdvisorRole(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public AdvisorRoleResponse[] queryAdvisorRole(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {

		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithReturnArray(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.QUERY_COLLECTIVE_ADVISOR_ROLE, ReturnName.RETURN_COLLECTIVE_ADVISOR_ROLE, args);
	}
	
	public OfficialByRoleResponse[] queryOfficialByRole(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithReturnArray(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.QUERY_OFFICIAL_BY_ROLE, ReturnName.RETURN_OFFICIAL_BY_ROLE, args);

	}
	
	public CollectiveAdvisorRoleResponse[] queryCollective(cobiscorp.ecobis.customerdatamanagement.dto.CollectiveAdvisorRole collectiveAdvisorRole, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithReturnArray(RequestName.COLLECTIVE_LOAD_CATALOG_REQUEST, collectiveAdvisorRole, ServiceId.COLLECTIVE_LOAD_CATALOG, ReturnName.RETURN_COLLECTIVE_ADVISOR_ROLE_LOAD_CATALOG, args);

	}
	
	public void insertAdvisorRole(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		callService.callService(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.INSERT_ADVISOR_ROLE, args);
	}
	
	public void deleteAdvisorRole(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		callService.callService(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.DELETE_ADVISOR_ROLE, args);

	}
	
	/*public void deleteAdvisorRoleTest(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		callService.callService(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.DELETE_ADVISOR_ROLE, args);

	}*/
	
	public Map<String, Object> deleteAdvisorRoleTest(AdvisorRoleRequest entityRequest, ICommonEventArgs args) {
		//ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		//serviceRequestTO.addValue(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest);

		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithOutput(RequestName.COLLECTIVE_ADVISOR_ROLE_REQUEST, entityRequest, ServiceId.DELETE_ADVISOR_ROLE, args);

	}
}
