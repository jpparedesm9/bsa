package com.cobiscorp.cobis.loans.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.services.MemberExclusionManager;
import com.cobiscorp.cobis.loans.model.ExclusionListResult;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListRequest;

public class DeleteClientExclusionList extends BaseEvent implements IGridRowDeleting {
	private static final ILogger LOGGER = LogFactory.getLogger(SearchMemberExclusion.class);
	private ICTSServiceIntegration serviceIntegration;

	public DeleteClientExclusionList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void rowAction(DataEntity entity, IGridRowActionEventArgs arg1) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia ejecución del evento DeleteClientExclusion");
		}

		try {		
			
			CustomerExclusionListRequest CustomerRequest=new CustomerExclusionListRequest(); //request
			if (entity.get(ExclusionListResult.CUSTOMERID) != null) {
				CustomerRequest.setCustomerId(entity.get(ExclusionListResult.CUSTOMERID));
			}
			
			LOGGER.logDebug("Customer Delete id---->: " + entity.get(ExclusionListResult.CUSTOMERID));     
			CustomerRequest.setOperation('D');		
			CustomerRequest.setCustomerId((Integer) entity.get(ExclusionListResult.CUSTOMERID));			

			
			MemberExclusionManager manager =new MemberExclusionManager(serviceIntegration);		
			manager.deleteCustomerExclusion(CustomerRequest, arg1);
		
		}catch (Exception e) {
			LOGGER.logError("Error en el borrado de clientes excluidos ---> ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento DeleteClientExclusion");
			}
		}
		
	}

}
