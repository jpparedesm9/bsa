package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.RelationPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowInserting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectRelationManager;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Constants;

public class CreateCustomRelation extends BaseEvent implements IGridRowInserting {

	private static final ILogger LOGGER = LogFactory.getLogger(CreateCustomRelation.class);

	public CreateCustomRelation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try {
			args.setSuccess(true);
			LOGGER.logDebug("start Create Customer Relation");
			RelationRequest relationRequest = new RelationRequest();
			LOGGER.logDebug("RELATIONID>>>> " + row.get(RelationPerson.RELATIONID));
			Integer relation = 0;
 
			if (row.get(RelationPerson.RELATIONID) == null) {
				args.getMessageManager().showErrorMsg("Escoja la relación entre clientes.");
			} else {
				relation = Integer.valueOf(row.get(RelationPerson.RELATIONID));
				relationRequest.setRelation(relation);
				relationRequest.setLeft(row.get(RelationPerson.SECUENTIALPERSONLEFT));
				relationRequest.setRight(row.get(RelationPerson.SECUENTIALPERSONRIGHT));
				relationRequest.setSide(Constants.RELATIONSIDE);
				NaturalProspectRelationManager naturalProspectRelationManager = new NaturalProspectRelationManager(getServiceIntegration());
				naturalProspectRelationManager.createProspectRelation(relationRequest, args);

			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_RELATION, e, args, LOGGER);
		}
	}

}
