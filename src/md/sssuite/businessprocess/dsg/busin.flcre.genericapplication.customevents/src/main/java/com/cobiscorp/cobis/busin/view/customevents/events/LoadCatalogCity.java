package com.cobiscorp.cobis.busin.view.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.CityRequest;
import cobiscorp.ecobis.systemconfiguration.dto.CityResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CityResponseList;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.ArrearsInfo;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.WarrantyLocation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogCity extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogCity.class);

	public LoadCatalogCity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("---->Entra al LoadCatalogCity");
			LOGGER.logError("---->Declaracion de TransactionManagement");
		}
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("---->Recupera entidades");
		}
		
		Integer provinceId;
		String taskId = args.getParameters().getTaskId();
		
		if(taskId.equals("T_FLCRE_35_RRCAI67")){	
			DataEntity warrantyLocation = entities.getEntity(WarrantyLocation.ENTITY_NAME);
			provinceId = warrantyLocation.get(WarrantyLocation.PROVINCE) == null ? 0 : warrantyLocation.get(WarrantyLocation.PROVINCE);
		}else { 
			DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
			provinceId = officerAnalysis.get(OfficerAnalysis.PROVINCE) == null ? 0 : officerAnalysis.get(OfficerAnalysis.PROVINCE);
		}
		
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("---->Variables provinceId: "+ provinceId);
			LOGGER.logDebug("---->Ejecucion de servicio para recuperar datos de LoadCatalogCity");
		}
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		
		try {

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getCity(String.valueOf(provinceId), args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_CITY, e, args, LOGGER);
		}

		return listItemDTO;
	}
}
