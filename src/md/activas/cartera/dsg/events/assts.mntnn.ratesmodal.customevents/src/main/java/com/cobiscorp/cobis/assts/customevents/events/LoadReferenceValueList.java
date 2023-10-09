package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.Currency;
import cobiscorp.ecobis.assets.cloud.dto.CurrencyListRequest;
import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
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

public class LoadReferenceValueList extends BaseEvent implements ILoadCatalog {
	
	private static final ILogger logger = LogFactory.getLogger(LoadReferenceValueList.class);

	public LoadReferenceValueList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs eventArgs) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ServiceResponse response;

		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("H");
		rateRequest.setTypeH('A');

		serviceRequest.addValue("inRateRequest", rateRequest);
		response = this.execute(logger,Parameter.REFERENCE_VALUE_LIST, serviceRequest);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ItemResponse[] referenceValueList = (ItemResponse[]) resultado.getValue("returnItemResponse");
				for (ItemResponse item : referenceValueList) {
					ItemDTO itemReferenceValue = new ItemDTO();
					itemReferenceValue.setCode(item.getProduct().trim());
					itemReferenceValue.setValue(item.getDescription());
					lista.add(itemReferenceValue);
				}
			}
		}
		else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			eventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}

}
