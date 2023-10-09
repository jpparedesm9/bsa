package com.cobiscorp.cobis.assets.commons.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.Currency;
import cobiscorp.ecobis.assets.cloud.dto.CurrencyListRequest;
import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CatalogQuery extends BaseEvent {
	private static final ILogger logger = LogFactory
			.getLogger(AmortizationTable.class);

	public CatalogQuery(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<Product> queryProductList(ICommonEventArgs eventArgs,
			ProductListRequest productListRequest) {
		List<Product> productList = new ArrayList<Product>();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		Product[] products ;
		serviceRequestTO.addValue("inProductListRequest", productListRequest);
		serviceResponse = this.execute(logger,
				Parameter.PROCESS_QUERYPRODUCTLIST, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				products = (Product[]) serviceResponseTO
						.getValue("returnProduct");				
				for (Product product : products) {										
					productList.add(product);
				}
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(
					serviceResponse.getMessages(), null);
			eventArgs.getMessageManager().showErrorMsg(mensaje);

		}
		return productList;
	}

	public List<ItemDTO> queryCurrencyList(ILoadCatalogDataEventArgs catalogDataEventArgs,
			CurrencyListRequest currencyListRequest) {

		List<ItemDTO> lista = new ArrayList<ItemDTO>();

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ServiceResponse response;

		serviceRequest.addValue("inCurrencyListRequest", currencyListRequest);

		response = this.execute(logger,
				Parameter.PROCESS_QUERYCURRENCYLISTCREDIT, serviceRequest);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			if (resultado.isSuccess()) {
				Currency[] currency = (Currency[]) resultado
						.getValue("returnCurrency");
				for (Currency item : currency) {
					ItemDTO itemMoneda = new ItemDTO();
					itemMoneda.setCode(String.valueOf(item.getCodigo()).trim());
					itemMoneda.setValue(item.getMoneda().trim());
					lista.add(itemMoneda);
				}
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(
					response.getMessages(), null);
			catalogDataEventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}
}
