package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.services.CreditCandidatesManagement;
import com.cobiscorp.cobis.assts.model.CreditCandidates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UpdateCreditCandidates extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateCreditCandidates.class);

	public UpdateCreditCandidates(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntity entity = entities.getEntity(CreditCandidates.ENTITY_NAME);
		CreditCandidatesRequest candidatesRequest = new CreditCandidatesRequest();
		CreditCandidatesManagement candidatesManagement = new CreditCandidatesManagement(getServiceIntegration());

		try {
			
			candidatesRequest.setDateInsertion(GeneralFunction.convertDateToCalendar(entity.get(CreditCandidates.DATEINSERTION)));
			candidatesRequest.setGroupId(entity.get(CreditCandidates.GROUPID));
			candidatesRequest.setClientId(entity.get(CreditCandidates.CLIENTID));
			
			if ((entity.get(CreditCandidates.PERIODICITY) != null) && (entity.get(CreditCandidates.PERIODICITY) != ""))
				candidatesRequest.setPeriodicity(entity.get(CreditCandidates.PERIODICITY));
			if ((entity.get(CreditCandidates.OFFICERREASSIGNEDID) != null) && (entity.get(CreditCandidates.OFFICERREASSIGNEDID) != 0))
				candidatesRequest.setOfficerReassignedId(entity.get(CreditCandidates.OFFICERREASSIGNEDID));
			if ((entity.get(CreditCandidates.DESCRIPTION) != null) && (entity.get(CreditCandidates.DESCRIPTION) != ""))
				candidatesRequest.setDescription(entity.get(CreditCandidates.DESCRIPTION));
			
			candidatesManagement.updateCandidates(candidatesRequest, args);

		} catch (Exception e) {
			ExceptionUtils.showError("Error al actualizar", e, args, LOGGER);
		}
	}

}
