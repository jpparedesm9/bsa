package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationDebtor;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanDebtor;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanDebtorsQueryBaseEvent extends BaseEvent {

	private static final ILogger Logger = LogFactory
			.getLogger(LoanDebtorsQueryBaseEvent.class);

	public LoanDebtorsQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList loadDebtorsList(DynamicRequest entities) {

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Inicia LoadDebtorsList");
		}

		ServiceRequestTO request = new ServiceRequestTO();

		DataEntityList loanDebtorList = entities
				.getEntityList(LoanDebtor.ENTITY_NAME);

		OperationDataRequest operationDataRequest = new OperationDataRequest();
		operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		operationDataRequest
				.setOperation(Parameter.LIST_DEBTORS_LOAN_OPERATION);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		operationDataRequest.setBank(loan.get(Loan.LOANBANKID));

		request.addValue("inOperationDataRequest", operationDataRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				Logger, Parameter.PROCESS_QUERYDEBTOR, request);

		try {

			if (response.isResult()) {

				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				OperationDebtor[] operationDebtorList = (OperationDebtor[]) resultado
						.getValue("returnOperationDebtor");

				for (OperationDebtor r : operationDebtorList) {
					DataEntity item = new DataEntity();
					item.set(LoanDebtor.CUSTOMERID, r.getCode());
					item.set(LoanDebtor.IDENTITYCARD, r.getCeNit());
					item.set(LoanDebtor.ROLE, r.getRole());
					item.set(LoanDebtor.CUSTOMERNAME, r.getName());
					item.set(LoanDebtor.PHONE, r.getPhone());
					item.set(LoanDebtor.ADDRESS, r.getDirection());
					item.set(LoanDebtor.CENTRALCOLLECTION, r.getCobCentral());
					loanDebtorList.add(item);
				}
			}
		} catch (Exception e) {
			Logger.logError(e);
			this.manageException(e, Logger);
		}

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Finaliza LoadDebtorsList");
		}
		return loanDebtorList;
	}
}
