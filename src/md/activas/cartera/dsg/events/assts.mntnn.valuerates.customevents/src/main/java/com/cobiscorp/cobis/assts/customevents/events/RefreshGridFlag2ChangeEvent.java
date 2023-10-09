package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.ServerParameter;
import com.cobiscorp.cobis.assts.model.TypeRates;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RefreshGridFlag2ChangeEvent extends BaseEvent implements IChangedEvent {

	public RefreshGridFlag2ChangeEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs eventArgs) {
		
		DataEntity selectedTypeRate = entities.getEntity(ServerParameter.ENTITY_NAME);
		DataEntityList typeRateList = entities.getEntityList(TypeRates.ENTITY_NAME);
		
		int row = selectedTypeRate.get(ServerParameter.SELECTEDROW);
		DataEntity typeRate = typeRateList.get(row);
		String selectedRateID = typeRate.get(TypeRates.IDENTIFIER);
		char selectedClase = typeRate.get(TypeRates.CLASE);
		
		RateValuesList rateValuesList = new RateValuesList(getServiceIntegration());
		rateValuesList.loadRateValuesList(entities, selectedRateID, selectedClase);
		
	}

}
