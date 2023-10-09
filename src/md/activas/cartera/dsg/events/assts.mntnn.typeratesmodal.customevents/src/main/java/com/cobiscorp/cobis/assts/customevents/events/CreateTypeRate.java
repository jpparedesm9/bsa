package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.assets.cloud.dto.RatesResponse;
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

public class CreateTypeRate extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(CreateTypeRate.class);
	
	public CreateTypeRate(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,IExecuteCommandEventArgs eventArgs) {
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity typeRate = entities.getEntity(TypeRates.ENTITY_NAME);

		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("I");
		rateRequest.setOption(1);
		rateRequest.setRateType(typeRate.get(TypeRates.IDENTIFIER));
		rateRequest.setRateDescription(typeRate.get(TypeRates.DESCRIPTION));
		rateRequest.setPitRate(typeRate.get(TypeRates.RATEPIT));
		rateRequest.setRateClass(typeRate.get(TypeRates.CLASE));
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
