package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceValueResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Rates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReferenceChangeEvent extends BaseEvent implements IChangedEvent {

	private static final ILogger logger = LogFactory.getLogger(ReferenceChangeEvent.class);
	
	public ReferenceChangeEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs eventArgs) {
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity rate = entities.getEntity(Rates.ENTITY_NAME);
		
		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("H");
		rateRequest.setTypeH('V');
		rateRequest.setRateType(rate.get(Rates.REFERENCEVALUE));
		
		request.addValue("inRateRequest", rateRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger, Parameter.GET_REFERENCE_VALUE, request);
				
		if (response != null && response.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) response.getData();
			if (result.isSuccess()) {			
				ReferenceValueResponse[] referenceValueList = (ReferenceValueResponse[]) result.getValue("returnReferenceValueResponse");				
				for (ReferenceValueResponse referenceValue : referenceValueList) {
					rate.set(Rates.VALUE, referenceValue.getValue());
				}
			}
		}
	}

}
