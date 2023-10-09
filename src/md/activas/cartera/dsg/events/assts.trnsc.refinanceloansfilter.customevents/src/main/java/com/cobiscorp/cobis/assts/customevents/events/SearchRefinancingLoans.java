package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.RefinancingLoan;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchRefinancingLoans extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(SearchRefinancingLoans.class);
	
	public SearchRefinancingLoans(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		
		BigDecimal totalToRefinance = new BigDecimal(0);
		BigDecimal balanceCapital = new BigDecimal(0);		
		BigDecimal balanceOthers = new BigDecimal(0);
		DataEntity refinancingLoanFilter = entities.getEntity(RefinanceLoanFilter.ENTITY_NAME);

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setDateFormat(103);
		loanRequest.setOperation('Q');
		loanRequest.setClient(refinancingLoanFilter.get(RefinanceLoanFilter.CLIENTID));
		loanRequest.setCurrency(refinancingLoanFilter.get(RefinanceLoanFilter.CURRENCYTYPE));
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inLoanRequest", loanRequest);
		
		ServiceResponse serviceResponse = this.execute(logger, Parameter.SEARCH_REFINANCING_OPERATIOS, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				RefinancingLoan[] refinancingLoanList = (RefinancingLoan[]) serviceResponseTO.getValue("returnRefinancingLoan");

				DataEntityList entityList = new DataEntityList();
				for (RefinancingLoan r : refinancingLoanList) {
					DataEntity dataEntity = new DataEntity();
					dataEntity.set(RefinanceLoans.LINE, r.getOperationType());
					dataEntity.set(RefinanceLoans.LOAN, r.getLoanBankID());
					dataEntity.set(RefinanceLoans.INITIALAMOUNT, r.getAmount());
					dataEntity.set(RefinanceLoans.ORIGINALTERM, r.getTerm());
					dataEntity.set(RefinanceLoans.CAPITALBALANCE, r.getCapitalBalance());
					dataEntity.set(RefinanceLoans.INTERESTBALANCE, r.getInterestBalance());
					dataEntity.set(RefinanceLoans.DEFAULTBALANCE, r.getDefaultBalance());
					dataEntity.set(RefinanceLoans.OTHERCONCEPTSBALANCE, r.getOthersConceptBalance());
					dataEntity.set(RefinanceLoans.RESIDUALTERM, r.getResidualTerm());
					dataEntity.set(RefinanceLoans.CURRENCYTYPE, r.getCurrencyName());
					dataEntity.set(RefinanceLoans.OVERDUEFEES, r.getOverdueFees());
					
					balanceCapital = balanceCapital.add(r.getCapitalBalance());
					totalToRefinance = totalToRefinance.add(r.getCapitalBalance());
					balanceOthers = balanceOthers.add(r.getInterestBalance());
					totalToRefinance = totalToRefinance.add(r.getInterestBalance());
					balanceOthers = balanceOthers.add(r.getDefaultBalance());
					totalToRefinance = totalToRefinance.add(r.getDefaultBalance());
					balanceOthers = balanceOthers.add(r.getOthersConceptBalance());
					totalToRefinance = totalToRefinance.add(r.getOthersConceptBalance());
					
					entityList.add(dataEntity);
				}
				entities.setEntityList(RefinanceLoans.ENTITY_NAME, entityList);

				if (refinancingLoanFilter.get(RefinanceLoanFilter.ADDITIONALVALUE) == null) {
					refinancingLoanFilter.set(RefinanceLoanFilter.ADDITIONALVALUE, BigDecimal.valueOf(0));
				}

				totalToRefinance = totalToRefinance.add(refinancingLoanFilter.get(RefinanceLoanFilter.ADDITIONALVALUE));
				refinancingLoanFilter.set(RefinanceLoanFilter.TOTALREFINANCE, totalToRefinance);				
				if (balanceCapital != null){
				   refinancingLoanFilter.set(RefinanceLoanFilter.CAPITALBALANCE,balanceCapital);
				}
				refinancingLoanFilter.set(RefinanceLoanFilter.OTHERBALANCE,balanceOthers);
				RefinancingStatus refinancingStatus = new RefinancingStatus(getServiceIntegration());
				refinancingStatus.setRefinancingStatus(entities);
			} else {
				String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
				args.getMessageManager().showErrorMsg(mensaje);
			}
		}
		
	}

}
