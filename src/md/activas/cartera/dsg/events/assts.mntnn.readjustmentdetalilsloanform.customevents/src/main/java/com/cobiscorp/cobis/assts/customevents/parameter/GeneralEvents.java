package com.cobiscorp.cobis.assts.customevents.parameter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.CatalogValorDetRequest;
import cobiscorp.ecobis.assets.cloud.dto.CatalogValorDetResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class GeneralEvents extends BaseEvent {

	public GeneralEvents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger LOGGER = LogFactory
			.getLogger(GeneralEvents.class);

	public Map<String, Object> loadCatalog() {
		Map<String, Object> result = new HashMap<String, Object>();

		CatalogValorDetRequest catalogValorDetRequest = new CatalogValorDetRequest();
		ServiceRequestTO request = new ServiceRequestTO();

		catalogValorDetRequest.setRecordAmount(Parameter.REGISTERS_FOR_CATALOG);
		catalogValorDetRequest.setNext(" ");

		request.addValue("inCatalogValorDetRequest", catalogValorDetRequest);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("request: " + request.getData());
			LOGGER.logDebug("ServiceIntegration: " + getServiceIntegration());
		}

		ServiceResponse response = this.execute(getServiceIntegration(),
				LOGGER, Parameter.PROCESSCATALOGVALORDET, request);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Response: " + response.isResult());
		}

		if (response != null && response.isResult()) {
			result.put(Parameter.RESULTLISTCATALOG, this.listCatalog(response));
			result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
		} else {
			if (response != null) {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			} else {
				LOGGER.logDebug("OCURRIO UN ERROR DESCONOCIDO [SearchReadjustmentDetailsLoan].");
			}
		}

		return result;
	}

	private List<ItemDTO> listCatalog(ServiceResponse response) {
		List<ItemDTO> lista = null;

		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				CatalogValorDetResponse[] clResponse = (CatalogValorDetResponse[]) resultado
						.getValue("returnCatalogValorDetResponse");

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logInfo("Respuesta servicio CatalogValorDetResponse: "
							+ clResponse);
				}

				lista = new ArrayList<ItemDTO>();
				for (CatalogValorDetResponse r : clResponse) {
					ItemDTO item = new ItemDTO();
					item.setCode(r.getType().trim());
					item.setValue(r.getType().trim());

					lista.add(item);
				}
			}
		} catch (Exception ex) {
			this.manageException(ex, LOGGER);
			LOGGER.logDebug(ex.getMessage());
		}

		return lista;
	}
}
