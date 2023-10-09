package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.designer.api.DataEntity;
public class LoadCatalogReadValueApply extends BaseEvent implements
		ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(LoadCatalogReadValueApply.class);

	private ICacheManager cacheManager;

	public LoadCatalogReadValueApply(ICTSServiceIntegration serviceIntegration,
			ICacheManager cacheManager) {
		super(serviceIntegration);
		this.cacheManager = cacheManager;

	}

	public LoadCatalogReadValueApply(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public ArrayList<ItemDTO> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Start executeCommand method in LoadCatalogReadValueApply class");
		}
		// DECLARAR VARIABLES
		ArrayList<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		DataEntity category = entities.getEntity(Category.ENTITY_NAME);
		// DataEntity category = entities.getEntity(Category.ENTITY_NAME);
		try {
			ICache cache = cacheManager.getCache(Mnemonic.CACHE_KEY);
			String wCacheKeyItems = "ItemsApplyValues";
			if (logger.isDebugEnabled()) {
				logger.logDebug("wCacheKeyItems : " + wCacheKeyItems);
			}
			// Se obtiene de caché
			if (cache.get(wCacheKeyItems) != null) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Se obtiene el arreglo de valores a aplicar de cache");
				}
				listItemDTO = (ArrayList<ItemDTO>) cache.get(wCacheKeyItems);
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Se obtiene el arreglo de valores a aplicar");
				}
				ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();
				loanItemsRequest.setType("A");// tipo
				loanItemsRequest.setBank(category.get(Category.BANK));								
				ServiceRequestTO serviceRequestItemRequest = new ServiceRequestTO();
				serviceRequestItemRequest.getData().put(
						"inReadLoanItemsRequest", loanItemsRequest);

				ServiceResponse serviceResponseItem = execute(
						getServiceIntegration(), logger,
						"Loan.SearchLoanItems.ReadValueApply",
						serviceRequestItemRequest);

				if (serviceResponseItem.isResult()) {
					ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponseItem
							.getData();
					ReadLoanItemsResponse[] itemResponse = (ReadLoanItemsResponse[]) serviceItemsResponseTO
							.getValue("returnReadLoanItemsResponse");
					if (itemResponse != null) {
						if (logger.isDebugEnabled()) {
							logger.logDebug("itemResponse is not null");
						}
						for (ReadLoanItemsResponse itemList : itemResponse) {
							ItemDTO item = new ItemDTO();
							if (logger.isDebugEnabled()) {
								logger.logDebug("item: ["
										+ itemList.getConcept() + ", "
										+ itemList.getDescripcion() + "]");
							}
							item.setCode(String.valueOf(itemList.getConcept()));
							item.setValue(itemList.getDescripcion().trim());
							// item.setAttributes(Arrays.asList(itemList.getConceptType()));//para
							// saber si es valor o factor
							listItemDTO.add(item);
						}
						// Guardar en caché
						cache.put(wCacheKeyItems, listItemDTO);
					}

				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.logError("Error in executeCommand method in LoadCatalogReadValueApply class: "
					+ ex);
		}
		return listItemDTO;

	}

}
