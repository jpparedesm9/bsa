package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationEntry;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanEntry;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanItemsQueryBaseEvent extends BaseEvent {

	private static final ILogger Logger = LogFactory
			.getLogger(LoanItemsQueryBaseEvent.class);

	public LoanItemsQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList loadLoanItemsList(DynamicRequest entities) {

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Inicia LoadLoanItemssList new method");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList loanItemsList = entities
				.getEntityList(LoanEntry.ENTITY_NAME);

		OperationDataRequest operationDataRequest = new OperationDataRequest();
		operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		operationDataRequest.setOperation(Parameter.LIST_ITEMS_LOAN_OPERATION);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		operationDataRequest.setBank(loan.get(Loan.LOANBANKID));

		OperationEntry[] operationEntryList = null;

		request.addValue("inOperationDataRequest", operationDataRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				Logger, Parameter.PROCESS_QUERYENTRY, request);
		try {
			if (response.isResult()) {

				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				operationEntryList = (OperationEntry[]) resultado
						.getValue("returnOperationEntry");

				for (OperationEntry r : operationEntryList) {
					DataEntity item = new DataEntity();
					item.set(LoanEntry.CONCEPT, r.getEntry());
					item.set(LoanEntry.DESCRIPTION, r.getDescription());
					item.set(LoanEntry.ITEMTYPE, r.getEntryType());
					item.set(LoanEntry.PAYMENTMETHOD, r.getWayToPay());
					item.set(LoanEntry.VALUE, r.getValue());
					item.set(LoanEntry.PRIORITY, r.getPriority());
					item.set(LoanEntry.LATEPAYMENT, r.getLatePayment());
					item.set(LoanEntry.CAUSE, r.getCause());
					item.set(LoanEntry.REFERENCE, r.getReference());
					item.set(LoanEntry.SIGN, r.getSign());
					item.set(LoanEntry.POINTSVALUE, r.getPointsValue());
					item.set(LoanEntry.POINTSTYPE, r.getPointsType());
					item.set(LoanEntry.VALUETOTALRATE, r.getValueTotalTape());
					item.set(LoanEntry.NEGOTIATEDRATE, r.getNegotiatedRate());
					item.set(LoanEntry.ANNUALEFECRATE, r.getAnnualEfecRate());
					item.set(LoanEntry.REAJUSTMENSIGN, r.getSignReaj());
					item.set(LoanEntry.REAJUSTMENTVALUEPOINTS,
							r.getValuePointsReaj());
					item.set(LoanEntry.REAJUSTMENTREFERENCE,
							r.getReferenceReaj());
					item.set(LoanEntry.GAIN, r.getGain());
					item.set(LoanEntry.BASECALCULATION, r.getBaseCalculation());
					item.set(LoanEntry.CHARGEFORRINGING,
							r.getChargeForRinging());
					item.set(LoanEntry.WARRANTYTYPE, r.getWarrantyType());
					item.set(LoanEntry.WARRANTYNUMBER, r.getNroWarranty());
					item.set(LoanEntry.COVERAGEPERCENTAGE,
							r.getPorcCoverageGar());
					item.set(LoanEntry.WARRANTYVALUE, r.getWarrantyValue());
					item.set(LoanEntry.DIVIDENDTYPE, r.getDividendType());
					item.set(LoanEntry.INTERESTPERIOD, r.getNoPeriodsInt());
					item.set(LoanEntry.TABLEOTHERRATE, r.getTableOtherRate());
					loanItemsList.add(item);
				}
			}
		} catch (Exception e) {
			Logger.logError(e);
			this.manageException(e, Logger);
		}

		if (Logger.isDebugEnabled()) {
			Logger.logDebug("Finaliza LoadLoanItemssList");
		}
		return loanItemsList;
	}
}
