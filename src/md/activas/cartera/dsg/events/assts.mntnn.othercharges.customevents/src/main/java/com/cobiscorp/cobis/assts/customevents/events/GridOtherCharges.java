package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.OtherChargesEvents;
import com.cobiscorp.cobis.assts.model.OtherCharges;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GridOtherCharges extends BaseEvent implements IExecuteQuery,
		IInitDataEvent {

	public GridOtherCharges(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		OtherChargesEvents otherChargeEvents = new OtherChargesEvents(
				this.getServiceIntegration());
		entities.setEntityList(OtherCharges.ENTITY_NAME,
				otherChargeEvents.loadData(entities, eventArgs));

	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs eventArgs) {
		OtherChargesEvents otherChargeEvents = new OtherChargesEvents(
				this.getServiceIntegration());
		return otherChargeEvents.loadData(entities, eventArgs).getDataList();
	}

}
