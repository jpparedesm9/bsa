package com.cobiscorp.cobis.busin.view.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.VariableData;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeTypeOperation extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeTypeOperation.class);

	public ChangeTypeOperation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso - changed - applicationanalysis.ChangeTypeOperation");

			DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			int codigoTramite = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));
			String operationType = officerAnalysis.get(OfficerAnalysis.PRODUCTTYPE);

			if (operationType != null) {
				OperationManagement operationMngt = new OperationManagement(super.getServiceIntegration());
				DataEntityList variableDataEntity = operationMngt.searchTypeOperationAndValueMapping(operationType, "CEX", codigoTramite, entities, args, new BehaviorOption(false, false));
				if (variableDataEntity != null)
					entities.setEntityList(VariableData.ENTITY_NAME, variableDataEntity);
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida - changed - applicationanalysis.ChangeTypeOperation");
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_SYNC, e, args, LOGGER);
		}
		
	}

}
