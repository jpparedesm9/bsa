package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.Map;

import com.cobiscorp.cobis.clcol.model.CollectiveRolList;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole;

import cobiscorp.ecobis.collective.dto.AdvisorRoleRequest;
import cobiscorp.ecobis.collective.dto.OfficialByRoleResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class DeleteAdvisorRole extends BaseEvent implements IGridRowDeleting{
	
	private static final ILogger LOGGER = LogFactory.getLogger(DeleteAdvisorRole.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public DeleteAdvisorRole(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}
	
	
	@Override
	public void rowAction(DataEntity arg0, IGridRowActionEventArgs arg1) {
		
		try {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia ejecución del evento DeleteAdvisorRole");
			}
		
			String roleDescription = null!=arg0.get(CollectiveRolList.ROLEDESCRIPTION) ? arg0.get(CollectiveRolList.ROLEDESCRIPTION).toString() : "" ;
			String idOficial = null!=arg0.get(CollectiveRolList.OFFICIALID) ? arg0.get(CollectiveRolList.OFFICIALID).toString() : "";
			String collectiveDescription = null!=arg0.get(CollectiveRolList.COLLECTIVEDESCRIPTION) ? arg0.get(CollectiveRolList.COLLECTIVEDESCRIPTION).toString(): "";
			
			AdvisorRoleRequest advisorRoleRequest = new AdvisorRoleRequest();
			advisorRoleRequest.setDescripcionRol(roleDescription);
			advisorRoleRequest.setDescripcionColectivo(collectiveDescription);
			advisorRoleRequest.setOficialNegocio(idOficial);
	
			CollectiveAdvisorRole collectiveAdvisorRole = new CollectiveAdvisorRole(serviceIntegration);
			Map<String, Object> outputs = collectiveAdvisorRole.deleteAdvisorRoleTest(advisorRoleRequest, arg1);
			
			if (outputs != null && outputs.size() > 0) {
				arg1.getMessageManager().showInfoMsg(outputs.get("@o_mensaje").toString());
			}
		}catch(Exception e) {
			LOGGER.logError("Error en la eliminacion del registro: ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia ejecución del evento DeleteAdvisorRole");
			}
		}
	}

}
