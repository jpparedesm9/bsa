package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.Currency;
import cobiscorp.ecobis.assets.cloud.dto.CurrencyListRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CurrencyCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory.getLogger(CurrencyCatalog.class);
	
	public CurrencyCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ServiceResponse response;
		
		CurrencyListRequest currencyListRequest = new CurrencyListRequest();
		currencyListRequest.setOperacion('H');
		currencyListRequest.setTipo('A');
		currencyListRequest.setModo(0);

		serviceRequest.addValue("inCurrencyListRequest", currencyListRequest);

		response = this.execute(logger,Parameter.PROCESS_QUERYCURRENCYLISTCREDIT, serviceRequest);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				Currency[] currency = (Currency[]) resultado.getValue("returnCurrency");
				for (Currency item : currency) {
					ItemDTO itemMoneda = new ItemDTO();
					itemMoneda.setCode(String.valueOf(item.getCodigo()).trim());
					itemMoneda.setValue(item.getMoneda().trim());
					lista.add(itemMoneda);
				}
			}
		}
		else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}
}
