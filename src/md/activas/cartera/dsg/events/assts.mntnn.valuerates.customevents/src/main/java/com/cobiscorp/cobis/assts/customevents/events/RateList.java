package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.assets.cloud.dto.RatesResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.TypeRates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class RateList extends BaseEvent {
	
	private static final ILogger logger = LogFactory.getLogger(RateList.class);
	
	public RateList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void loadRateList(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("S");
		rateRequest.setOption(Integer.valueOf(1));
		serviceRequestTO.addValue("inRateRequest", rateRequest);

		ServiceResponse serviceResponse = this.execute(logger, Parameter.SEARCH_TYPE_RATES, serviceRequestTO);  
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {

				RatesResponse[] ratesList = (RatesResponse[]) serviceResponseTO.getValue("returnRatesResponse");
				DataEntityList typeRateList = new DataEntityList();

				for (RatesResponse r : ratesList) {
					DataEntity typeRate = new DataEntity();
					typeRate.set(TypeRates.IDENTIFIER, r.getIdentifier());
					typeRate.set(TypeRates.DESCRIPTION, r.getDescription());
					typeRate.set(TypeRates.CLASE, r.getRateClass());
					typeRate.set(TypeRates.RATEPIT, r.getPit());
					typeRateList.add(typeRate);
				}
				entities.setEntityList(TypeRates.ENTITY_NAME, typeRateList);
			}
		}
		
	}

}
