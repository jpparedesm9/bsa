package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class PaymentMethodCatalog  extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory.getLogger(PaymentMethodCatalog.class);
	
	public PaymentMethodCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs catalogDataEventArgs) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		ProductListRequest productListRequest = new ProductListRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		productListRequest.setMoneda(0);
		productListRequest.setOperacion('A');
		productListRequest.setTipo(1);
		
		serviceRequestTO.addValue("inProductListRequest", productListRequest);
		serviceResponse = this.execute(logger, Parameter.PROCESS_QUERYPRODUCTLIST, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				Product[] products = (Product[]) serviceResponseTO.getValue("returnProduct");
				for (Product product : products) {
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(product.getProducto().trim());
					itemDTO.setValue(product.getDescripcion().trim());
					lista.add(itemDTO);
				}
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			catalogDataEventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}

}
