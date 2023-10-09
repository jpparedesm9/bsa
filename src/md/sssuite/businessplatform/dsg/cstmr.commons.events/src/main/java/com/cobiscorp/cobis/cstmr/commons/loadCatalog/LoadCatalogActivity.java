package com.cobiscorp.cobis.cstmr.commons.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.services.QueryCatalogStoredProcedureManagement;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;

public class LoadCatalogActivity extends BaseEvent implements ILoadCatalog{
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogActivity.class);

	public LoadCatalogActivity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logDebug("---->Entra al LoadCatalogActivity");
		
		DataEntity businessTmp = entities.getEntity(Business.ENTITY_NAME);
		LOGGER.logDebug("businessTmp Business---" + businessTmp);
		String economicActivity = businessTmp.get(Business.ECONOMICACTIVITY);
		
		LOGGER.logError("---->Declaracion de TransactionManagement");
		QueryCatalogStoredProcedureManagement queryStoredProcedureManagement = new QueryCatalogStoredProcedureManagement(getServiceIntegration());

		LOGGER.logDebug("---->Variables");
		
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		String filtro = null;
		String codigo = null;
		if(!args.getFilters().isEmpty()){
			filtro = ((String) args.getFilters().get(0)); //Obtengo el filtro
		} else if(economicActivity != null){
			codigo = economicActivity;
		}else {
			filtro = "";
		}
		
		LOGGER.logDebug("EL CODIGO DE ACTIVIDAD ES: " + economicActivity);
		
		LOGGER.logDebug("---->Ejecucion de servicio para recuperar las Actividades Economicas");
		try {

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getActivityFilter(filtro, codigo, args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			LOGGER.logError("Error al cargar las actividades Economicas", e);
		}

		return listItemDTO;
	}
}
