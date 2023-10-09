package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationRate;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanRates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanRatesQueryBaseEvent extends BaseEvent {

	public LoanRatesQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger Logger = LogFactory
			.getLogger(LoanRatesQueryBaseEvent.class);

	public DataEntityList loadLoanRatesList(DynamicRequest entities) {

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Inicia LoadLoanRatesList");
		}

		ServiceRequestTO request = new ServiceRequestTO();

		DataEntityList loanRatesList = entities
				.getEntityList(LoanRates.ENTITY_NAME);

		OperationDataRequest operationDataRequest = new OperationDataRequest();
		operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		operationDataRequest.setOperation(Parameter.LIST_RATES_LOAN_OPERATION);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		operationDataRequest.setBank(loan.get(Loan.LOANBANKID));
		
		int recordCount = 0;
		Integer sequential = 0;
		
		do {
			recordCount = 0;
			operationDataRequest.setNext(sequential);
			request.addValue("inOperationDataRequest", operationDataRequest);
			ServiceResponse response = this.execute(getServiceIntegration(),
					Logger, Parameter.PROCESS_QUERYRATE, request);
			try {
				if (response.isResult()) {

					ServiceResponseTO resultado = (ServiceResponseTO) response
							.getData();
					OperationRate[] operationRateList = (OperationRate[]) resultado
							.getValue("returnOperationRate");

					for (OperationRate r : operationRateList) {
						DataEntity item = new DataEntity();
						item.set(LoanRates.SEQUENTIAL, r.getSequential());
						item.set(LoanRates.UPDATEDON, r.getDateMod());
						item.set(LoanRates.QUOTA, r.getNoShare());
						item.set(LoanRates.ITEM, r.getEntry());
						item.set(LoanRates.VALUETOAPPLY, r.getValueApply());
						item.set(LoanRates.SIGNTOAPPLY, r.getSignApply());
						item.set(LoanRates.SPREADAPPLY, r.getSpreadApply());
						item.set(LoanRates.CURRENTRATE, r.getCurrentRate());
						item.set(LoanRates.ANUALEFFECTIVERATE,
								r.getAnualEffectiveRate());
						item.set(LoanRates.REFERENTIALRATE,
								r.getReferentialRate());
						item.set(LoanRates.DATEREFERENCERATE,
								r.getDateReferenceRate());
						item.set(LoanRates.VALUEREFERENCERATE,
								r.getValueReferenceRate());
						loanRatesList.add(item);
						sequential = r.getSequential();
						recordCount = recordCount + 1;
					}
				}

			} catch (Exception e) {
				Logger.logError(e);
				this.manageException(e, Logger);
			}
		} while (recordCount == Parameter.REGISTERS_FOR_PAGE);

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Finaliza LoadLoanRatesList");
		}
		return loanRatesList;
	}
}
