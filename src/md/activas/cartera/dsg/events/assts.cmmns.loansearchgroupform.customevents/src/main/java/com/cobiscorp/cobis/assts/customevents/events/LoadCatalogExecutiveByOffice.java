package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.LoanSearchFilter;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;

public class LoadCatalogExecutiveByOffice extends BaseEvent implements ILoadCatalog{
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogExecutiveByOffice.class);

	public LoadCatalogExecutiveByOffice(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logDebug("---->Entra al LoadCatalogExecutive");
		
		DataEntity mobileTmp = entities.getEntity(LoanSearchFilter.ENTITY_NAME);
		LOGGER.logDebug("businessTmp Business---" + mobileTmp);
		String oficial = String.valueOf(mobileTmp.get(LoanSearchFilter.OFFICE));
		
		LOGGER.logError("---->Declaracion de TransactionManagement");
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

		LOGGER.logDebug("---->Variables");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		String filtro = null;
		String codigo = null;
		LOGGER.logDebug("---->Ejecucion de servicio para recuperar los Ejecutivos");
		if(!args.getFilters().isEmpty()){
			filtro = ((String) args.getFilters().get(0)); //Obtengo el filtro
		} else if(oficial != null){
			codigo = oficial;
		}else {
			filtro = "";
		}
		LOGGER.logDebug("---->codigo1234"+codigo);
		try {
			/*for (CatalogDto catalogDto : queryStoredProcedureManagement.getExecutiveFilter(filtro, codigo, args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}*/

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getExecutiveByOffice(codigo, args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			LOGGER.logError("Error al cargar LoadCatalogExecutive", e);
		}

		return listItemDTO;
	}
}
