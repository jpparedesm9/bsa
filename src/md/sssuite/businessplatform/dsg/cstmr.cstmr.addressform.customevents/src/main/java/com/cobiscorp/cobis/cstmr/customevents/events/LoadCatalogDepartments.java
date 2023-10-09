package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.AddressCatalogManager;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogDepartments extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogDepartments.class);

	public LoadCatalogDepartments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("LoadCatalogDepartments>>executeDataEvent");
		}
		AddressCatalogManager addressCatalogManager = new AddressCatalogManager(getServiceIntegration());
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		DataEntity physicalAddress = entities
				.getEntity(PhysicalAddress.ENTITY_NAME);
		String countryCode = physicalAddress.get(PhysicalAddress.COUNTRYCODE)
				.toString();
		try{
		for (CatalogDto catalogDto : addressCatalogManager
				.getDepartments(countryCode, args, new BehaviorOption(true))) {
			ItemDTO item = new ItemDTO();
			item.setCode(catalogDto.getCode().trim());
			item.setValue(catalogDto.getName());
			listItemDTO.add(item);

		}
		return listItemDTO;
		}
		catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_DEPARMENTS, e, args, LOGGER);
		}
		return listItemDTO;
	}
}
