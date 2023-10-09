package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogStoreProcedureManagement;
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

public class LoadCatalogTerm extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogTerm.class);

	public LoadCatalogTerm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(":>:>LoadCatalogTerm:>:>executeDataEvent:>:>");
		}

		LOGGER.logDebug(":>:AAAAA>>>>>>>>args.getFilters:" + args.getFilters());

		List<ItemDTO> listItemDTO1 = new ArrayList<ItemDTO>();		

		LOGGER.logDebug("---->Variables");

		String filtro = null;
		String codigo = null;
		LOGGER.logDebug("---->Ejecucion de servicio para recuperar los Ejecutivos");
		
		if(!args.getFilters().isEmpty()){
			filtro = ((String) args.getFilters().get(0)); //Obtengo el filtro
		}else {
			filtro = "";
		}
		
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
			CatalogStoreProcedureManagement cspm = new CatalogStoreProcedureManagement(getServiceIntegration());

			//List<CatalogDto> getTerm = cspm.getTerm(args, new BehaviorOption(true), filtro);
			List<CatalogDto> getTerm = cspm.getTerm(filtro, args, new BehaviorOption(true));

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
