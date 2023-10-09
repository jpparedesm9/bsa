package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.LoanHeaderInfoResponse;
import cobiscorp.ecobis.assets.cloud.dto.TrnDetailRequest;
import cobiscorp.ecobis.assets.cloud.dto.TrnDetailResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.TransactionLoan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class TransactionBaseEvent extends BaseEvent {

	public TransactionBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(TransactionBaseEvent.class);

	public DataEntityList loadTransactionList(DynamicRequest entities, char opcion) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia loadTransactionList");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;

		int lenghtTrnDetailResponseArray = 0;

		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntityList transactionLoan = entities
				.getEntityList(TransactionLoan.ENTITY_NAME);
		transactionLoan.clear();

		TrnDetailResponse[] trnDetailResponseArray = null;
		LoanHeaderInfoResponse[] loanHeaderInfoResponse = null;
		Integer sequential = 0;
		do {
			request.addValue("inTrnDetailRequest",
					loadTrnDetailRequest(loan, opcion, sequential));
			response = this.execute(getServiceIntegration(), logger,
					Parameter.PROCESS_LOAN_TRANSACTION_SEARCH, request);

			try {
				if (response.isResult()) {
					ServiceResponseTO resultado = (ServiceResponseTO) response
							.getData();
					trnDetailResponseArray = (TrnDetailResponse[]) resultado
							.getValue("returnTrnDetailResponse");

					if (logger.isDebugEnabled()) {
						logger.logDebug("Response --> " + resultado.toString());
					}

					if (sequential == 0) {
						loanHeaderInfoResponse = (LoanHeaderInfoResponse[]) resultado
								.getValue("returnLoanHeaderInfoResponse");
					}

					for (TrnDetailResponse trnDetailResponse : trnDetailResponseArray) {
						sequential = trnDetailResponse.getSequential();
						transactionLoan
								.add(loadItemTransactionLoan(trnDetailResponse));
					}
					if (logger.isDebugEnabled()) {
						logger.logDebug("==> Secuencial: " + sequential);
					}
				}
			} catch (Exception e) {
				this.manageException(e, logger);
			}

			if (trnDetailResponseArray != null) {
				lenghtTrnDetailResponseArray = trnDetailResponseArray.length;
			} else {
				lenghtTrnDetailResponseArray = 0;
			}

		} while (lenghtTrnDetailResponseArray == Parameter.REGISTERS_FOR_PAGE);

		if (loanHeaderInfoResponse != null && loanHeaderInfoResponse.length > 0) {
			loan.set(Loan.LASTPROCESSDATE,
					loanHeaderInfoResponse[0].getLastProcessDate());
			loan.set(Loan.STATUS, loanHeaderInfoResponse[0].getStatus());
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza loadTransactionList");
		}
		return transactionLoan;
	}

	private TrnDetailRequest loadTrnDetailRequest(DataEntity loan, char opcion,
			Integer sequential) {
		TrnDetailRequest trnDetailRequest = new TrnDetailRequest();
		trnDetailRequest.setBank(loan.get(Loan.LOANBANKID));
		trnDetailRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		trnDetailRequest.setOperation('S');
		trnDetailRequest.setType(opcion);
		trnDetailRequest.setGroup(opcion);
		trnDetailRequest.setSequential(sequential);
		return trnDetailRequest;
	}

	private DataEntity loadItemTransactionLoan(
			TrnDetailResponse trnDetailResponse) {
		DataEntity itemTransactionLoan = new DataEntity();
		itemTransactionLoan.set(TransactionLoan.TRANSACTIONID,
				trnDetailResponse.getTransaction());
		itemTransactionLoan.set(TransactionLoan.SECUENTIAL,
				trnDetailResponse.getSequential());
		itemTransactionLoan.set(TransactionLoan.OPERATION,
				trnDetailResponse.getOperation());
		itemTransactionLoan.set(TransactionLoan.DATETRAN,
				trnDetailResponse.getRefDate());
		itemTransactionLoan.set(TransactionLoan.DATEREF,
				trnDetailResponse.getRefDate());
		itemTransactionLoan.set(TransactionLoan.USER,
				trnDetailResponse.getUser());
		itemTransactionLoan.set(TransactionLoan.STATUS,
				trnDetailResponse.getStatus());
		return itemTransactionLoan;
	}
}
