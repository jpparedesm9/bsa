package com.cobiscorp.cobis.busin.customevents.executeCommand;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanParameterRequest;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.GeneralParameterLoan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandVA_VWPAYMENLA2613_0000566 extends BaseEvent
		implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandVA_VWPAYMENLA2613_0000566.class);

	public ExecuteCommandVA_VWPAYMENLA2613_0000566(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso ExecuteCommandVA_VWPAYMENLA2613_0000566");
		try {
			DataEntity generalParameterLoan = entities
					.getEntity(GeneralParameterLoan.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);

			LoanParameterRequest loanParameterRequest = new LoanParameterRequest();

			loanParameterRequest.setReadjustable(generalParameterLoan
					.get(GeneralParameterLoan.EXCHANGERATE));
			loanParameterRequest.setReadjustmentPeriod(generalParameterLoan
					.get(GeneralParameterLoan.PERIODICITY));
			loanParameterRequest.setReadjustmentSpecial(String
					.valueOf(generalParameterLoan
							.get(GeneralParameterLoan.KEEPTERM)));
			if (generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL)
					.equals(Mnemonic.STRING_S)) {
				loanParameterRequest.setRenovation(Mnemonic.CHAR_S);
			} else {
				loanParameterRequest.setRenovation(Mnemonic.CHAR_N);
			}
			if (generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY)
					.equals(Mnemonic.STRING_S))
				loanParameterRequest.setPrecancellation(Mnemonic.CHAR_S);
			else
				loanParameterRequest.setPrecancellation(Mnemonic.CHAR_N);

			loanParameterRequest.setTypeApplication(generalParameterLoan
					.get(GeneralParameterLoan.PAYMENT));
			loanParameterRequest.setCompleteQuota(generalParameterLoan
					.get(GeneralParameterLoan.ONLYCOMPLETEFEEPAYMENTS));
			loanParameterRequest.setTypeRecovery(generalParameterLoan
					.get(GeneralParameterLoan.INTERESTPAYMENT));
			loanParameterRequest.setEffectPayment(generalParameterLoan
					.get(GeneralParameterLoan.PREPAYMENTTYPE).charAt(0));

			// Se mapea la Reducción de Tiempo o Reducción de Cuota Pactada
			loanParameterRequest.setTypeReduction(generalParameterLoan
					.get(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT));

			// se mapea el campo Se acepta pagos adicionales
			loanParameterRequest
					.setAcceptAnticipationsIndicated(generalParameterLoan
							.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS));

			if (Boolean.parseBoolean(generalParameterLoan
					.get(GeneralParameterLoan.APPLYONLYCAPITAL)) == true)
				loanParameterRequest.setTypePriority(Mnemonic.CHAR_S);
			else
				loanParameterRequest.setTypePriority(Mnemonic.CHAR_N);

			loanParameterRequest.setAccount(String.valueOf(paymentPlanHeader
					.get(PaymentPlanHeader.IDREQUESTED)));
			// loanParameterRequest.setAccount(String.valueOf(315));
			loanParameterRequest.setCalculePaymentsPlan(Mnemonic.CHAR_N);

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put("inLoanParameterRequest",
					loanParameterRequest);
			ServiceResponse serviceResponse = execute(getServiceIntegration(),
					LOGGER, ServiceId.SERVICEUPDATEGENERALPARAMETERSLOAN,
					serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Servicio Ejecutado Correctamente: "
							+ ServiceId.SERVICEUPDATEGENERALPARAMETERSLOAN);
				args.getMessageManager().showSuccessMsg(
						"BUSIN.DLB_BUSIN_IEJTAITMT_92625");
			} else {
				MessageManagement.show(serviceResponse, args,
						new BehaviorOption(false));
				args.setSuccess(false);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_EXECUTE_PARAMETERS, e, args, LOGGER);
		}

	}
}