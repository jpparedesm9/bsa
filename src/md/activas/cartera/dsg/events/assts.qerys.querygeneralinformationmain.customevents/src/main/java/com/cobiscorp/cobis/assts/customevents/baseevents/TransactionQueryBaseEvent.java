package com.cobiscorp.cobis.assts.customevents.baseevents;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.assts.model.Transaction;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationTransaction;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class TransactionQueryBaseEvent extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(TransactionQueryBaseEvent.class);
	private Integer sequential = 0;

	public TransactionQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList loadTransactionsList(DynamicRequest entities) {
		Integer rowsNumber = 0;

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList transactionList = entities.getEntityList(Transaction.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		try {

			OperationDataRequest operationDataRequest = new OperationDataRequest();
			operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
			// OBTENER EL BANCO
			operationDataRequest.setBank(loan.get(Loan.LOANBANKID));

			do {

				operationDataRequest.setInsertSecuential(sequential);

				request.addValue("inOperationDataRequest", operationDataRequest);
				
				LOGGER.logDebug("SMO SECUENCIAL TRANSACCIONES "+operationDataRequest.getInsertSecuential());
				
				ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
						Parameter.PROCESS_TRANSACTION_QUERY, request);

				if (!(response.isResult())) {
					return null;
				}
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				OperationTransaction[] operationTransactionList = (OperationTransaction[]) resultado
						.getValue("returnOperationTransaction");
				if (operationTransactionList != null) {
					rowsNumber = operationTransactionList.length;
					
					DataEntity item = null;
					for (OperationTransaction operationTransaction : operationTransactionList) {
						item = loadTransaction(operationTransaction);
						transactionList.add(item);
					}
					if (item != null)
						sequential = item.get(Transaction.SEQUENTIAL);
				}
				
			} while (rowsNumber == Parameter.REGISTERS_FOR_PAGE);
			
			entities.setEntityList(Transaction.ENTITY_NAME, transactionList);
			
			LOGGER.logDebug("LISTA DE TRANSACCIONES "+transactionList.size());
		} catch (Exception e) {
			LOGGER.logError(e);
			this.manageException(e, LOGGER);
		}
		return transactionList;
	}

	private DataEntity loadTransaction(OperationTransaction operationTransaction) {
		DataEntity item = new DataEntity();
		item.set(Transaction.TRANSACTIONTYPE, operationTransaction.getTransactionType());
		item.set(Transaction.TRANSACTIONID, operationTransaction.getTransactionId());
		item.set(Transaction.REGISTERDATE, operationTransaction.getRegisterDate());
		item.set(Transaction.VALUEDATE, operationTransaction.getValueDate());
		item.set(Transaction.OFFICENAME, operationTransaction.getOfficeName());
		item.set(Transaction.AMMOUNT, operationTransaction.getAmount());
		item.set(Transaction.CURRENCY, operationTransaction.getCurrency());
		item.set(Transaction.CORRESPONSALID, operationTransaction.getCorresponsalId());
		item.set(Transaction.PAYMENTWAY, operationTransaction.getPaymentWay());
		item.set(Transaction.TRANSACTIONSTATUS, operationTransaction.getTransactionStatus());
		item.set(Transaction.USER, operationTransaction.getUser());
		item.set(Transaction.SEQUENTIAL, operationTransaction.getSequential());

		return item;
	}
}
