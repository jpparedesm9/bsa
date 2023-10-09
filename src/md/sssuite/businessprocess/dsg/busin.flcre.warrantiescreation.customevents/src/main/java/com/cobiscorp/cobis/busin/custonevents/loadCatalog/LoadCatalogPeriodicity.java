package com.cobiscorp.cobis.busin.custonevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
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

public class LoadCatalogPeriodicity extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(QueryStoredProcedureManagement.class);

	public LoadCatalogPeriodicity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeDataEvent in LoadCatalogPeriodicity");
		}
		List<ItemDTO> items = new ArrayList<ItemDTO>();
		try {
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			List<CatalogDto> periodicityList = queryStoredProcedureManagement.getPaymentFrequency(arg1, new BehaviorOption(true));

			for (CatalogDto catalog : periodicityList) {
				LOGGER.logDebug("SRO Item: "+catalog.getCode()+"-"+catalog.getDescription3()+"-"+catalog.getDescription4()+"-"+catalog.getDescription5());
				ItemDTO item = new ItemDTO();
				item.setCode(catalog.getCode());
				item.setValue(catalog.getName());
				items.add(item);
			}
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_CATALOG_PERIODICITY, ex, arg1, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish executeDataEvent in LoadCatalogPeriodicity");
			}
		}
		return items;

	}

}
