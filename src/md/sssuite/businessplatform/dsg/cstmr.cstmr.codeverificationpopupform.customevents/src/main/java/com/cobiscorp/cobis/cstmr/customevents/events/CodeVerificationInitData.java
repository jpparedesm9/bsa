package com.cobiscorp.cobis.cstmr.customevents.events;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CodeVerifManager;
import com.cobiscorp.cobis.cstmr.commons.parameters.CodeVerifUtil;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.CodeVerification;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class CodeVerificationInitData extends BaseEvent implements IInitDataEvent {
	
	private static final ILogger LOGGER = LogFactory.getLogger(CodeVerificationInitData.class);
	
	public CodeVerificationInitData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		DataEntity codeVerifEnt = entities.getEntity(CodeVerification.ENTITY_NAME);
		String phoneMail = codeVerifEnt.get(CodeVerification.PHONENUMBER);
		String validationType = codeVerifEnt.get(CodeVerification.VALTYPE);
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("CodeVerificationInitData - INI");
			LOGGER.logDebug("CodeVerificationInitData.sendCode -> codeVerifEnt=" + codeVerifEnt.getData());
			LOGGER.logDebug("CodeVerificationInitData.sendCode -> args.isSuccess=" + args.isSuccess());
		}
		try {
			args.setSuccess(true);
			if (Parameter.SMS_TYPE.equals(validationType) && !CodeVerifUtil.validatePhone(phoneMail)) {
				args.setSuccess(false);
				args.getMessageManager().showInfoMsg("CSTMR.LBL_CSTMR_NMEROCELI_28530", null, 6000);//celular incorrecto
			} else if (Parameter.MAIL_TYPE.equals(validationType) && !CodeVerifUtil.validateMail(phoneMail)) {
				args.setSuccess(false);
				args.getMessageManager().showInfoMsg("CSTMR.LBL_CSTMR_CORREOERC_52631", null, 6000);//mail incorrecto
			}

			if(args.isSuccess()) {
				CodeVerifManager aCodeVerifMng = new CodeVerifManager(getServiceIntegration());
				aCodeVerifMng.sendCode(codeVerifEnt, args);
				args.setSuccess(true);
			}
			
		} catch (Exception e) {
			args.setSuccess(false);
			ExceptionUtils.showError("Error al enviar Código de Verificación", e, args, LOGGER);
		}
		
		
	}

}
