package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.HeaderLoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentFormRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.events.UtilFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanAdditionalInformation;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class AddDetailPaymentForm extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(AddDetailPaymentForm.class);

	public AddDetailPaymentForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		createPaymentFormToGridDetail(entities, args);
	}

	private DataEntity getQuotationCurrency(Integer currencyId, Double amount) {
		HeaderLoanResponse detailLoanResponseList = new HeaderLoanResponse();
		detailLoanResponseList.setCurrency(currencyId);
		detailLoanResponseList.setAmountOpt(amount);
		UtilFunction utilFunc = new UtilFunction(this.getServiceIntegration());
		return utilFunc.getQuotationCurrency(detailLoanResponseList);
	}

	private ServiceResponse createPaymentFormToGridDetail(
			DynamicRequest entities, IExecuteCommandEventArgs args) {
		PaymentFormRequest paymentFormRequest = null;
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = new ServiceResponse();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);
		if (logger.isDebugEnabled()) {
			logger.logDebug("AddDetailPaymentForm.createPaymentFormToGridDetail(..) --> Entro");
			logger.logDebug("AddDetailPaymentForm.createPaymentFormToGridDetail(..) --> paymentForm="
					+ paymentForm.getData());
		}
		DataEntity itemQuoteOp = null;
		DataEntity loanAddInf = entities
				.getEntity(LoanAdditionalInformation.ENTITY_NAME);

		DataEntity itemQuoteDs = getQuotationCurrency(
				paymentForm.get(PaymentForm.CURRENCYID),
				Double.valueOf(Parameter.ZERO_VALUE));
		itemQuoteOp = getQuotationCurrency(loan.get(Loan.CODCURRENCY),
				Double.valueOf(Parameter.ZERO_VALUE));
		paymentFormRequest = validateEntityInformation(paymentForm, loan,
				loanAddInf, itemQuoteOp, itemQuoteDs);
		
		if (paymentFormRequest != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("AddDetailPaymentForm.createPaymentFormToGridDetail(..) --> paymentFormRequest.AccountNumber"
						+ paymentFormRequest.getAccountNumber());
			}
			try {
				request.addValue("inPaymentFormRequest", paymentFormRequest);
				response = execute(getServiceIntegration(), logger,
						Parameter.INSERT_DETAIL_PAY_FORM, request);
				GeneralFunction.handleResponse(args, response, null);
			} catch (Exception e) {
				logger.logError("WATQ Error: " + e);
			}
		}
		return response;
	}

	private PaymentFormRequest validateEntityInformation(
			DataEntity paymentForm, DataEntity loan, DataEntity loanAddInf,
			DataEntity itemQuoteOp, DataEntity itemQuoteDs) {
		PaymentFormRequest paymentFormRequest = null;
		if (paymentForm != null
				&& paymentForm.get(PaymentForm.PAYFORMID) != null
				&& paymentForm.get(PaymentForm.ACCOUNTNUMBER) != null
				&& paymentForm.get(PaymentForm.CLIENTFULLNAME) != null
				&& paymentForm.get(PaymentForm.CLIENTID) != null
				&& paymentForm.get(PaymentForm.OFFICEID) != null
				&& loan.get(Loan.LOANBANKID) != null
				&& loanAddInf.get(LoanAdditionalInformation.DATETODISBURSE) != null
				&& paymentForm.get(PaymentForm.PAYAMOUNT) != null
				&& itemQuoteOp != null
				&& itemQuoteOp.get(LoanAdditionalInformation.QUOTATION) != null
				&& itemQuoteDs != null
				&& itemQuoteDs.get(LoanAdditionalInformation.QUOTATION) != null
				&& loan.get(Loan.CODCURRENCY) != null
				&& paymentForm.get(PaymentForm.CURRENCYID) != null) {
			logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> PaymentForm="
					+ paymentForm.getData());
			paymentFormRequest = new PaymentFormRequest();
			paymentFormRequest.setIsACH(Parameter.OPERATION_ACH.charAt(0));
			paymentFormRequest.setProductName(Parameter.MODULE_PRODUCT);
			paymentFormRequest.setProductId(paymentForm
					.get(PaymentForm.PAYFORMID));
			paymentFormRequest.setAccountNumber(paymentForm
					.get(PaymentForm.ACCOUNTNUMBER));
			paymentFormRequest.setBeneficiaryName(paymentForm
					.get(PaymentForm.CLIENTFULLNAME));
			paymentFormRequest.setBeneficiaryId(paymentForm
					.get(PaymentForm.CLIENTID));
			paymentFormRequest.setOfficeIdChg(paymentForm
					.get(PaymentForm.OFFICEID));
			paymentFormRequest.setRealBank(loan.get(Loan.LOANBANKID));
			paymentFormRequest.setFictitiouBank(loan.get(Loan.LOANBANKID));
			paymentFormRequest.setLiquidationDate(GeneralFunction
					.convertDateToCalendar(loanAddInf
							.get(LoanAdditionalInformation.DATETODISBURSE)));
			paymentFormRequest.setAmountDs(paymentForm
					.get(PaymentForm.PAYAMOUNT));
			paymentFormRequest.setQuoteTypeOp(Parameter.T_QUOTATION);
			paymentFormRequest.setQuoteDs(itemQuoteDs
					.get(LoanAdditionalInformation.QUOTATION));
			paymentFormRequest.setQuoteTypeDs(Parameter.T_QUOTATION);
			paymentFormRequest.setQuoteOp(itemQuoteOp
					.get(LoanAdditionalInformation.QUOTATION));
			paymentFormRequest.setCurrencyIdOp(loan.get(Loan.CODCURRENCY));
			paymentFormRequest.setCurrencyIdDs(paymentForm
					.get(PaymentForm.CURRENCYID));
			paymentFormRequest.setOperation(Parameter.OPERATIONI);
			paymentFormRequest
					.setAuthorizationLetter(Parameter.PARAMETER_DISBURSEMENT);
			paymentFormRequest.setFromCre(String
					.valueOf(Parameter.PARAMETER_DISBURSEMENT));
			paymentFormRequest.setCheckNumber(paymentForm
					.get(PaymentForm.CHECKNUMBER));
			paymentFormRequest.setBanckIdACH(Parameter.ZERO_VALUE);
			if (paymentForm.get(PaymentForm.RESTRICTIVECROSSING) == null) {
				paymentFormRequest.setRestrictiveCrossing(Parameter.PARAMETER_DISBURSEMENT);
			} else {
				paymentFormRequest
						.setRestrictiveCrossing(paymentForm
								.get(PaymentForm.RESTRICTIVECROSSING) == false ? Character
								.valueOf(Parameter.PARAMETER_DISBURSEMENT)
								: Character
										.valueOf(Parameter.PARAMETER_DISBURSEMENT_S));
			}
			logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> A");
			if (paymentForm.get(PaymentForm.ECONOMICDESTINATION) == null) {
				logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> B");
				paymentFormRequest.setEconomicDestination(Character.MIN_VALUE);
				logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> C");
			} else {
				logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> D");
				paymentFormRequest.setEconomicDestination(Character
						.valueOf(paymentForm.get(
								PaymentForm.ECONOMICDESTINATION).charAt(0)));
				logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> F");
			}
			logger.logDebug("AddDetailPaymentForm.validateEntityInformation(..) --> G");
			paymentFormRequest
					.setConcept(paymentForm.get(PaymentForm.CONCEPT) == null ? ""
							: paymentForm.get(PaymentForm.CONCEPT));
			paymentFormRequest.setRenewal(Parameter.PARAMETER_DISBURSEMENT);
		}

		return paymentFormRequest;
	}
}
