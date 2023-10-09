package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoadCatalogExecutive extends BaseEvent implements ILoadCatalog{
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogProvince.class);

	public LoadCatalogExecutive(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logDebug("---->Entra al LoadCatalogExecutive");

		LOGGER.logError("---->Declaracion de TransactionManagement");
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

		LOGGER.logDebug("---->Variables");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		LOGGER.logDebug("---->Ejecucion de servicio para recuperar los Ejecutivos");

		try {

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getExecutive(args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_EXECUTIVE, e, args, LOGGER);
		}

		return listItemDTO;
	}
}
