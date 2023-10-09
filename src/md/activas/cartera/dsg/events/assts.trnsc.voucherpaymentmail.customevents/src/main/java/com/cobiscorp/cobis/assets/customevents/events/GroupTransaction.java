package com.cobiscorp.cobis.assets.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.GroupTransactResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Group;
import com.cobiscorp.cobis.assts.model.ProcessInstance;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GroupTransaction extends BaseEvent implements
		com.cobiscorp.designer.api.customization.IExecuteCommand {

	private static final ILogger logger = LogFactory
			.getLogger(GroupTransaction.class);

	public GroupTransaction(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeCommand GroupTransaction");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		Integer groupId;

		DataEntity group = entities.getEntity(Group.ENTITY_NAME);
		DataEntity processInstance = entities.getEntity(ProcessInstance.ENTITY_NAME);
		

		GroupPaymentRequest groupPaymentRequest = new GroupPaymentRequest();
		GroupTransactResponse[] groupTransactResponse = null;

		groupId = group.get(Group.GROUPID);

		groupPaymentRequest.setGroup(groupId);

		if (logger.isDebugEnabled()) {
			logger.logDebug("group.get(Group.GROUPID) --> "
					+ group.get(Group.GROUPID));
		}

		request.addValue("inGroupPaymentRequest", groupPaymentRequest);
		response = this.execute(getServiceIntegration(), logger,
				Parameter.PROCESS_READ_GROUP_TRAN, request);

		GeneralFunction.handleResponse(args, response, null);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			groupTransactResponse = (GroupTransactResponse[]) resultado
					.getValue("returnGroupTransactResponse");

			group.set(Group.LOANBALANCE,
					groupTransactResponse[0].getLoanBalance());
			
			group.set(Group.COLLATERALBALANCE,
					groupTransactResponse[0].getCollateralBalance());
			 
			group.set(Group.LOANBALCURRENCYNEM, groupTransactResponse[0].getCurrencyDesc());
			group.set(Group.COLBALCURRENCYNEM, groupTransactResponse[0].getCurrencyDesc());
			
			group.set(Group.GROUPSTATUS, groupTransactResponse[0].getStage());
			group.set(Group.COLLATERALPAYMENTSTATUS, groupTransactResponse[0].getCollateralPaymentStatus());
			
			processInstance.set(ProcessInstance.INSTANCEID, groupTransactResponse[0].getProcessId());
			processInstance.set(ProcessInstance.ACTIVITYID, groupTransactResponse[0].getActivityId());
			processInstance.set(ProcessInstance.TRANSACTIONNUMBER, groupTransactResponse[0].getTransactionNumber());
			

		}

	}

}
