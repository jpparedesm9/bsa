package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.InsuranceManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loansbusiness.dto.InsuranceResponse;

public class LoadCatalogInsurance extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogInsurance.class);
	private static final String INDIVIDUAL = "INDIVIDUAL";

	public LoadCatalogInsurance(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logError("---->Inicia executeDataEvent en LoadCatalogInsurance");
		
		InsuranceManager insuranceManager = new InsuranceManager(getServiceIntegration());
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
			for (InsuranceResponse amount : insuranceManager.queryInsurance(getServiceIntegration(), args, INDIVIDUAL)) {
				ItemDTO item = new ItemDTO();  
				item.setCode(amount.getSePaquete());
				item.setValue(amount.getSeDescripcion());
				listItemDTO.add(item);
			}			
			return listItemDTO;

		} catch (Exception e) {
			LOGGER.logError("Error en la carga del catalogo de Paquete de Seguros: ", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de executeDataEvent en LoadCatalogInsurance");
			}

		}
		return listItemDTO;
	}
}
