package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogStoreProcedureManagement;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
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

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoadCatalogTermMedicalAssistance extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogTermMedicalAssistance.class);

	public LoadCatalogTermMedicalAssistance(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(":>:>LoadCatalogTermMedicalAssistance:>:>executeDataEvent:>:>");
		}

		LOGGER.logDebug(":>:AAAAA>>>>>>>>args.getFilters:" + args.getFilters());

		List<ItemDTO> listItemDTO1 = new ArrayList<ItemDTO>();

		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);
		String producto = entidadInfo.get(EntidadInfo.TIPOPRODUCTO);
		LOGGER.logDebug("---->Producto: " + producto);
		
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		String idRequested = originalHeader.get(OriginalHeader.IDREQUESTED);
		LOGGER.logDebug("---->ID Requested: " + idRequested);
		
		String filtro = null;
		if (!args.getFilters().isEmpty()) {
			filtro = ((String) args.getFilters().get(0));
		} else {
			filtro = "";
		}
		LOGGER.logDebug("---->Filtro: " + filtro);

		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
			CatalogStoreProcedureManagement cspm = new CatalogStoreProcedureManagement(getServiceIntegration());

			List<CatalogDto> getTerm = cspm.getCatalogQuery(Mnemonic.OPERACION_Q, Mnemonic.CERO, Mnemonic.TIPO_P, filtro, producto, idRequested, args, new BehaviorOption(true));

			for (CatalogDto catalogDto : getTerm) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName().trim());
				listItemDTO.add(item);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_TERM, e, args, LOGGER);
		}

		return listItemDTO;
	}

}
