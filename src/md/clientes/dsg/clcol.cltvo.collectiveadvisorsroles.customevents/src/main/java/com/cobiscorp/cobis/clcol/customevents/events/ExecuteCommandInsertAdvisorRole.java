package com.cobiscorp.cobis.clcol.customevents.events;

import com.cobiscorp.cobis.clcol.model.CollectiveRole;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole;

import cobiscorp.ecobis.collective.dto.AdvisorRoleRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ExecuteCommandInsertAdvisorRole extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogOfficial.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public ExecuteCommandInsertAdvisorRole(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}
	
	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		try {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia ejecución del evento ExecuteCommandInsertAdvisorRole");
			}
			
			DataEntity collectiveRole = arg0.getEntity(CollectiveRole.ENTITY_NAME);
			String roleDescription = null!=collectiveRole.get(CollectiveRole.ROLEDESCRIPTION) ? collectiveRole.get(CollectiveRole.ROLEDESCRIPTION) : "" ;
			String idOficial = null!=collectiveRole.get(CollectiveRole.OFFICIAL) ? collectiveRole.get(CollectiveRole.OFFICIAL) : "";
			String collectiveDescription = null!=collectiveRole.get(CollectiveRole.COLLECTIVEDESCRIPTION) ? collectiveRole.get(CollectiveRole.COLLECTIVEDESCRIPTION): "";
			
			AdvisorRoleRequest advisorRoleRequest = new AdvisorRoleRequest();
			advisorRoleRequest.setDescripcionRol(roleDescription);
			advisorRoleRequest.setDescripcionColectivo(collectiveDescription);
			advisorRoleRequest.setOficialNegocio(idOficial);
			
			CollectiveAdvisorRole collectiveAdvisorRole = new CollectiveAdvisorRole(serviceIntegration);
			collectiveAdvisorRole.insertAdvisorRole(advisorRoleRequest, arg1);
	
			
		}catch(Exception e) {
			LOGGER.logError("Error en la inserción de Asesores por Rol: ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin ejecución del evento ExecuteCommandInsertAdvisorRole");
			}
		}
	}

}
