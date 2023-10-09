package com.cobiscorp.cobis.loans.customevents.events;

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

public class LoadBusinessData extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadBusinessData.class);
	private static final String GRUPAL = "GRUPAL";

	public LoadBusinessData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		LOGGER.logError("---->Declaracion de TransactionManagement");

		
		InsuranceManager insuranceManager = new InsuranceManager(getServiceIntegration());
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
			for (InsuranceResponse amount : insuranceManager.queryInsurance(getServiceIntegration(), args, GRUPAL)) {
				ItemDTO item = new ItemDTO();  
				LOGGER.logError("los valores son"+amount.getSePaquete());
				LOGGER.logError("los valores son"+amount.getSeDescripcion());
				item.setCode(amount.getSePaquete());
				item.setValue(amount.getSeDescripcion());
				listItemDTO.add(item);
			}
			LOGGER.logError("listItemDTO este es el tamaño"+listItemDTO.size());
			
			return listItemDTO;

		} catch (Exception e) {
			LOGGER.logError("Error en la carga del catalogo de Oficial: ", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento LoadCatalogOfficial");
			}

		}
		return listItemDTO;
	}
}
