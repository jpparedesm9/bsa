package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SourceFundingResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.SourceFundingManagement;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogSourceFunding extends BaseEvent implements ILoadCatalog{

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogSourceFunding.class);
	
	public LoadCatalogSourceFunding(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		
	}

	@Override
	public List<ItemDTO> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand method in LoadCatalogSourceFunding class");
		}
		Integer numeroTramite = 0;
		
		// DECLARAR VARIABLES
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		numeroTramite = paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED);
		BigDecimal tasa=paymentPlanHeader.get(PaymentPlanHeader.RATE);
		
		LOGGER.logInfo("1................tasa tramite................"+tasa);
		LOGGER.logInfo("1................numeroTramite tramite................"+numeroTramite);
		List<ItemDTO> items = new ArrayList<ItemDTO>();
		
		ItemDTO item1 = new ItemDTO();
		item1.setCode("0");
		item1.setValue("Seleccione");
		items.add(item1);

		try {
				SourceFundingManagement sourceFundingManagement=new SourceFundingManagement(super.getServiceIntegration());
				SourceFundingResponse[] sourceFundingResponse=sourceFundingManagement.getSourceFunding(numeroTramite, tasa.intValue(), args, new BehaviorOption(true));
				LOGGER.logInfo("1................sourceFundingResponse................"+sourceFundingResponse);
				for (SourceFundingResponse sourceFunList : sourceFundingResponse) {
					ItemDTO item = new ItemDTO();
					item.setCode(String.valueOf(sourceFunList.getFuenteFinanciamiento() ));
					item.setValue(sourceFunList.getDescripicion());
					items.add(item);
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_SOURCE, e, args, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish executeCommand method in LoadCatalogSourceFunding class");

			}
		}
					
		return items;
	}
	
}
