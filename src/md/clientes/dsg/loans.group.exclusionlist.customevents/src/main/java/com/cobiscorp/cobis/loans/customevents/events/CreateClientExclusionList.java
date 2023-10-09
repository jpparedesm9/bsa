package com.cobiscorp.cobis.loans.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.services.MemberExclusionManager;
import com.cobiscorp.cobis.loans.model.CustomerExclusionList;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListResponse;

public class CreateClientExclusionList extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(SearchMemberExclusion.class);
	private ICTSServiceIntegration serviceIntegration;

	public CreateClientExclusionList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia ejecución del evento CreateClientExclusion");
		}

		try {
			DataEntity exclusionList = entities.getEntity(CustomerExclusionList.ENTITY_NAME);//entidad
			CustomerExclusionListRequest CustomerRequest=new CustomerExclusionListRequest(); //request
			LOGGER.logDebug("Customer id-->: " + exclusionList.get(CustomerExclusionList.CUSTOMERID));     
			CustomerRequest.setOperation('I');		
			CustomerRequest.setCustomerId((Integer) exclusionList.get(CustomerExclusionList.CUSTOMERID));
			CustomerRequest.setScore((Character) exclusionList.get(CustomerExclusionList.SCORE));


			
			MemberExclusionManager manager =new MemberExclusionManager(serviceIntegration);		
			manager.createCustomerExclusion(CustomerRequest, arg1);
		
		}catch (Exception e) {
			LOGGER.logError("Error en la insercion de clientes excluidos ---> ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento CreateClientExclusion");
			}
		}
		
	}

}
