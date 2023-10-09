package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.assts.model.PaymentMethod;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GetPaymentMethod extends BaseEvent implements IChangedEvent {

	private static final ILogger logger = LogFactory
			.getLogger(GetPaymentMethod.class);

	public GetPaymentMethod(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entites, IChangedEventArgs changedEventArgs) {
		
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity payment = entites.getEntity(Payment.ENTITY_NAME);
		DataEntity paymentMethod = entites.getEntity(PaymentMethod.ENTITY_NAME);
		
		ProductListRequest productListRequest = new ProductListRequest();
		productListRequest.setOperacion('V');
		productListRequest.setTipo(8);
		productListRequest.setMoneda(payment.get(Payment.CURRENCYTYPE));
		productListRequest.setLineaCre(payment.get(Payment.PAYMENTTYPE));
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("payment.get(Payment.PAYMENTTYPE) --> " + payment.get(Payment.PAYMENTTYPE));
		}
		
		request.addValue("inProductListRequest", productListRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger, Parameter.PROCESS_QUERYPRODUCT, request);
				
		if (response != null && response.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) response.getData();
			if (result.isSuccess()) {			
				Product[] productList = (Product[]) result.getValue("returnProduct");				
				for (Product product : productList) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("product.getCategoria() --> " + product.getCategoria());
					}
					paymentMethod.set(PaymentMethod.PRODUCT, product.getProducto());
					paymentMethod.set(PaymentMethod.DESCRIPTION, product.getDescripcion());
					paymentMethod.set(PaymentMethod.CATEGORY, product.getCategoria());
					paymentMethod.set(PaymentMethod.RETENTION, product.getRetencion());
					paymentMethod.set(PaymentMethod.COBISPRODUCT, product.getPCobis());
				}
			}
		}
	}

}
