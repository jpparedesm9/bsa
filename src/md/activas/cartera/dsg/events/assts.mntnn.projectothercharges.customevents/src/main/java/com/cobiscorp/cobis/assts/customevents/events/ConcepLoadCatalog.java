package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.OtherChargesConcept;
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

public class ConcepLoadCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(ConcepLoadCatalog.class);

	public ConcepLoadCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {

		HashMap<String, Object> newMap = (HashMap<String, Object>) args
				.getParameters().getCustomParameters().get("entity");

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		LoanRequest requestInLoanRequest = new LoanRequest();
		List<ItemDTO> lista = null;
		requestInLoanRequest.setTypeOperation((String) newMap
				.get("operationTypeID"));

		Integer moneyConv = (Integer) newMap.get("codCurrency");		
		requestInLoanRequest.setCurrency(moneyConv);
		requestInLoanRequest.setOperation('H');

		serviceRequest.addValue("inLoanRequest", requestInLoanRequest);

		ServiceResponse response = this.execute(logger,
				Parameter.PROCESS_CONCEPLOADCATALOG, serviceRequest);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			if (resultado.isSuccess()) {
				OtherChargesConcept[] clResponseList = (OtherChargesConcept[]) resultado
						.getValue("returnOtherChargesConcept");

				lista = new ArrayList<ItemDTO>();
				for (OtherChargesConcept r : clResponseList) {
					ItemDTO item = new ItemDTO();
					item.setCode(r.getConcept());
					item.setValue(r.getDescription());

					lista.add(item);

				}

			}
		} else {
			String mensaje = GeneralFunction.getMessageError(
					response.getMessages(), null);

			args.getMessageManager().showErrorMsg(mensaje);
		}

		return lista;
	}

}
