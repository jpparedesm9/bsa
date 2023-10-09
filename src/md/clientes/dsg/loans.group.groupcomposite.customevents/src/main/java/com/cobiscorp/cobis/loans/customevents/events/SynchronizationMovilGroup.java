package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.Credit;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SynchronizationMovilGroup extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SynchronizationMovilGroup.class);

	public SynchronizationMovilGroup(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		try {
			DataEntity credito = entities.getEntity(Credit.ENTITY_NAME);
			SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
			SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());

			synchronizationRequest.setApplicationNumber(credito.get(Credit.CREDITCODE)); // nro de tramite
			synchronizationRequest.setNameActivity(credito.get(Credit.NAMEACTIVITY)); // etapa del flujo
			LOGGER.logDebug("Boton sincroniza tramite>>> " + credito.get(Credit.CREDITCODE));
			LOGGER.logDebug("Boton sincroniza etapa>>> " + credito.get(Credit.NAMEACTIVITY));
			// Se comenta porque se requiere que siempre se sincronize cuando regresa a la etapa de ingreso
			// SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, arg1,
			// new BehaviorOption(true));
			// if(synchronizationResponse != null && synchronizationResponse.getSynchronization() == null){
			synchronizationRequest.setProcessNumber(credito.get(Credit.APPLICATIONNUMBER)); // instancia de proceso
			if (credito.get(Credit.PRODUCTTYPE).equals("GRUPAL")) {
				LOGGER.logDebug("Boton sincroniza grupal>>> ");
				synchronizationManagement.xMLIngresoGrupal(synchronizationRequest, arg1, new BehaviorOption(true));
				synchronizationRequest.setSynchronization("S");
			} else if (credito.get(Credit.PRODUCTTYPE).equals("INDIVIDUAL")) {
				LOGGER.logDebug("Boton sincroniza individual>>> ");
				synchronizationManagement.xMLIngresoIndividual(synchronizationRequest, arg1, new BehaviorOption(true));
				synchronizationRequest.setSynchronization("S");
			}
			if (synchronizationManagement.updateSynchronizationActivity(synchronizationRequest, arg1, new BehaviorOption(true))) {
				// context.set(Context.ENABLE, "N"); //para bloquear la pantalla
				arg1.setSuccess(true);
			} else {
				arg1.setSuccess(false);
			}
			// }

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SYNCRONIZATION_MOVIL_GROUP, e, arg1, LOGGER);
		}

	}

}
