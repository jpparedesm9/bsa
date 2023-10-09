package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class InitDataPaymentModeAux extends BaseEvent implements IChangedEvent,
		ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(InitDataPaymentModeAux.class);

	public InitDataPaymentModeAux(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public  List<ItemDTO> getPaymentFormAux(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
		List<ItemDTO> lista = null;
		String creditLine = "";
		Integer codCurrency = 0;
		DataEntity paymentModeCmb = entities.getEntity(PaymentForm.ENTITY_NAME);

		if (logger.isDebugEnabled()) {
			logger.logDebug("InitDataPaymentModeAux.getPaymentFormAux(..) --> CustomParameters="
					+ args.getParameters().getCustomParameters());
			logger.logDebug("InitDataPaymentModeAux.getPaymentFormAux(..) --> entities="
					+ entities.getData());

		}
		if (args.getParameters().getCustomParameters() != null
				&& args.getParameters().getCustomParameters()
						.get("operationTypeId") != null
				&& paymentModeCmb != null
				&& paymentModeCmb.get(PaymentForm.CURRENCYID) != null) {
			creditLine = args.getParameters().getCustomParameters()
					.get("operationTypeId").toString();
			codCurrency = entities.getEntity(PaymentForm.ENTITY_NAME).get(
					PaymentForm.CURRENCYID);
			if (logger.isDebugEnabled()) {
				logger.logDebug("InitDataPaymentModeAux.getPaymentFormAux(..) --> codCurrency= "
						+ codCurrency);
				logger.logDebug("InitDataPaymentModeAux.getPaymentFormAux(..) --> creditLine= "
						+ creditLine);
			}
		}
		
		ProductListRequest productListRequest = new ProductListRequest();
		productListRequest.setLineaCre(creditLine);
		productListRequest.setMoneda(codCurrency);
		productListRequest.setOperacion(Parameter.OPERATIONA.charAt(0));
		productListRequest.setTipo(Parameter.QUERYTYPE1);

		return lista;
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("InitDataPaymentModeAux.getPaymentFormAux(..) --> entities="
					+ entities.getData());
		}

	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs arg1) {
		List<?> var =null;
		if (logger.isDebugEnabled()) {
			logger.logDebug("InitDataPaymentModeAux.executeDataEvent(..) --> entities= "
					+ entities.getData());
		}
		return var;
	}
}
