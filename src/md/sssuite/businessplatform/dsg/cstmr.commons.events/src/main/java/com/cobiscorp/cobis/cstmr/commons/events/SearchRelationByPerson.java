package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationPersonResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.RelationContext;
import com.cobiscorp.cobis.cstmr.model.RelationPerson;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectRelationManager;

public class SearchRelationByPerson extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory.getLogger(LoadRelationCatalog.class);

	public SearchRelationByPerson(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		logger.logDebug("Ingreso executeCommand");
		try {
			DataEntity relationContext = entities.getEntity(RelationContext.ENTITY_NAME);

			RelationRequest relationRequest = new RelationRequest();
			relationRequest.setMode(0);
			relationRequest.setLeft(relationContext.get(RelationContext.SECUENTIAL));

			NaturalProspectRelationManager naturalProspectRelationManager = new NaturalProspectRelationManager(getServiceIntegration());
			RelationPersonResponse relationPersonsResponse[];
			logger.logDebug("Ejecución");
			relationPersonsResponse = naturalProspectRelationManager.searchRelationByPerson(relationRequest, args);

			DataEntityList relationCustomerListEntity = new DataEntityList();
			for (RelationPersonResponse relationPersons : relationPersonsResponse) {
				DataEntity relationEntity = new DataEntity();
				relationEntity.set(RelationPerson.RELATIONID, String.valueOf(relationPersons.getRelation()));
				relationEntity.set(RelationPerson.NAMEPERSONLEFT, "");
				relationEntity.set(RelationPerson.NAMEPERSONRIGHT, relationPersons.getNameRight());
				relationEntity.set(RelationPerson.SECUENTIALPERSONRIGHT, relationPersons.getRight());
				relationEntity.set(RelationPerson.SECUENTIALPERSONLEFT, relationContext.get(RelationContext.SECUENTIAL));
				relationCustomerListEntity.add(relationEntity);

			}
			entities.setEntityList(RelationPerson.ENTITY_NAME, relationCustomerListEntity);
			args.setSuccess(true);	
		} catch (BusinessException e) {
			args.setSuccess(false);
			logger.logError("Error en SearchRelationByPerson"+e);

			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100"+e.getMessage());
		} catch (Exception e) {
			args.setSuccess(false);
			logger.logError("Error en SearchRelationByPerson"+e);
		
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100"+e.getMessage());
		}

	}

}
