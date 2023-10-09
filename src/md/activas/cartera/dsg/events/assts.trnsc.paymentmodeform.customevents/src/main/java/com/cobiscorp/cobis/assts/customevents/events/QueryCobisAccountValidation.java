package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadAccountRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadAccountResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.UtilDisbursement;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QueryCobisAccountValidation extends BaseEvent implements
		IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(QueryCobisAccountValidation.class);

	public QueryCobisAccountValidation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		DataEntity paymentForm = null;
		DataEntity loanInf = null;
		String paymentFormCategory;

		if (entities.getEntity(PaymentForm.ENTITY_NAME) != null) {
			paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);
		}
		if (entities.getEntity(Loan.ENTITY_NAME) != null) {
			loanInf = entities.getEntity(Loan.ENTITY_NAME);
		}

		if (paymentForm != null
				&& paymentForm.get(PaymentForm.PAYFORMID) != null) {
			UtilDisbursement utils = new UtilDisbursement(
					this.getServiceIntegration());
			paymentFormCategory = utils.getPaymentFormCategory(paymentForm, loanInf);
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ QueryCobisAccountValidation.changed :: paymentFormCategory= "
						+ paymentFormCategory);
			}
			if (paymentFormCategory != null) {
				if (utils.useLoop(Parameter.getProductValidTypeA(), paymentFormCategory)) {
					executeValidationAccount(paymentForm, loanInf, entities,
							args);
				} else if (utils.useLoop(Parameter.getProductValidTypeB(), paymentFormCategory)) {
					executeValidationOtherBanks(paymentForm, entities, args);
				}
			}
		}
	}

	private void executeValidationOtherBanks(DataEntity paymentForm,
			DynamicRequest entities, IChangedEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		ServiceResponseTO responseTo = null;
		LoanResponse[] loanResponse = null;
		LoanRequest loanRequest = new LoanRequest();
		if (paymentForm != null
				&& paymentForm.get(PaymentForm.OFFICEID) != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ QueryCobisAccountValidation.executeValidationOtherBanks :: paymentForm= "
						+ paymentForm.getData());
			}
			loanRequest
					.setOperation((Character) Parameter.OPERATIONC.charAt(0));
			loanRequest
					.setCategoryType((Character) Parameter.PARAMETER_DISBURSEMENT_S);
			loanRequest.setOfficeChg(paymentForm.get(PaymentForm.OFFICEID));
			loanRequest.setOperationCode(Parameter.ZERO_VALUE);
			request.addValue("inLoanRequest", loanRequest);
			response = execute(getServiceIntegration(), logger,
					Parameter.VALIDATE_ACC_OTHER_BANKS, request);
		}

		if ((response != null) && (response.isResult())) {
			responseTo = (ServiceResponseTO) response.getData();

		}
		if (responseTo != null) {
			loanResponse = (LoanResponse[]) responseTo
					.getValue("returnLoanResponse");
		}
		if (loanResponse != null
				&& !validateAccountOtherBank(loanResponse, paymentForm)) {
			paymentForm.set(PaymentForm.ACCOUNTNUMBER, "");
			entities.setEntity(PaymentForm.ENTITY_NAME, paymentForm);
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_NOEXISTAC_35699");
		}

	}

	private boolean validateAccountOtherBank(LoanResponse[] loanResponses,
			DataEntity paymentForm) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountOtherBank(..) :: Entro");
		}
		String accountNumber = null;

		for (LoanResponse loanResponse : loanResponses) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountOtherBank(..) :: Number="
						+ loanResponse.getAccount());
			}
			if (paymentForm != null
					&& paymentForm.get(PaymentForm.ACCOUNTNUMBER) != null) {
				accountNumber = paymentForm.get(PaymentForm.ACCOUNTNUMBER);
				logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountOtherBank(..) :: accountNumber="
						+ accountNumber);
			}
			if (accountNumber != null
					&& loanResponse.getAccount().equals(accountNumber)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountOtherBank(..) :: true");
				}
				return true;
			}
		}
		return false;
	}

	private void executeValidationAccount(DataEntity paymentForm,
			DataEntity loanInf, DynamicRequest entities, IChangedEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;
		ServiceResponseTO responseTo = null;
		ReadAccountResponse[] returnReadAccountResponse = null;
		if (paymentForm != null
				&& paymentForm.get(PaymentForm.PAYFORMID) != null
				&& paymentForm.get(PaymentForm.CLIENTID) != null
				&& paymentForm.get(PaymentForm.ACCOUNTNUMBER) != null) {
			if (loanInf != null && loanInf.get(Loan.LOANBANKID) != null) {

				ReadAccountRequest readAccountRequest = new ReadAccountRequest();
				readAccountRequest.setOperation(Parameter.OPERATIONH);
				readAccountRequest.setCustomerId(paymentForm
						.get(PaymentForm.CLIENTID));
				readAccountRequest.setProduct(paymentForm
						.get(PaymentForm.PAYFORMID));
				readAccountRequest.setAccountNumber(loanInf
						.get(Loan.LOANBANKID));
				readAccountRequest.setPaymentForm(paymentForm
						.get(PaymentForm.PAYFORMID));

				request.addValue("inReadAccountRequest", readAccountRequest);
				response = execute(getServiceIntegration(), logger,
						Parameter.QUERY_COBIS_ACCOUNTS, request);
				if ((response != null) && (response.isResult())) {
					responseTo = (ServiceResponseTO) response.getData();
				}
				if (responseTo != null) {
					returnReadAccountResponse = (ReadAccountResponse[]) responseTo
							.getValue("returnReadAccountResponse");
				}
				if (returnReadAccountResponse != null
						&& !validateAccountNumber(returnReadAccountResponse,
								paymentForm.get(PaymentForm.ACCOUNTNUMBER))) {
					paymentForm.set(PaymentForm.ACCOUNTNUMBER, Parameter.EMPTY);
					entities.setEntity(PaymentForm.ENTITY_NAME, paymentForm);
					args.getMessageManager().showErrorMsg(
							"ASSTS.MSG_ASSTS_CUENTANRA_30104");
				}
			}
		}
	}

	private boolean validateAccountNumber(
			ReadAccountResponse[] returnReadAccountResponse,
			String accountNumber) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountNumber(..) :: Entro");
		}
		for (ReadAccountResponse readAccountResponse : returnReadAccountResponse) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountNumber(..) :: AccountNumber="
						+ readAccountResponse.getAccountNumber());
				logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountNumber(..) :: accountNumber="
						+ accountNumber);
			}
			if (readAccountResponse.getAccountNumber().trim()
					.equals(accountNumber.trim())) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("WATQ QueryCobisAccountValidation.validateAccountNumber(..) :: true");
				}
				return true;
			}
		}
		return false;
	}
}
