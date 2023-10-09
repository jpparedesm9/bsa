package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.busin.customevents.utils.Outputs;
import com.cobiscorp.cobis.busin.customevents.utils.RequestName;
import com.cobiscorp.cobis.busin.customevents.utils.ReturnName;
import com.cobiscorp.cobis.busin.customevents.utils.ServiceId;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class GroupManager extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(GroupManager.class);

	public GroupManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public Integer createGroup(GroupRequest groupRequest, ICommonEventArgs arg1) {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.GROUP_REQUEST, groupRequest, ServiceId.INSERT_GROUP, Outputs.GROUPID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

	public void updateGroup(GroupRequest groupRequest, ICommonEventArgs arg1) throws BusinessException, Exception {
		logger.logDebug("GroupManager updateGroup");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.GROUP_REQUEST, groupRequest, ServiceId.UPDATE_GROUP, arg1);
	}

	public GroupResponse searchGroup(GroupRequest groupRequest, ICommonEventArgs arg1) throws BusinessException, Exception {
		logger.logDebug("GroupManager serviceIntegration " + getServiceIntegration());

		CallServices callService = new CallServices(getServiceIntegration());
		GroupResponse groupResponse = (GroupResponse) callService.callServiceWithReturn(RequestName.GROUP_REQUEST, groupRequest,
				ServiceId.SEARCH_GROUP, ReturnName.GROUP_RESPONSE, arg1);
		return groupResponse;
	}

}
