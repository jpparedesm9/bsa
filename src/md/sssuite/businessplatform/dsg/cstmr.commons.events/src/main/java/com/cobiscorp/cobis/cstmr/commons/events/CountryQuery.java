package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CountryRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CountryResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CountryQuery extends BaseEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(CountryQuery.class);
	private Parameter.TYPESEUDOCATALOG typeSeudoCatalog;

	public CountryQuery(ICTSServiceIntegration serviceIntegration,
			Parameter.TYPESEUDOCATALOG typeSeudoCatalog) {
		super(serviceIntegration);
		this.typeSeudoCatalog = typeSeudoCatalog;
	}

	public List<?> loadCountry(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (loadCountry)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		List<ItemDTO> listado = new ArrayList<ItemDTO>();
		String mensaje = Parameter.EMPTY_VALUE;

		try {

			result = this.queryCountryList();
			
			/*
			if (GeneralFunction.writeResult(result,
					Parameter.TYPEEXECUTION.SEARCH, args)) {
			*/
			listado = (List<ItemDTO>) result
						.get(Parameter.RESULTLISTCATALOG);
			//}
			
			// mensaje = GeneralFunction.getMessageError(
			// (List<Message>) result.get(Parameter.MESSAGESERVERLIST),
			// (List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));
			//
			// if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
			// args.getMessageManager().showErrorMsg(mensaje);
			// } else {
			// listado = (List<ItemDTO>) result
			// .get(Parameter.RESULTLISTCATALOG);
			// }
		} catch (Exception ex) {
			LOGGER.logError(ex);
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO executeDataEvent (CatalogManager)");
		}

		return listado;
	}

	private Map<String, Object> queryCountryList() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO executeDataEvent (queryCountryList)");
		}

		return queryCountry(this.readCountry());
	}

	private Map<String, Object> queryCountry(CountryRequest countryRequest) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO executeDataEvent (queryCountry)");
		}

		serviceRequestTO.addValue("inCountryRequest", countryRequest);
		serviceResponse = this.execute(LOGGER, Parameter.PROCESSLOADCOUNTY,
				serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				CountryResponse[] clResponse = (CountryResponse[]) serviceResponseTO
						.getValue("returnCountryResponse");

				for (CountryResponse country : clResponse) {
					lista.add(returnItemDTO(country));
				}

				result.put(Parameter.RESULTLISTCATALOG, lista);
			}
		} else {
			result.put(Parameter.MESSAGESERVERLIST,
					serviceResponse.getMessages());
		}
		return result;
	}

	private CountryRequest readCountry() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (readCountry)");
		}

		CountryRequest countryRequest = new CountryRequest();

		countryRequest.setOperation("H");
		countryRequest.setType("A");
		countryRequest.setMode(2);
		countryRequest.setTrn(1553);

		return countryRequest;
	}

	private ItemDTO returnItemDTO(CountryResponse country) {
		ItemDTO itemDTO = new ItemDTO();

		itemDTO.setCode(String.valueOf(country.getCountryCode()));
		
		switch (this.typeSeudoCatalog) {
		case COUNTRY:
			itemDTO.setValue(country.getCountry().trim());
			break;
		case NATIONALITY:
			itemDTO.setValue(country.getNationality().trim());
			break;
		default:
			GeneralFunction.writeLog(LOGGER,
					"NO EXISTE TIPO DE SEUDO CATALOGO",
					Parameter.LEVELDEBUG.ERROR);
			break;
		}

		return itemDTO;
	}
}
