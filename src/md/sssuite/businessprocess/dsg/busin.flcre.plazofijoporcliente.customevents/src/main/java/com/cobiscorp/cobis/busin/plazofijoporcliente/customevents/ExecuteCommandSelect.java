package com.cobiscorp.cobis.busin.plazofijoporcliente.customevents;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandSelect extends BaseEvent implements IExecuteCommand {	

	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandSelect.class);

	public ExecuteCommandSelect(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>ExecuteCommandSelect Inicio:>:>");
			}
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList documentsApplicationEntityList = new DataEntityList();		
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>ExecuteCommandSelect Fin:>:>");
			}

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PLAZO_EXECUTE_SELECT, ex, arg1, LOGGER);
		}

	}

}