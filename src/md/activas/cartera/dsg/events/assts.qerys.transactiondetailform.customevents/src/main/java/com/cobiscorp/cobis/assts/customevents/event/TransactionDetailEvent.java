package com.cobiscorp.cobis.assts.customevents.event;

import java.math.BigDecimal;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.TransactionDetail;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class TransactionDetailEvent extends BaseEvent implements IExecuteQuery {
	
	private static final ILogger logger = LogFactory
			.getLogger(TransactionDetailEvent.class);
	
  public TransactionDetailEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs args) {
		OperationDataRequest operationDataRequest = new OperationDataRequest();
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList transactionDetailList = new DataEntityList();
		String trxType;
		Integer idTrx;
		String loanBankID;
		logger.logDebug("SMO ingresa a executeDataEvent");
		
		if (args.getParameters().getCustomParameters().get("idTrx") != null
				&&args.getParameters().getCustomParameters().get("trxType") != null
				&& args.getParameters().getCustomParameters().get("loanBankID") != null) {

			logger.logDebug("SMO PARAMS");
			idTrx = Integer.parseInt(args.getParameters()
					.getCustomParameters().get("idTrx").toString());
			loanBankID = args.getParameters().getCustomParameters()
					.get("loanBankID").toString();
			trxType =args.getParameters()
					.getCustomParameters().get("trxType").toString();
			
			operationDataRequest.setBank(loanBankID);
			operationDataRequest.setInsertSecuential(idTrx);
			operationDataRequest.setTrxType(trxType);
		
			request.addValue("inOperationDataRequest", operationDataRequest);

				try {
					ServiceResponse response = this.execute(logger,
							Parameter.PROCESS_TRANSACTION_DETAIL_QUERY, request);

					if (response != null && response.isResult()) {
						ServiceResponseTO resultado = (ServiceResponseTO) response
								.getData();

						TransactionDetail[] transactionDetList = (TransactionDetail[]) resultado
								.getValue("returnTransactionDetail");

						if (transactionDetList != null
								&& transactionDetList.length > 0) {
							for (TransactionDetail transactionDetail : transactionDetList) {
								transactionDetailList
										.add(loadDataEntity(transactionDetail));
							}
						}
					
					} else {
						GeneralFunction.handleResponse(args, response, null);
					}
				} catch (Exception e) {
					logger.logDebug("PaymentDetail.executeQueryEvent(..) -> Exception = "
							+ e);
				}
			

		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("PaymentDetail.executeQueryEvent -> parameters = null");
			}
			GeneralFunction.handleResponse(args, null, null);
		}
		return transactionDetailList.getDataList();
	}
	

	private DataEntity loadDataEntity(
			TransactionDetail transactionDetail) {
		DataEntity item = new DataEntity();
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.TRANSACTIONCONCEPT, transactionDetail.getConcept());
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.AMOUNT,new BigDecimal(transactionDetail.getAmount()));
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.TRANSACTIONFEE, transactionDetail.getFee());
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.TRANSACTIONSTATUS, transactionDetail.getStatus());
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.VALUECODE, transactionDetail.getValueCode());
		item.set(com.cobiscorp.cobis.assts.model.TransactionDetail.SEQUENCE, transactionDetail.getSequence());

		
		return item;
	}
}
