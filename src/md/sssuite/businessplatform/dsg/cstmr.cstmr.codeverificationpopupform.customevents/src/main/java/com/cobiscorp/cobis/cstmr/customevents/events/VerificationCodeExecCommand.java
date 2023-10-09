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
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class VerificationCodeExecCommand extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(VerificationCodeExecCommand.class);
	
	public VerificationCodeExecCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("****Inicia VerificationCodeExecCommand*****");
		DataEntity codeVerifEnt = entities.getEntity(CodeVerification.ENTITY_NAME);
		String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
		
		LOGGER.logDebug("**** validationType:" + validationType);
		try {
			if (Parameter.MAIL_TYPE.equals(validationType) || Parameter.SMS_TYPE.equals(validationType)) {
				CodeVerifManager aCodeVerifMng = new CodeVerifManager(getServiceIntegration());
				aCodeVerifMng.validateCode(codeVerifEnt, args);
			}
			if(args.isSuccess()) {
				args.setSuccess(true);
				args.getMessageManager().showSuccessMsg("CSTMR.MSG_CSTMR_ELCDIGOIL_98990", null, 6000);
			} else {
				args.setSuccess(false);
				args.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_ELCDIGOIN_42509", null, 6000);

				
			}
			

			LOGGER.logDebug("****Finaliza VerificationCodeExecCommand*****");
		} catch (Exception e) {
			args.setSuccess(false);
			ExceptionUtils.showError("Error al Validar Código de Verificación", e, args, LOGGER);
		}

	}

}
