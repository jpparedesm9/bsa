package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class GroupManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(GroupManagement.class);

	public GroupManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
		
	public GroupResponse searchGroup(GroupRequest groupRequest, ICommonEventArgs arg1) {
		logger.logDebug("Busin - GroupManagement serviceIntegration " + getServiceIntegration());

		CallServices callService = new CallServices(getServiceIntegration());
		GroupResponse groupResponse = (GroupResponse) callService.callServiceWithReturn(RequestName.GROUP_REQUEST, groupRequest,
				ServiceId.SEARCH_GROUP, ReturnName.GROUP_RESPONSE, arg1);
		return groupResponse;
	}

}
