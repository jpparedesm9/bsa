package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AccountPriorityRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AccountPriorityResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerProduct;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class ProductList extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(ProductList.class);

	public ProductList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs eventArgs) {
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
			List<CustomerProduct> productList = (List<CustomerProduct>) SessionManager.getSession().get("PRODUC_LIST");
			LOGGER.logDebug("Productos del cliente: " + productList.toString());
			LOGGER.logDebug("Productos en Sesion: " + SessionManager.getSession().get("PRODUC_LIST").toString());
			AccountPriorityRequest priorityRequest = new AccountPriorityRequest();
			priorityRequest.setOperation("Q");
			TransferManager transferManager = new TransferManager(this.getServiceIntegration());
			AccountPriorityResponse[] accountsPriority = transferManager.searchAccountPriority(priorityRequest, eventArgs);
			for (CustomerProduct product : productList) {
				ItemDTO item = new ItemDTO();
				item.setCode(product.getContractNumber());
				for (AccountPriorityResponse priority : accountsPriority) {
					if (belongsToNivelPrelacion(product, priority)) {
						item.setValue(product.getContractNumber() + " - " + priority.getLevel());
						break;
					} else {
						item.setValue(product.getContractNumber());
					}
				}
				listItemDTO.add(item);
			}
			LOGGER.logDebug("Lista de items para retornar: " + listItemDTO.toString());
			return listItemDTO;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_NATIONALITY, e, eventArgs, LOGGER);
		}
		return listItemDTO;
	}

	private boolean belongsToNivelPrelacion(CustomerProduct product, AccountPriorityResponse nivelPrelacion) {
		return product.getProductId().contentEquals(nivelPrelacion.getProduct()) && product.getSubproductId().contentEquals(nivelPrelacion.getSubProduct());
	}

}
