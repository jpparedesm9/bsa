package com.cobiscorp.cobis.cstmr.commons.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.services.QueryCatalogStoredProcedureManagement;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;

public class LoadCatalogExecutiveCustomer extends BaseEvent implements ILoadCatalog{
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogExecutiveCustomer.class);

	public LoadCatalogExecutiveCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logDebug("---->Entra al LoadCatalogExecutive");
		
		DataEntity mobileTmp = entities.getEntity(NaturalPerson.ENTITY_NAME);
		LOGGER.logDebug("businessTmp Business---" + mobileTmp);
		String oficial = null;
		if (mobileTmp != null){
			oficial = String.valueOf(mobileTmp.get(NaturalPerson.OFFICERCODE));
		}
		 
		
		LOGGER.logError("---->Declaracion de TransactionManagement");
		QueryCatalogStoredProcedureManagement queryStoredProcedureManagement = new QueryCatalogStoredProcedureManagement(getServiceIntegration());

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
		
		try {

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getExecutiveFilter(filtro, codigo, args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			LOGGER.logError("Error al cargar los Oficiales", e);
		}

		return listItemDTO;
	}
}
