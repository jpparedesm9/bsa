package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationWarranty;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanWarranty;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanWarrantyQueryBaseEvent extends BaseEvent {

	private static final ILogger Logger = LogFactory
			.getLogger(LoanWarrantyQueryBaseEvent.class);
	
	public LoanWarrantyQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public DataEntityList loadWarrantyList(DynamicRequest entities) {

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Inicia LoadWarrantyList new method");
		}

		ServiceRequestTO request = new ServiceRequestTO();

		DataEntityList loanWarrantyList = entities
				.getEntityList(LoanWarranty.ENTITY_NAME);

		OperationDataRequest operationDataRequest = new OperationDataRequest();
		operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		operationDataRequest.setOperation(Parameter.LIST_WARRANTIES_LOAN_OPERATION);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		operationDataRequest.setBank(loan.get(Loan.LOANBANKID));
		operationDataRequest.setOperationType(loan.get(Loan.OPERATIONTYPEID));

		OperationWarranty[] operationWarrantyList = null;

		request.addValue("inOperationDataRequest", operationDataRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), Logger,
				Parameter.PROCESS_QUERYWARRANTY, request);
		try {
			if (response.isResult()) {

				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				operationWarrantyList = (OperationWarranty[]) resultado
						.getValue("returnOperationWarranty");

				for (OperationWarranty r : operationWarrantyList) {
					DataEntity item = new DataEntity();
					item.set(LoanWarranty.WARRANTY, r.getWarranty());
					item.set(LoanWarranty.STATUSWARRANTY, r.getStateGar());
					item.set(LoanWarranty.DESCRIPTION, r.getDescription());
					item.set(LoanWarranty.CUSTOMERID, r.getCodClient());
					item.set(LoanWarranty.CUSTOMER, r.getNameClient());
					item.set(LoanWarranty.CURRENTVALUE, r.getCurrentValue());
					item.set(LoanWarranty.CURRENCYID, r.getCurrency());
					item.set(LoanWarranty.CREATEDON, r.getInsertDate());
					loanWarrantyList.add(item);
				}
			}
		} catch (Exception e) {
			Logger.logError(e);
			this.manageException(e, Logger);
		}

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Finaliza LoadWarrantyList");
		}
		return loanWarrantyList;
	}
}
