package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.CategoryReadjustment;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataCategory extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(InitDataCategory.class);

	public InitDataCategory(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso InitDataCategory");
		try {
			LOGGER.logDebug("Ingreso InitDataCategory");
			DataEntity item = entities.getEntity(Category.ENTITY_NAME);

			DataEntity itemReadjustment = entities
					.getEntity(CategoryReadjustment.ENTITY_NAME);
			
					
			entities.setEntity(Category.ENTITY_NAME, ItemsManagement
					.readItemsDetail(entities, arg1, null,
							super.getServiceIntegration(), item,
							itemReadjustment));

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.SEARCH_ITEM, e, arg1, LOGGER);
		}
	}

}
