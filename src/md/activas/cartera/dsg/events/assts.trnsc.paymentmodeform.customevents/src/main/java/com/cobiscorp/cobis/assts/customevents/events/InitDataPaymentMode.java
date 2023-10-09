package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.commons.UtilPaymentModeForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class InitDataPaymentMode extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(InitDataPaymentMode.class);

	public InitDataPaymentMode(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs catalogDataEventArgs) {
		UtilPaymentModeForm utilPaymentModeForm = new UtilPaymentModeForm(
				this.getServiceIntegration());
		List<Product> products;
		List<ItemDTO> paymentFormList = new ArrayList<ItemDTO>();
		logger.logDebug("InitDataPaymentMode.executeDataEvent(..)-> entro");

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("InitDataPaymentMode.executeDataEvent(..) --> codCurrency="
						+ catalogDataEventArgs.getParameters()
								.getCustomParameters().toString());
				logger.logDebug("InitDataPaymentMode.executeDataEvent(..) --> entities="
						+ entities.getData());
			}
			products = utilPaymentModeForm.getPaymentFormCmb(
					catalogDataEventArgs, entities);
			for (Product product : products) {
				ItemDTO item = new ItemDTO();
				item.setCode(product.getProducto());
				item.setValue(product.getDescripcion());
				paymentFormList.add(item);
			}
			return paymentFormList;
		} catch (Exception e) {
			logger.logDebug("Error InitDataPaymentMode.executeDataEvent(..)->"
					+ e);
		}
		return paymentFormList;
	}
}
