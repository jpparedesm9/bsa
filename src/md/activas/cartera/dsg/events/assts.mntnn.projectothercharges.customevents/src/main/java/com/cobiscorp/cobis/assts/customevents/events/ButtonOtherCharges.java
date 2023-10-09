package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.OtherCharges;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ButtonOtherCharges extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory
			.getLogger(ButtonOtherCharges.class);

	public ButtonOtherCharges(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try {
			@SuppressWarnings("unchecked")
			HashMap<String, Object>  newMap = (HashMap<String, Object> ) args
					.getParameters().getCustomParameters().get("entity");
			DataEntity otherCharges = entities
					.getEntity(OtherCharges.ENTITY_NAME);

			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			LoanRequest requestInLoanRequest = new LoanRequest();
			requestInLoanRequest.setBank((String) newMap.get("loanBankID"));
			requestInLoanRequest.setTypeOperation((String) newMap.get("operationTypeID"));
			Integer moneyConv = (Integer) newMap.get("codCurrency");		
			requestInLoanRequest.setCurrency(moneyConv);
			requestInLoanRequest.setConcept(otherCharges
					.get(OtherCharges.CONCEPT));
			requestInLoanRequest.setSinceDividend(otherCharges
					.get(OtherCharges.INIDIV));
			requestInLoanRequest.setUntilDividend(otherCharges
					.get(OtherCharges.DIVUP));
			Integer mode = args.getParameters().getMode().getMode();
			if (mode.equals(1)) {
				requestInLoanRequest.setOperation('I');
				requestInLoanRequest.setAmountDs(otherCharges
						.get(OtherCharges.VALUE));
				requestInLoanRequest.setCalculationBased(otherCharges
						.get(OtherCharges.BASECALCULATION));
				requestInLoanRequest.setTcotizOp(otherCharges
						.get(OtherCharges.BALANCEOP));
				requestInLoanRequest.setTCotisDs(otherCharges
						.get(OtherCharges.BALANCEDESEMP));
				requestInLoanRequest.setRate(otherCharges
						.get(OtherCharges.RATE));
				requestInLoanRequest.setCategoryType(otherCharges
						.get(OtherCharges.CATEGORYTYPE));
				requestInLoanRequest.setObservation(otherCharges
						.get(OtherCharges.COMMENTARY));
				Integer decTapl = otherCharges.get(OtherCharges.DECTAPL);
				if (decTapl != null) {
					requestInLoanRequest.setCapitalPeriod(decTapl);

				}
			}
			if (mode.equals(2)) {
				requestInLoanRequest.setOperation('P');
				requestInLoanRequest.setSecuential(otherCharges
						.get(OtherCharges.SEQUENTIAL));
			}

		   serviceRequest.addValue("inLoanRequest", requestInLoanRequest);
			ServiceResponse response = this.execute(logger,
					Parameter.PROCESS_BUTTONOTHERCHARGES, serviceRequest);
			if (response.isResult()) {
				if (mode.equals(2)) {
					args.getMessageManager().showSuccessMsg(
							"ASSTS.MSG_ASSTS_SEDEBERZE_11967");

				}
			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);

				args.getMessageManager().showErrorMsg(mensaje);
			}

		} catch (Exception exception) {
			manageException(exception, logger);
		}

	}

}
