package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Rates;
import com.cobiscorp.cobis.assts.model.TypeRates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CreateValueRate extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(CreateValueRate.class);
	
	public CreateValueRate(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs eventArgs) {

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity valueRate = entities.getEntity(Rates.ENTITY_NAME);

		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("I");
		rateRequest.setOption(2);
		rateRequest.setRateType(valueRate.get(Rates.RATETYPE));
		rateRequest.setSector(valueRate.get(Rates.PORTFOLIOCLASS));
		rateRequest.setDefaultValue(valueRate.get(Rates.VALUEDEAFULT));
		if (valueRate.get(Rates.CLASE) == 'F') {
			rateRequest.setPointType(valueRate.get(Rates.TYPEPOINTS));
			rateRequest.setDecimalNumber(valueRate.get(Rates.NUMBERDECIMALS));
			rateRequest.setReference(valueRate.get(Rates.REFERENCEVALUE));
			rateRequest.setDefaultSign(valueRate.get(Rates.SIGNDEFAULT));
			rateRequest.setMinimumSign(valueRate.get(Rates.SIGNMIN));
			rateRequest.setMinimumValue(valueRate.get(Rates.VALUEMIN));
			rateRequest.setMaximumSign(valueRate.get(Rates.SIGNMAX));
			rateRequest.setMaximumValue(valueRate.get(Rates.VALUEMAX));
		}
		request.addValue("inRateRequest", rateRequest);

		ServiceResponse response = this.execute(logger, Parameter.CREATE_TYPE_RATE, request);

		if (response.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			if (serviceResponseTO.isSuccess()) {
				String mensaje = "Registro guardado correctamente";
				eventArgs.getMessageManager().showInfoMsg(mensaje);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			eventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		
	}

}
