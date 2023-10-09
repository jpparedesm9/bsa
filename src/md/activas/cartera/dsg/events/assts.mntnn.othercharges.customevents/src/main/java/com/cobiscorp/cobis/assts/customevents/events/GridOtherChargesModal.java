package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.OtherChargesEvents;
import com.cobiscorp.cobis.assts.model.OtherCharges;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GridOtherChargesModal extends BaseEvent implements
		IOnCloseModalEvent {

	public GridOtherChargesModal(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entities,
			ICloseModalEventArgs eventArgs) {
		OtherChargesEvents otherChargeEvents = new OtherChargesEvents(
				this.getServiceIntegration());
		entities.setEntityList(OtherCharges.ENTITY_NAME,
				otherChargeEvents.loadData(entities, eventArgs));

	}

}
