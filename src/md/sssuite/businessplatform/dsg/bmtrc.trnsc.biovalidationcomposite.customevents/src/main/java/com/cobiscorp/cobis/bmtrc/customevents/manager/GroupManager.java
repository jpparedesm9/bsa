package com.cobiscorp.cobis.bmtrc.customevents.manager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class GroupManager extends BaseEvent {
	private static final String GROUP_REQUEST = "inGroupRequest";
	private static final String SEARCH_GROUP = "LoanGroup.GroupMaintenance.SearchGroup";
	private static final String GROUP_RESPONSE = "returnGroupResponse";

	private static final ILogger LOGGER = LogFactory.getLogger(GroupManager.class);

	public GroupManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public GroupResponse searchGroup(GroupRequest groupRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("GroupManager serviceIntegration " + getServiceIntegration());

		CallServices callService = new CallServices(getServiceIntegration());
		GroupResponse groupResponse = (GroupResponse) callService.callServiceWithReturn(GROUP_REQUEST, groupRequest,
				SEARCH_GROUP, GROUP_RESPONSE, arg1);
		return groupResponse;
	}

}
