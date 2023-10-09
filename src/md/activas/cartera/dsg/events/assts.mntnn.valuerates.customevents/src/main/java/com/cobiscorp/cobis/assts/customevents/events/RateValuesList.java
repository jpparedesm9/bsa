package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.assets.cloud.dto.RateValuesResponse;
import cobiscorp.ecobis.assets.cloud.dto.RatesResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Rates;
import com.cobiscorp.cobis.assts.model.TypeRates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class RateValuesList extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(RateValuesList.class);
			
	public RateValuesList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public void loadRateValuesList(DynamicRequest entities, String rateID, char clase) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("S");
		rateRequest.setOption(Integer.valueOf(2));
		rateRequest.setRateType(rateID);
		serviceRequestTO.addValue("inRateRequest", rateRequest);

		ServiceResponse serviceResponse = this.execute(logger, Parameter.SEARCH_VALUES_RATES, serviceRequestTO);  
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				RateValuesResponse[] ratesValuesList = (RateValuesResponse[]) serviceResponseTO.getValue("returnRateValuesResponse");
				DataEntityList rateList = new DataEntityList();
				for (RateValuesResponse r : ratesValuesList) {
					logger.logDebug("PORTFOLIOCLASS --> " + r.getSector());
					DataEntity rate = new DataEntity();
					rate.set(Rates.PORTFOLIOCLASS, r.getSector());
					rate.set(Rates.SIGNDEFAULT, r.getDefaultSign());
					rate.set(Rates.VALUEDEAFULT, r.getDefaultValue());
					rate.set(Rates.SIGNMIN, r.getMinimumSign());
					rate.set(Rates.VALUEMIN, r.getMinimumValue());
					rate.set(Rates.SIGNMAX, r.getMaximumSign());
					rate.set(Rates.VALUEMAX, r.getMaximumValue());
					rate.set(Rates.REFERENCEVALUE, r.getReference());
					rate.set(Rates.TYPEPOINTS, r.getPointsType());
					rate.set(Rates.NUMBERDECIMALS, r.getDecimalsNumber());
					rate.set(Rates.RATETYPE, r.getIdentifier());
					rate.set(Rates.CLASE, clase);
					rateList.add(rate);
				}
				entities.setEntityList(Rates.ENTITY_NAME, rateList);
			}
		}
	}
}
