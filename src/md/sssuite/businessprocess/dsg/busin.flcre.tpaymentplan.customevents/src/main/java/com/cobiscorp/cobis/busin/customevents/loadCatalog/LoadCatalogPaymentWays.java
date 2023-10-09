package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
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

public class LoadCatalogPaymentWays extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogPaymentWays.class);

	public LoadCatalogPaymentWays(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("start:>:>LoadCatalogPaymentWays:>:>executeDataEvent:>:>");
		}
		
                String producto;
                Integer moneda; 
                
                        DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
                        producto = paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE);
                moneda =   paymentPlanHeader.get(PaymentPlanHeader.CURRENCY);        
              
   
                
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		try {
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

                        List<CatalogDto> paymentWays = queryStoredProcedureManagement.getPaymentWaysGroup(producto,moneda,args, new BehaviorOption(true));
			for (CatalogDto catalogDto : paymentWays) {

				LOGGER.logDebug("catalogDto.getCode()" + catalogDto.getCode());
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);

			}
             
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_WAYS, ex, args, LOGGER);
		} finally {
			LOGGER.logDebug("finish:>:>LoadCatalogPaymentWays:>:>executeDataEvent:>:>");
		}
		return listItemDTO;
	}
}
