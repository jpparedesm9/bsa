package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.OtherChargesItems;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.OtherCharges;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ChangeBaseCalculation extends BaseEvent implements IChangedEvent {

	private static final ILogger logger = LogFactory
			.getLogger(ChangeBaseCalculation.class);
	
	public ChangeBaseCalculation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration); 
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		@SuppressWarnings("unchecked")
		HashMap<String, Object>  newMap = (HashMap<String, Object>) args.getParameters().getCustomParameters().get("entity");
		DataEntity otherCharges = entities.getEntity(OtherCharges.ENTITY_NAME);				

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		LoanRequest requestInLoanRequest = new LoanRequest();

		requestInLoanRequest.setBank((String) newMap.get("loanBankID"));	
		requestInLoanRequest.setConcept(otherCharges.get(OtherCharges.CONCEPT));		
		Integer moneyConv = (Integer) newMap.get("codCurrency");		
		requestInLoanRequest.setCurrency(moneyConv);
		requestInLoanRequest.setOperation('C');
		requestInLoanRequest.setCalculationBased(otherCharges.get((OtherCharges.BASECALCULATION)));
		requestInLoanRequest.setTcotizOp(otherCharges
							.get(OtherCharges.BALANCEOP));
		requestInLoanRequest.setTCotisDs(otherCharges
							.get(OtherCharges.BALANCEDESEMP));		
		requestInLoanRequest.setRate(otherCharges.get(OtherCharges.RATE));
		

		serviceRequest.addValue("inLoanRequest", requestInLoanRequest);

		ServiceResponse response = this.execute(logger, Parameter.PROCESS_CHANGEBASECALCULATION,
				serviceRequest);
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			if (resultado.isSuccess()) {
				OtherChargesItems[] clResponseList = (OtherChargesItems[]) resultado
						.getValue("returnOtherChargesItems");
				
				for (OtherChargesItems r : clResponseList) {

					otherCharges.set(OtherCharges.VALUE, r.getDefaultValue());
					otherCharges
							.set(OtherCharges.VALUEMAX, r.getMaximumValue());
					otherCharges
							.set(OtherCharges.VALUEMIN, r.getMinimumValue());					
				}
			}
		}else {
			String mensaje = GeneralFunction.getMessageError(
					response.getMessages(), null);

			args.getMessageManager().showErrorMsg(mensaje);
		}
		
	}

}
