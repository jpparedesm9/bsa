package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class LoadCatalogInsertItem extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(LoadCatalogInsertItem.class);

	private ICacheManager cacheManager;

	public LoadCatalogInsertItem(ICTSServiceIntegration serviceIntegration,
			ICacheManager cacheManager) {
		super(serviceIntegration);
		this.cacheManager = cacheManager;

	}

	public LoadCatalogInsertItem(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<ItemDTO> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Start executeCommand method in LoadCatalogInsertItem class");
		}
		ArrayList<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		try {
			// DECLARAR VARIABLES
			DataEntity category = entities.getEntity(Category.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			ICache cache = cacheManager.getCache(Mnemonic.CACHE_KEY);
			String wCacheKeyItems = "ITEMS-"
					+ category.get(Category.PRODUCTTYPE).trim(); // toperacion
			wCacheKeyItems = wCacheKeyItems
					+ "-"
					+ (paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED) == null ? null
							: String.valueOf(paymentPlanHeader
									.get(PaymentPlanHeader.IDREQUESTED))); // banco
			wCacheKeyItems = wCacheKeyItems
					+ "-"
					+ (category.get(Category.CURRENCY) == null ? null
							: category.get(Category.CURRENCY).toString()); // moneda
			if (logger.isDebugEnabled()) {
				logger.logDebug("wCacheKeyItems : " + wCacheKeyItems);
			}

			// Se obtiene de caché
			if (cache.get(wCacheKeyItems) != null) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Se obtiene el arreglo de rubros de cache");
				}
				listItemDTO = (ArrayList<ItemDTO>) cache.get(wCacheKeyItems);
			} else {
				ItemsManagement itemsManagement = new ItemsManagement(
						getServiceIntegration());
				ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();
				loanItemsRequest.setBank(paymentPlanHeader
						.get(PaymentPlanHeader.IDREQUESTED) == null ? null
						: String.valueOf(paymentPlanHeader
								.get(PaymentPlanHeader.IDREQUESTED)));// banco
				loanItemsRequest.setCurrency(category.get(Category.CURRENCY)
						.intValue());// moneda
				loanItemsRequest.setOperationType(category
						.get(Category.PRODUCTTYPE) == null ? null : category
						.get(Category.PRODUCTTYPE).trim()); // toperacion
				loanItemsRequest.setType("A");// tipo
				loanItemsRequest.setFineItem("N");// rubros multa

				ReadLoanItemsResponse[] itemResponse = itemsManagement
						.readItem(entities, args, loanItemsRequest);
				if (itemResponse != null) {
					for (ReadLoanItemsResponse itemList : itemResponse) {
						ItemDTO item = new ItemDTO();
						item.setCode(String.valueOf(itemList.getConcept()));
						item.setValue(itemList.getDescripcion());
						listItemDTO.add(item);
					}
					// Guardar en caché
					cache.put(wCacheKeyItems, listItemDTO);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.logError(
					"Error in executeCommand method in LoadCatalogInsertItem class: ",
					ex);
		}
		return listItemDTO;

	}
}
