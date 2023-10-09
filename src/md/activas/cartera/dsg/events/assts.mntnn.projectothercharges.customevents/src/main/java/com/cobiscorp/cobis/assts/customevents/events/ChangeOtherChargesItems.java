package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
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
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ChangeOtherChargesItems extends BaseEvent implements
		IChangedEvent, IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(ChangeOtherChargesItems.class);

	public ChangeOtherChargesItems(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		// TODO Auto-generated method stub
		changeOtherCharges(entities, args);
	}

	private void changeOtherCharges(DynamicRequest entities,
			ICommonEventArgs args) {
		try {
			@SuppressWarnings("unchecked")
			HashMap<String, Object> newMap = (HashMap<String, Object>) args
					.getParameters().getCustomParameters().get("entity");
			DataEntity otherCharges = entities
					.getEntity(OtherCharges.ENTITY_NAME);

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			LoanRequest requestInLoanRequest = new LoanRequest();

			requestInLoanRequest.setBank((String) newMap.get("loanBankID"));
			requestInLoanRequest.setTypeOperation((String) newMap
					.get("operationTypeID"));
			Integer moneyConv = (Integer) newMap.get("codCurrency");
			requestInLoanRequest.setCurrency(moneyConv);
			requestInLoanRequest.setConcept(otherCharges
					.get(OtherCharges.CONCEPT));
			requestInLoanRequest.setOperation('S');

			serviceRequest.addValue("inLoanRequest", requestInLoanRequest);

			ServiceResponse response = this.execute(logger,
					Parameter.PROCESS_CHANGEOTHERCHARGESITEMS, serviceRequest);
			Integer mode = args.getParameters().getMode().getMode();			
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {
					OtherChargesItems[] clResponseList = (OtherChargesItems[]) resultado
							.getValue("returnOtherChargesItems");

					for (OtherChargesItems r : clResponseList) {

						otherCharges.set(OtherCharges.CATEGORYTYPE,
								r.getCategoryType());
						otherCharges.set(OtherCharges.VALUEAPPLY,
								r.getReferential());
						if (mode.equals(1)) {
							otherCharges.set(OtherCharges.VALUE,
									r.getDefaultValue());	
						}
						
						otherCharges.set(OtherCharges.VALUEMAX,
								r.getMaximumValue());
						otherCharges.set(OtherCharges.VALUEMIN,
								r.getMinimumValue());
						otherCharges.set(OtherCharges.REFERENCE,
								r.getReference());
						otherCharges.set(OtherCharges.BALANCEOP,
								r.getBalanceOp());
						otherCharges.set(OtherCharges.BALANCEDESEMP,
								r.getBalanceDesem());
						otherCharges.set(OtherCharges.RATE, r.getRate());
						otherCharges.set(OtherCharges.DECTAPL, r.getDecTapl());
						otherCharges.set(OtherCharges.BASECALCULATION,
								new BigDecimal(0));
						otherCharges.set(OtherCharges.RANGE, r
								.getMinimumValue().toString()
								+ " - "
								+ r.getMaximumValue().toString());
					}
				}
			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);

				args.getMessageManager().showErrorMsg(mensaje);

				otherCharges.set(OtherCharges.CATEGORYTYPE, null);
				otherCharges.set(OtherCharges.VALUEAPPLY, null);
				otherCharges.set(OtherCharges.VALUE, null);
				otherCharges.set(OtherCharges.VALUEMAX, null);
				otherCharges.set(OtherCharges.VALUEMIN, null);
				otherCharges.set(OtherCharges.REFERENCE, null);
				otherCharges.set(OtherCharges.BALANCEOP, null);
				otherCharges.set(OtherCharges.BALANCEDESEMP, null);
				otherCharges.set(OtherCharges.RATE, null);
				otherCharges.set(OtherCharges.DECTAPL, null);
				otherCharges.set(OtherCharges.BASECALCULATION, null);
				otherCharges.set(OtherCharges.RANGE, null);
			}			
		} catch (Exception exception) {
			manageException(exception, logger);
		}
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		changeOtherCharges(entities, args);

	}
}
