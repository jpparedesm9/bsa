package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.Map;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QuoteManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(QuoteManagement.class);
	private QuoteResponse exchangeQuote;

	public QuoteManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public QuoteResponse getExchangeQuote() {
		return exchangeQuote;
	}

	public Double exchangeForeignToLocal(int localCurrency, int destinationCurrency, Double value, ICommonEventArgs arg1, BehaviorOption options) {
		this.exchangeQuote = null;
		QuoteRequest quoteRequest = new QuoteRequest();
		quoteRequest.setCurrencyOrigin(destinationCurrency);
		quoteRequest.setCurrencyDestination(localCurrency);
		quoteRequest.setModule(Mnemonic.MODULE);
		quoteRequest.setValue(value);
		quoteRequest.setDestinationValue(0.0);

		return getExchange(quoteRequest, "@o_valor_convertido", arg1, options);
	}

	public Double exchangeLocalToForeign(int localCurrency, int destinationCurrency, Double value, ICommonEventArgs arg1, BehaviorOption options) {
		this.exchangeQuote = null;
		QuoteRequest quoteRequest = new QuoteRequest();
		quoteRequest.setCurrencyOrigin(destinationCurrency);
		quoteRequest.setCurrencyDestination(localCurrency);
		quoteRequest.setModule(Mnemonic.MODULE);
		quoteRequest.setValue(0.0);
		quoteRequest.setDestinationValue(value);

		return getExchange(quoteRequest, "@o_valor_conver_orig", arg1, options);
	}

	private Double getExchange(QuoteRequest quoteRequest, String ouputName, ICommonEventArgs arg1, BehaviorOption options) {
		this.exchangeQuote = null;

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INQUOTEREQUEST, quoteRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.GETQUOTEEXCHANGE, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceTOResponse = new ServiceResponseTO();
			serviceTOResponse = (ServiceResponseTO) serviceResponse.getData();
			if (serviceTOResponse.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> processesResponse = (Map<String, Object>) serviceTOResponse.getValue(ReturnName.OUTPUT);

				QuoteResponse quoteResponseDto = new QuoteResponse();
				if (Validate.Strings.isNotNullOrEmpty(processesResponse.get("@o_valor_convertido"))) {
					quoteResponseDto.setConvertedValue(Double.parseDouble(processesResponse.get("@o_valor_convertido").toString()));
				}
				if (Validate.Strings.isNotNullOrEmpty(processesResponse.get("@o_cot_usd"))) {
					quoteResponseDto.setQuoteUSD(Double.parseDouble(processesResponse.get("@o_cot_usd").toString()));
				}
				if (Validate.Strings.isNotNullOrEmpty(processesResponse.get("@o_factor"))) {
					quoteResponseDto.setFactor(Double.parseDouble(processesResponse.get("@o_factor").toString()));
				}
				if (Validate.Strings.isNotNullOrEmpty(processesResponse.get("@o_cotizacion"))) {
					quoteResponseDto.setQuote(Double.parseDouble(processesResponse.get("@o_cotizacion").toString()));
				}
				if (Validate.Strings.isNotNullOrEmpty(processesResponse.get("@o_valor_conver_orig"))) {
					quoteResponseDto.setConvertedOriginalValue(Double.parseDouble(processesResponse.get("@o_valor_conver_orig").toString()));
				}
				this.exchangeQuote = quoteResponseDto;
				return Double.parseDouble(processesResponse.get(ouputName).toString());
			} else {
				MessageManagement.show(serviceTOResponse, arg1, options);
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

}
