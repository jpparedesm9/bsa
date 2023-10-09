package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.CatalogBank;
import cobiscorp.ecobis.assets.cloud.dto.CatalogBankRequest;
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

public class CatalogBankPaymentMain extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(CatalogBankPaymentMain.class);

	public CatalogBankPaymentMain(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		CatalogBankRequest catalogBankRequest = new CatalogBankRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		catalogBankRequest.setOperation("S");
		catalogBankRequest.setType("A");
		catalogBankRequest.setMode(0);

		serviceRequestTO.addValue("inCatalogBankRequest", catalogBankRequest);
		serviceResponse = this.execute(logger,
				Parameter.PROCESS_QUERYCATALOGBANK, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				CatalogBank[] catalogBanks = (CatalogBank[]) serviceResponseTO
						.getValue("returnCatalogBank");
				for (CatalogBank bank : catalogBanks) {
					ItemDTO itemBanco = new ItemDTO();
					itemBanco.setCode(String.valueOf(bank.getBank()).trim());
					itemBanco.setValue(bank.getFinancialEntity());
					lista.add(itemBanco);
				}
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(
					serviceResponse.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}
}
