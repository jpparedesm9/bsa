package com.cobiscorp.cobis.cstmr.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CodeVerifManager;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.CodeVerification;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SendingCodeExecCommand extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SendingCodeExecCommand.class);
	
	public SendingCodeExecCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			LOGGER.logDebug("****Inicia SendingCodeExecCommand*****");
			DataEntity codeVerifEnt = entities.getEntity(CodeVerification.ENTITY_NAME);
			String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
			
			LOGGER.logDebug("**** validationType:" + validationType);
			
			CodeVerifManager aCodeVerifMng = new CodeVerifManager(getServiceIntegration());
			aCodeVerifMng.sendCode(codeVerifEnt, args);

			
			args.setSuccess(true);
			//args.getMessageManager().showSuccessMsg("Codigo correcto");

			LOGGER.logDebug("****Finaliza SendingCodeExecCommand*****");
		} catch (Exception e) {
			args.setSuccess(false);
			ExceptionUtils.showError("Error al Validar/Reenviar Código de Verificación", e, args, LOGGER);
		}

	}

}
