package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandCM_OIIRL51INT80 extends BaseEvent implements IExecuteCommand {

	public ExecuteCommandCM_OIIRL51INT80(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

	}

}
