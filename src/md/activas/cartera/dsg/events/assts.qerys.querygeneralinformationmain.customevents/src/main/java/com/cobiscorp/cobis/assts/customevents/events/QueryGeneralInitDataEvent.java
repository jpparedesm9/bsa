package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.AmortizationTable;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.customevents.baseevents.GeneralInformationQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.LoanDebtorsQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.LoanItemsQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.LoanRatesQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.LoanWarrantyQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.OperationConditionsBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.PaymentQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.RefinancedLoansQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.TransactionQueryBaseEvent;
import com.cobiscorp.cobis.assts.customevents.charts.ConsolidatedLoanAmortization;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QueryGeneralInitDataEvent extends BaseEvent implements
		IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(QueryGeneralInitDataEvent.class);

	public QueryGeneralInitDataEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs eventArgs) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeDataEvent");
		}

		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
		
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

		try {

			this.setGeneralInformation(entities, eventArgs);

			PaymentQueryBaseEvent paymentQueryBaseEvent = new PaymentQueryBaseEvent(
					getServiceIntegration());
			DataEntityList payments = paymentQueryBaseEvent
					.loadPaymentList(entities);
			if (!(payments.isEmpty())) {
				eventArgs.setSuccess(true);
			}
			
			TransactionQueryBaseEvent transactionQueryBaseEvent = new TransactionQueryBaseEvent(
					getServiceIntegration());
			DataEntityList transations = transactionQueryBaseEvent
					.loadTransactionsList(entities);
			if (!(transations.isEmpty())) {
				eventArgs.setSuccess(true);
			}

			RefinancedLoansQueryBaseEvent refinancedLoansQueryBaseEvent = new RefinancedLoansQueryBaseEvent(
					getServiceIntegration());
			DataEntityList refinancedLoans = refinancedLoansQueryBaseEvent
					.loadRefinancedLoansList(entities);
			if (!(refinancedLoans.isEmpty())) {
				eventArgs.setSuccess(true);
			}

			LoanItemsQueryBaseEvent loanItemsQueryBaseEvent = new LoanItemsQueryBaseEvent(
					getServiceIntegration());
			DataEntityList itemsLoanList = loanItemsQueryBaseEvent
					.loadLoanItemsList(entities);
			if (!itemsLoanList.isEmpty()) {
				eventArgs.setSuccess(true);
			}

			LoanRatesQueryBaseEvent loanRatesQueryBaseEvent = new LoanRatesQueryBaseEvent(
					getServiceIntegration());
			DataEntityList ratesLoanList = loanRatesQueryBaseEvent
					.loadLoanRatesList(entities);
			if (!ratesLoanList.isEmpty()) {
				eventArgs.setSuccess(true);
			}

			this.setWarrantyDebtors(entities, eventArgs);

		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Exception --> " + e);
			}
			this.manageException(e, logger);
		}
	}

	private void setGeneralInformation(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		AmortizationTable amortizacion = new AmortizationTable(
				this.getServiceIntegration());
		amortizacion.amortizationQuery(entities);
		amortizacion.summaryAmortizationQuery(entities);

		ConsolidatedLoanAmortization consolidateChart = new ConsolidatedLoanAmortization(
				this.getServiceIntegration());
		consolidateChart.consolidateLoanStatus(entities);
		
		
		GeneralInformationQueryBaseEvent generalInformationQueryBaseEvent = new GeneralInformationQueryBaseEvent(
				getServiceIntegration());

		DataEntity generalInfo = generalInformationQueryBaseEvent
				.generalInformation(entities);
		if (generalInfo != null) {
			eventArgs.setSuccess(true);
		}

		OperationConditionsBaseEvent operationPaymentConditions = new OperationConditionsBaseEvent(
				getServiceIntegration());
		DataEntity operationPayment = operationPaymentConditions
				.generalInformationConditions(entities);
		if (operationPayment != null) {
			eventArgs.setSuccess(true);
		}
	}

	private void setWarrantyDebtors(DynamicRequest entities,
			IDataEventArgs eventArgs) {

		LoanWarrantyQueryBaseEvent loanWarrantyQueryBaseEvent = new LoanWarrantyQueryBaseEvent(
				getServiceIntegration());
		DataEntityList loanWarrantyList = loanWarrantyQueryBaseEvent
				.loadWarrantyList(entities);
		if (!loanWarrantyList.isEmpty()) {
			eventArgs.setSuccess(true);
		}

		LoanDebtorsQueryBaseEvent loanDebtorsQueryBaseEvent = new LoanDebtorsQueryBaseEvent(
				getServiceIntegration());
		DataEntityList loanDebtorList = loanDebtorsQueryBaseEvent
				.loadDebtorsList(entities);
		if (!loanDebtorList.isEmpty()) {
			eventArgs.setSuccess(true);
		}
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			StringBuilder messagesString = new StringBuilder();
			for (Message message : messages) {
				messagesString.append(message.getMessage());
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString.toString();
		}
		return null;
	}
}
