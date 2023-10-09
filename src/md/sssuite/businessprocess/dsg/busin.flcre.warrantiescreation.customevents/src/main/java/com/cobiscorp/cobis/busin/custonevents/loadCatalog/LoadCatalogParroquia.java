package com.cobiscorp.cobis.busin.custonevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.ArrearsInfo;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.WarrantyLocation;
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

public class LoadCatalogParroquia extends BaseEvent implements ILoadCatalog{

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogParroquia.class);
	
	public LoadCatalogParroquia(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug(":>:>LoadCatalogParroquia:>:>executeDataEvent:>:>");
		}
		
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		
		Integer cityCode;
		List<ItemDTO> listItemDTO= new ArrayList<ItemDTO>();
		String taskId = args.getParameters().getTaskId();
		try{
			if(taskId.equals("T_FLCRE_28_RREAR10")){
				DataEntity arrearsInfo = entities.getEntity(ArrearsInfo.ENTITY_NAME);
				cityCode = arrearsInfo.get(ArrearsInfo.CITY);
			}else {
				if(taskId.equals("T_FLCRE_35_RRCAI67")){
					DataEntity warrantyLocation = entities.getEntity(WarrantyLocation.ENTITY_NAME);
					cityCode = warrantyLocation.get(WarrantyLocation.CITY);			
				}else { 
					DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
					cityCode = officerAnalysis.get(OfficerAnalysis.CITY);
				}
			}
			if ( cityCode != null) {//modificar segun servicio a sugerir -> sp_parroquia( @i_operacion = 'H',@t_trn != 1559, @i_tipo_h = "P", @i_modo = 0)					
				
				
				for (CatalogDto catalogDto : queryStoredProcedureManagement.getDataParish( cityCode.toString().trim(), args, new BehaviorOption(true))){
					ItemDTO item = new ItemDTO();
					item.setCode(catalogDto.getCode().trim());
					item.setValue(catalogDto.getName());
					listItemDTO.add(item);

				}
			}
			return listItemDTO;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_CATALOG_PARROQUIA, e, args, LOGGER);
		}

		return listItemDTO;
	}
	
}
