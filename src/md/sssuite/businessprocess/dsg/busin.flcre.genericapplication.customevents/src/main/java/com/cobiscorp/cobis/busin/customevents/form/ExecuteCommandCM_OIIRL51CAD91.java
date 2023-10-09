package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.InfoCredManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.InfocredHeader;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandCM_OIIRL51CAD91 extends BaseEvent implements IExecuteCommand {

	public ExecuteCommandCM_OIIRL51CAD91(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
		
		SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
		synchronizationRequest.setProcessNumber(context.get(Context.REQUESTID)); // nro de tramite
        synchronizationRequest.setNameActivity(context.get(Context.TASKSUBJECT)); //etapa del flujo
        SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true));
        if(synchronizationResponse.getSynchronization()== null){
          synchronizationManagement.createSynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true));
        }
	}
}
