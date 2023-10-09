package com.cobiscorp.cobis.assets.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ProcessInstance;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SendCollateralMail extends BaseEvent implements
com.cobiscorp.designer.api.customization.IExecuteCommand  {

	
	public SendCollateralMail(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	private static final ILogger logger = LogFactory
			.getLogger(SendCollateralMail.class);
	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeCommand SendCollateralMail");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		Integer company = null;

		DataEntity processInstance = entities.getEntity(com.cobiscorp.cobis.assts.model.ProcessInstance.ENTITY_NAME);
		
		ProcessInstance processInstanceRequest = new ProcessInstance();
		processInstanceRequest.setInstanceCode(processInstance.get(com.cobiscorp.cobis.assts.model.ProcessInstance.INSTANCEID));
		processInstanceRequest.setActivityCode(processInstance.get(com.cobiscorp.cobis.assts.model.ProcessInstance.ACTIVITYID));
		if (processInstance.get(com.cobiscorp.cobis.assts.model.ProcessInstance.COMPANY)==null){
			company = 1;
		}else{
			company = processInstance.get(com.cobiscorp.cobis.assts.model.ProcessInstance.COMPANY);
		}
		processInstanceRequest.setCompany(company);

		request.addValue("inProcessInstance", processInstanceRequest);
		response = this.execute(getServiceIntegration(), logger,
				Parameter.PROCESS_SEND_COLLATERAL_MAIL, request);

		GeneralFunction.handleResponse(args, response, null);

	}

}
