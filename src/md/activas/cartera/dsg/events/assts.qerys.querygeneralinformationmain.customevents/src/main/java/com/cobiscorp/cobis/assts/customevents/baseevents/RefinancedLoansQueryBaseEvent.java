package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationRefinanceLoan;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class RefinancedLoansQueryBaseEvent extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(RefinancedLoansQueryBaseEvent.class);

	public RefinancedLoansQueryBaseEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public DataEntityList loadRefinancedLoansList(DynamicRequest entities) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia LoadRefinancedLoansList");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList refinancedLoanList = entities
				.getEntityList(RefinanceLoans.ENTITY_NAME);

		OperationDataRequest operationDataRequest = new OperationDataRequest();
		operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		operationDataRequest.setOperation(Parameter.REFINANCED_LOAN_OPERATION);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		operationDataRequest.setBank(loan.get(Loan.LOANBANKID));

		OperationRefinanceLoan[] operationRefinancedLoanList = null;

		request.addValue("inOperationDataRequest", operationDataRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESS_SEARCHREFINANCELOAN, request);

		try {

			if (response.isResult()) {

				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				operationRefinancedLoanList = (OperationRefinanceLoan[]) resultado
						.getValue("returnOperationRefinanceLoan");

				for (OperationRefinanceLoan r : operationRefinancedLoanList) {
					DataEntity item = new DataEntity();
					item.set(RefinanceLoans.TRANSACTIONID, r.getTransact());
					item.set(RefinanceLoans.LOAN, r.getRenewedOperation());
					item.set(RefinanceLoans.INITIALAMOUNT,
							r.getOriginalAccount());
					item.set(RefinanceLoans.TOTALTOREFINANCE,
							r.getBalanceRenewed());
					item.set(RefinanceLoans.LINE, r.getCreditType());
					item.set(RefinanceLoans.OFFICIALID, r.getOfficial());
					refinancedLoanList.add(item);
				}
			}

		} catch (Exception e) {
			logger.logError(e);
			this.manageException(e, logger);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza LoadRefinancedLoansList");
		}
		return refinancedLoanList;
	}
}
