package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.InfoCredManagement;
import com.cobiscorp.cobis.busin.model.InfocredHeader;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandCM_OIIRL51TND41 extends BaseEvent implements IExecuteCommand {

	public ExecuteCommandCM_OIIRL51TND41(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		InfoCredManagement infocredManagement = new InfoCredManagement(super.getServiceIntegration());
		infocredManagement.validateReport(entities.getEntity(InfocredHeader.ENTITY_NAME), args, new BehaviorOption(true));
	}
}
