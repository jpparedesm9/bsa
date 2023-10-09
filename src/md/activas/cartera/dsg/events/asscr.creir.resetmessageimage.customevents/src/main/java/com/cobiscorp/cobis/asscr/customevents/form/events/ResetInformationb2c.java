package com.cobiscorp.cobis.asscr.customevents.form.events;

import com.cobiscorp.cobis.asscr.model.ResetImageMessage;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.services.ResetInformationManager;

import cobiscorp.ecobis.bussinescallcenter.dto.ResetInformationRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ResetInformationb2c extends BaseEvent implements IExecuteCommand {

	private static ILogger logger = LogFactory.getLogger(ResetInformationb2c.class);

	public ResetInformationb2c(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {

		logger.logDebug("---------- >>> Inicia executeCommand Reseteo de Imagen y Frase cliente de la B2C");
		
		ResetInformationRequest resetInformationRequest = new ResetInformationRequest();
		ResetInformationManager informationManager = new ResetInformationManager(getServiceIntegration());

		try {

			DataEntity resetInformationEntity = arg0.getEntity(ResetImageMessage.ENTITY_NAME);

			logger.logDebug("---------- >>> resetInformation: " + resetInformationEntity);
			logger.logDebug("---------- >>> Código cliente a restear: " + resetInformationEntity.get(ResetImageMessage.CODRESETCLIENT));			

			int codigoReseteoCliente = (Integer) resetInformationEntity.get(ResetImageMessage.CODRESETCLIENT);

			resetInformationRequest.setCodClienteReset(codigoReseteoCliente);

			logger.logDebug("---------- >>> codigo resetInformationRequest: " + resetInformationRequest.getCodClienteReset());
			
			informationManager.resetImageMessage(resetInformationRequest, arg1);

			

		} catch (Exception e) {
			logger.logError("Error al Resetear la imagen y mensaje de bienvenida ", e);
		}

		logger.logDebug("---------- >>> Termina executeCommand Reseteo de Imagen y Frase cliente de la B2C");

	}

}
