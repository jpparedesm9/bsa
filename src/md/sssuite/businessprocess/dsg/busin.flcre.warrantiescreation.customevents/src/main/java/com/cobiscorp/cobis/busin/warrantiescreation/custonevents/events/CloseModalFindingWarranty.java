package com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.utils.MapWarranty;
import com.cobiscorp.cobis.busin.custonevents.loadCatalog.LoadCatalogStoreKeeper;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class CloseModalFindingWarranty extends BaseEvent implements IOnCloseModalEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogStoreKeeper.class);

	public CloseModalFindingWarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entities, ICloseModalEventArgs arg1) {
		try{
			DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
			if (warrantyGeneral.get(WarrantyGeneral.EXTERNALCODE) != null && warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE) != null
					&& warrantyGeneral.get(WarrantyGeneral.OFFICE) != null) {
				MapWarranty mapWaranty = new MapWarranty();
				mapWaranty.getWarranty(entities, arg1, getServiceIntegration(), warrantyGeneral.get(WarrantyGeneral.EXTERNALCODE), warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE),
						warrantyGeneral.get(WarrantyGeneral.OFFICE));
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_MODAL_FINDING, e, arg1, LOGGER);
		}
	}

}
