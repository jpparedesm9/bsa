package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.RelationContext;
import com.cobiscorp.cobis.cstmr.model.RelationPerson;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectRelationManager;

public class DeleteRelationByPerson extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteRelationByPerson.class);

	public DeleteRelationByPerson(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {

		try {
			RelationRequest relationPerson = new RelationRequest();
			DataEntity relationContext = row.getEntity(RelationContext.ENTITY_NAME);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RELATIONID " + row.get(RelationPerson.RELATIONID));
				LOGGER.logDebug("SECUENTIALPERSONLEFT" + row.get(RelationPerson.SECUENTIALPERSONLEFT));
			}
			LOGGER.logDebug("Izquierda -->" + row.get(RelationPerson.SECUENTIALPERSONLEFT));
			LOGGER.logDebug("Derecha -->" + row.get(RelationPerson.SECUENTIALPERSONRIGHT));
			relationPerson.setRelation(Integer.valueOf(row.get(RelationPerson.RELATIONID)));
			relationPerson.setLeft(Integer.valueOf(row.get(RelationPerson.SECUENTIALPERSONLEFT)));
			relationPerson.setRight(row.get(RelationPerson.SECUENTIALPERSONRIGHT));

			NaturalProspectRelationManager naturalProspectRelationManager = new NaturalProspectRelationManager(getServiceIntegration());
			naturalProspectRelationManager.deleteProspectRelation(relationPerson, args);
			args.setSuccess(true);
		} catch (BusinessException e) {
			LOGGER.logError("Error en createPhone", e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100"+e.getMessage());

		} catch (Exception e) {
			LOGGER.logError("Error en createPhone", e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100"+e.getMessage());

		}
	}

}
