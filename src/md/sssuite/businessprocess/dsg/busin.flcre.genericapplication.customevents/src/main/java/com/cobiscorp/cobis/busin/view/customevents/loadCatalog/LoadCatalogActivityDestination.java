package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogActivityDestination extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogActivityDestination.class);

	public LoadCatalogActivityDestination(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		LOGGER.logDebug("---->Entra al LoadCatalogActivityDestination");

		LOGGER.logError("---->Declaracion de TransactionManagement");
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

		LOGGER.logDebug("---->Recupera entidades");
		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);

		LOGGER.logDebug("---->Variables");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		if (entidadInfo != null) {

			String segment = entidadInfo.get(EntidadInfo.SECTOR) == null ? "" : entidadInfo.get(EntidadInfo.SECTOR);
			String destination = entidadInfo.get(EntidadInfo.DESTINOFINANCIERO) == null ? "" : entidadInfo.get(EntidadInfo.DESTINOFINANCIERO);

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar lo segmentos");

			try {

				for (CatalogDto catalogDto : queryStoredProcedureManagement.getActivityDestinationBySegmentAndDestination(segment, destination, args,
						new BehaviorOption(true))) {
					ItemDTO item = new ItemDTO();
					item.setCode(catalogDto.getCode().trim());
					item.setValue(catalogDto.getName());
					listItemDTO.add(item);
				}

				return listItemDTO;

			} catch (Exception e) {
				ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_ACTIVITY, e, args, LOGGER);
				LOGGER.logError("Error al cargar LoadCatalogActivityDestination", e);
			}

		}

		return listItemDTO;
	}


}
