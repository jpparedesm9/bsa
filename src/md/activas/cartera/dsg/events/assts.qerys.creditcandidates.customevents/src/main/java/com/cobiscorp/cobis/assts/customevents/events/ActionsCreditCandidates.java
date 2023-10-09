package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.services.CreditCandidatesManagement;
import com.cobiscorp.cobis.assts.model.CreditCandidates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ActionsCreditCandidates extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ActionsCreditCandidates.class);

	public ActionsCreditCandidates(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntityList lista = new DataEntityList();
		lista = entities.getEntityList(CreditCandidates.ENTITY_NAME);
		CreditCandidatesRequest candidatesRequest = new CreditCandidatesRequest();
		CreditCandidatesManagement candidatesManagement = new CreditCandidatesManagement(getServiceIntegration());
		String action = null;

		try {
			if (args.getParameters().getCustomParameters() != null) {
				LOGGER.logDebug("La accion a ejecutar: " + args.getParameters().getCustomParameters().get("action").toString());
				action = args.getParameters().getCustomParameters().get("action").toString();
			}
			for (DataEntity candidatesEntity : lista) {
				LOGGER.logDebug("Accion DataEntity: " + candidatesEntity.get(CreditCandidates.ISCHECKED));
				if (candidatesEntity.get(CreditCandidates.ISCHECKED) != null) {
					LOGGER.logDebug("Accion Ingresa");
					if (candidatesEntity.get(CreditCandidates.ISCHECKED)) {
						candidatesRequest.setDateInsertion(GeneralFunction.convertDateToCalendar(candidatesEntity.get(CreditCandidates.DATEINSERTION)));
						candidatesRequest.setGroupId(candidatesEntity.get(CreditCandidates.GROUPID));
						candidatesRequest.setClientId(candidatesEntity.get(CreditCandidates.CLIENTID));
						candidatesRequest.setAction(action);

						candidatesManagement.actionsCandidates(candidatesRequest, args);
					}
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError("Error al intentar aplicar acción", e, args, LOGGER);
		}
	}

}
