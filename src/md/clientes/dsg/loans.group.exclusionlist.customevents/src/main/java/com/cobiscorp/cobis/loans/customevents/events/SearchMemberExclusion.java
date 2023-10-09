package com.cobiscorp.cobis.loans.customevents.events;

import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListResponse;

import com.cobiscorp.cobis.loans.model.CustomerExclusionList;
import com.cobiscorp.cobis.loans.model.ExclusionListResult;

import java.util.List;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.services.MemberExclusionManager;

public class SearchMemberExclusion extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchMemberExclusion.class);
	private ICTSServiceIntegration serviceIntegration;

	public SearchMemberExclusion(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public List executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs arg1) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia ejecución del evento SearchMemberExclusion");
		}
		
		try {
		// TODO Auto-generated method stub
		int idCustomer = 0;
		CustomerExclusionListRequest request=new CustomerExclusionListRequest();
		
		LOGGER.logDebug("data0: " + entities.getData().toString());
		if ((Integer) entities.getData().get("customerId") == null) {
			idCustomer = 0;
			request.setOperation('S');			
		} else {
			idCustomer = (Integer) entities.getData().get("customerId");
			LOGGER.logDebug("Customer id-->: " + entities.getData().get("customerId"));
			request.setOperation('Q');
			request.setCustomerId( (Integer) entities.getData().get("customerId"));
		}
		
		MemberExclusionManager manager =new MemberExclusionManager(serviceIntegration);
		
		CustomerExclusionListResponse[] response = manager.searchMemberExclution(request, arg1);
		
		DataEntityList managerExclutionList = new DataEntityList();
	
		for(CustomerExclusionListResponse exclutionMember: response) {
			DataEntity customerExclusionList = new DataEntity();
			customerExclusionList.set(ExclusionListResult.CUSTOMERID, exclutionMember.getCustomerId());
			customerExclusionList.set(ExclusionListResult.CUSTOMERNAME, exclutionMember.getCustomerName());
			customerExclusionList.set(ExclusionListResult.RFC, exclutionMember.getRfc());
			customerExclusionList.set(ExclusionListResult.CURP, exclutionMember.getCurp());
			customerExclusionList.set(ExclusionListResult.SCORE, exclutionMember.getScore());
			managerExclutionList.add(customerExclusionList);
		}
		
		return managerExclutionList.getDataList();
		
		
		
		}catch (Exception e) {
			LOGGER.logError("Error en la consulta de clientes excluidos ---> ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento SearchMemberExclusion");
			}
		}
		return null;
	}


}
