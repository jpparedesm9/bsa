package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;

public class LoadCatalogBankingProduct extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogBankingProduct.class);

	public LoadCatalogBankingProduct(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		LOGGER.logDebug("---->Entra al LoadCatalogBankingProduct");

		LOGGER.logDebug("Variables");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {

			LOGGER.logError("---->Declaracion de TransactionManagement");
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			LOGGER.logDebug("---->Recupera entidades");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			String product = originalHeader.get(OriginalHeader.PRODUCTFIE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTFIE);
			String productType = originalHeader.get(OriginalHeader.PRODUCTTYPE);
			String productTypeName = generalData.get(new Property<String>("productTypeName", String.class, false));
			String type = generalData.get(new Property<String>("type", String.class, false));

			LOGGER.logDebug("---->Recupero parametros de la URL enviada");
			@SuppressWarnings("unchecked")
			Map<String, Object> task = (Map<String, Object>) args.getParameters().getCustomParameters().get("Task");
			@SuppressWarnings("unchecked")
			Map<String, Object> url = (Map<String, Object>) task.get("urlParams");

			if (type != null && type.equals("RENOVATION")) {

				LOGGER.logDebug("---->Ejecucion de servicio para recuperar lo productos");

				for (BankingProduct bankingProduct : bankingProductManager.getBankingProductByModule(args, "")) {
					LOGGER.logDebug("bankingProduct.getId()------->" + bankingProduct.getId());
					LOGGER.logDebug("bankingProduct.getName()----->" + bankingProduct.getName());
					ItemDTO item = new ItemDTO();
					item.setCode(bankingProduct.getId().trim());
					item.setValue(bankingProduct.getName().trim());
					listItemDTO.add(item);
				}

			} else {

				if (product.equals("")) {

					LOGGER.logDebug("---->Set de los campos por defecto");
					ItemDTO item = new ItemDTO();
					item.setCode(productType);
					item.setValue(productTypeName);
					listItemDTO.add(item);

				} else {

					LOGGER.logDebug("---->Ejecucion de servicio para recuperar lo productos");

					for (BankingProduct bankingProduct : bankingProductManager.getBankingProductByModule(args, product)) {
						LOGGER.logDebug("bankingProduct.getId()------->" + bankingProduct.getId());
						LOGGER.logDebug("bankingProduct.getName()----->" + bankingProduct.getName());
						ItemDTO item = new ItemDTO();
						item.setCode(bankingProduct.getId().trim());
						item.setValue(bankingProduct.getName().trim());
						listItemDTO.add(item);
					}
				}

			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_BAKING_PRODUCT, e, args, LOGGER);
		}

		return listItemDTO;
	}

}
