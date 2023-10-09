package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RefinanceLoanRefreshDataChangeEvent extends BaseEvent implements IChangedEvent {

	
	public RefinanceLoanRefreshDataChangeEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		BigDecimal totalToRefinance = new BigDecimal(0);
		BigDecimal balanceCapital = new BigDecimal(0);		
		BigDecimal balanceOthers = new BigDecimal(0);
		
		RefinancingStatus refinancingStatus = new RefinancingStatus(getServiceIntegration());
		refinancingStatus.setRefinancingStatus(entities);

		DataEntity refinanceLoanFilter = entities.getEntity(RefinanceLoanFilter.ENTITY_NAME);
		DataEntityList refinanceLoanList = entities.getEntityList(RefinanceLoans.ENTITY_NAME);
		
		for (DataEntity r : refinanceLoanList) {
			balanceCapital = balanceCapital.add(r.get(RefinanceLoans.CAPITALBALANCE));
			totalToRefinance = totalToRefinance.add(r.get(RefinanceLoans.CAPITALBALANCE));
			balanceOthers = balanceOthers.add(r.get(RefinanceLoans.INTERESTBALANCE));
			totalToRefinance = totalToRefinance.add(r.get(RefinanceLoans.INTERESTBALANCE));
			balanceOthers = balanceOthers.add(r.get(RefinanceLoans.DEFAULTBALANCE));
			totalToRefinance = totalToRefinance.add(r.get(RefinanceLoans.DEFAULTBALANCE));
			balanceOthers = balanceOthers.add(r.get(RefinanceLoans.OTHERCONCEPTSBALANCE));
			totalToRefinance = totalToRefinance.add(r.get(RefinanceLoans.OTHERCONCEPTSBALANCE));
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.ADDITIONALVALUE) == null) {
			refinanceLoanFilter.set(RefinanceLoanFilter.ADDITIONALVALUE, BigDecimal.valueOf(0));
		}

		totalToRefinance = totalToRefinance.add(refinanceLoanFilter.get(RefinanceLoanFilter.ADDITIONALVALUE));
		refinanceLoanFilter.set(RefinanceLoanFilter.TOTALREFINANCE, totalToRefinance);
		refinanceLoanFilter.set(RefinanceLoanFilter.CAPITALBALANCE,balanceCapital);		
		refinanceLoanFilter.set(RefinanceLoanFilter.OTHERBALANCE,balanceOthers);
	}

}
