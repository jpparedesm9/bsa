package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.services.CreditCandidatesManagement;
import com.cobiscorp.cobis.assts.model.CreditCandidates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UpdateCreditCandidates extends BaseEvent implements IGridRowUpdating {
	private static final ILogger LOGGER = LogFactory.getLogger(UpdateCreditCandidates.class);

	public UpdateCreditCandidates(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try {
			CreditCandidatesRequest candidatesRequest = new CreditCandidatesRequest();

			candidatesRequest.setDateInsertion(GeneralFunction.convertDateToCalendar(row.get(CreditCandidates.DATEINSERTION)));
			candidatesRequest.setGroupId(row.get(CreditCandidates.GROUPID));
			candidatesRequest.setClientId(row.get(CreditCandidates.CLIENTID));

			if ((row.get(CreditCandidates.PERIODICITY) != null) && (row.get(CreditCandidates.PERIODICITY) != ""))
				candidatesRequest.setPeriodicity(row.get(CreditCandidates.PERIODICITY));
			if ((row.get(CreditCandidates.OFFICERREASSIGNEDID) != null) && (row.get(CreditCandidates.OFFICERREASSIGNEDID) != 0))
				candidatesRequest.setOfficerReassignedId(row.get(CreditCandidates.OFFICERREASSIGNEDID));

			CreditCandidatesManagement candidatesManagement = new CreditCandidatesManagement(getServiceIntegration());
			candidatesManagement.updateCandidates(candidatesRequest, args);

		} catch (Exception e) {
			ExceptionUtils.showError("Error al actualizar", e, args, LOGGER);
		}
	}

}
