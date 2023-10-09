package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.OperationCurrentState;
import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.AmortizationQuoteDetail;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class AmortizationQuoteDetailLoan extends BaseEvent implements
		IExecuteQuery {
	private static final ILogger logger = LogFactory
			.getLogger(AmortizationQuoteDetailLoan.class);

	public AmortizationQuoteDetailLoan(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			IExecuteQueryEventArgs arg1) {
		OperationDataRequest operationDataRequest = new OperationDataRequest();
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList quoteDetailList = new DataEntityList();
		Integer dividend = null;
		String bankId = "";
		if (logger.isDebugEnabled()) {
			logger.logDebug("AmortizationQuoteDetailLoan.executeDataEvent(..) -> entro");
		}
		if (arg1.getParameters().getCustomParameters().get("dividend") != null
				&& arg1.getParameters().getCustomParameters().get("loanBankID") != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("AmortizationQuoteDetailLoan -> "
						+ arg1.getParameters().getCustomParameters()
								.get("loanBankID"));
			}
			dividend = Integer.parseInt(arg1.getParameters()
					.getCustomParameters().get("dividend").toString());
			bankId = arg1.getParameters().getCustomParameters()
					.get("loanBankID").toString();
			operationDataRequest.setOperation(Parameter.LOAN_QUOTE_DETAIL);
			operationDataRequest.setDividend(dividend);
			operationDataRequest.setBank(bankId);

			request.addValue("inOperationDataRequest", operationDataRequest);
			try {
				ServiceResponse response = this.execute(logger,
						Parameter.PROCESS_LOAN_QUOTE_DETAIL_QUERY, request);
				if (response != null && response.isResult()) {
					ServiceResponseTO responseTo = (ServiceResponseTO) response
							.getData();
					OperationCurrentState[] operationCurrentState = (OperationCurrentState[]) responseTo
							.getValue("returnOperationCurrentState");
					if (operationCurrentState != null
							&& operationCurrentState.length > 0) {
						for (OperationCurrentState loanCurrentStatus : operationCurrentState) {
							quoteDetailList.add(loadDataEntity(loanCurrentStatus));
						}
					}
				} else {
					GeneralFunction.handleResponse(arg1, response, null);
				}
			} catch (Exception e) {
				logger.logDebug("AmortizationQuoteDetailLoan.executeDataEvent(..) -> Exception = "
						+ e);
			}
		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("AmortizationQuoteDetailLoan.executeDataEvent(..) -> dividen = null");
			}
			GeneralFunction.handleResponse(arg1, null, null);
		}
		return quoteDetailList.getDataList();
	}

	private DataEntity loadDataEntity(OperationCurrentState loanCurrentStatus) {
		DataEntity item = new DataEntity();
		if (logger.isDebugEnabled()) {
			logger.logDebug("AmortizationQuoteDetailLoan.loadDataEntity(..) -> Rubro = "
					+ loanCurrentStatus.getEntry());
		}
		item.set(AmortizationQuoteDetail.ITEM, loanCurrentStatus.getEntry());
		item.set(AmortizationQuoteDetail.STATUSITEM,
				loanCurrentStatus.getState());
		item.set(AmortizationQuoteDetail.PERIOD, loanCurrentStatus.getPeriod());
		item.set(AmortizationQuoteDetail.QUOTE,
				BigDecimal.valueOf(loanCurrentStatus.getFee()));
		item.set(AmortizationQuoteDetail.GRACE,
				BigDecimal.valueOf(loanCurrentStatus.getGain()));
		item.set(AmortizationQuoteDetail.PAID,
				BigDecimal.valueOf(loanCurrentStatus.getPaid()));
		item.set(AmortizationQuoteDetail.ACCUMULATED,
				BigDecimal.valueOf(loanCurrentStatus.getAccumulated()));
		item.set(AmortizationQuoteDetail.SEQUENTIAL,
				loanCurrentStatus.getSequence());
		return item;
	}
}
