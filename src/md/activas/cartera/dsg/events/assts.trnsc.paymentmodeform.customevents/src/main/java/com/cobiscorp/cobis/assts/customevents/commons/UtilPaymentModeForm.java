package com.cobiscorp.cobis.assts.customevents.commons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.CatalogQuery;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class UtilPaymentModeForm extends BaseEvent {
	private static final ILogger logger = LogFactory
			.getLogger(UtilPaymentModeForm.class);
	public static final String COLUMN_NAME_COD_CURRENCY = "codCurrency";
	public static final String COLUMN_NAME_OPER_TYPE_ID = "operationTypeId";

	public UtilPaymentModeForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<Product> getPaymentFormCmb(
			ILoadCatalogDataEventArgs catalogDataEventArgs,
			DynamicRequest entities) {
		String creditLine = null;
		String codCurrency = null;
		String currencyFlagAux;
		DataEntity paymentForm;
		Map<String, Object> customParameters = new HashMap<String, Object>();

		if (logger.isDebugEnabled()) {
			logger.logDebug("UtilPaymentModeForm.executeDataEvent(..) --> customParameters= "
					+ catalogDataEventArgs.getParameters()
							.getCustomParameters());
			logger.logDebug("WATQ UtilPaymentModeForm.getPaymentFormCmb(..) -> entities="
					+ entities.getData());
		}

		if (catalogDataEventArgs.getParameters().getCustomParameters() != null) {
			customParameters = catalogDataEventArgs.getParameters()
					.getCustomParameters();
		}

		if (customParameters != null
				&& entities.getEntity(PaymentForm.ENTITY_NAME) != null) {
			paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);

			if (paymentForm.get(PaymentForm.CURRENCYFLAGAUX) != null) {
				currencyFlagAux = paymentForm.get(PaymentForm.CURRENCYFLAGAUX)
						.trim();
				if (Parameter.ZERO_VALUE.toString().equals(currencyFlagAux)
						&& customParameters.get(COLUMN_NAME_COD_CURRENCY) != null) {
					codCurrency = customParameters
							.get(COLUMN_NAME_COD_CURRENCY).toString();
				} else if (Parameter.ONE_VALUE.toString().equals(
						currencyFlagAux)
						&& paymentForm.get(PaymentForm.CURRENCYIDAUX) != null) {
					codCurrency = paymentForm.get(PaymentForm.CURRENCYIDAUX)
							.toString();
				}
			}

		}

		if (customParameters != null
				&& customParameters.get(COLUMN_NAME_OPER_TYPE_ID) != null) {
			creditLine = customParameters.get(COLUMN_NAME_OPER_TYPE_ID)
					.toString();
		}

		return executeServicePaymentForms(codCurrency, creditLine,
				catalogDataEventArgs);
	}

	private List<Product> executeServicePaymentForms(String codCurrency,
			String creditLine, ILoadCatalogDataEventArgs catalogDataEventArgs) {
		List<Product> products = new ArrayList<Product>();
		ProductListRequest productListRequest = new ProductListRequest();
		if (creditLine != null && codCurrency != null) {
			productListRequest.setLineaCre(creditLine);
			productListRequest.setMoneda(Integer.parseInt(codCurrency));
			productListRequest.setOperacion(Parameter.OPERATIONA.charAt(0));
			productListRequest.setTipo(Parameter.QUERYTYPE1);

			CatalogQuery catalogQuery = new CatalogQuery(
					this.getServiceIntegration());
			try {
				products = catalogQuery.queryProductList(catalogDataEventArgs,
						productListRequest);				
				
				if (products.isEmpty()) {
					catalogDataEventArgs.getMessageManager().showErrorMsg(
							"ASSTS.MSG_ASSTS_LAAPAGONN_54759");
				}
			} catch (Exception e) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("UtilPaymentModeForm.executeDataEvent(..) --> Exception="
							+ e);
				}
			} finally {
				if (logger.isDebugEnabled()) {
					logger.logDebug("UtilPaymentModeForm.executeDataEvent(..) --> finally");
				}
			}
		}
		return products;
	}
}
