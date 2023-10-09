package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.clcol.model.CollectiveRolList;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole;

import cobiscorp.ecobis.collective.dto.AdvisorRoleRequest;
import cobiscorp.ecobis.collective.dto.AdvisorRoleResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryAdvisorRole extends BaseEvent implements IExecuteQuery{
	
	private static final ILogger LOGGER = LogFactory.getLogger(QueryAdvisorRole.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public QueryAdvisorRole(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia ejecución del evento QueryAdvisorRole");
		}
		
		
		try {
			
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("serviceIntegration: " + serviceIntegration);
			}
			AdvisorRoleRequest advisorRoleRequest = new AdvisorRoleRequest();
			advisorRoleRequest.setOperacion('Q');

			CollectiveAdvisorRole collectiveAdvisorRole = new CollectiveAdvisorRole(serviceIntegration);
			AdvisorRoleResponse[] response = collectiveAdvisorRole.queryAdvisorRole(advisorRoleRequest, arg1);
			
			DataEntityList collectiveRolList = new DataEntityList();
		
			for(AdvisorRoleResponse advisorRole: response) {
				DataEntity collectiveRol = new DataEntity();
				collectiveRol.set(CollectiveRolList.IDCOLLECTIVE, "");
				collectiveRol.set(CollectiveRolList.COLLECTIVEDESCRIPTION, advisorRole.getDescripcionColectivo());
				collectiveRol.set(CollectiveRolList.OFFICIALID, advisorRole.getIdOficial());
				collectiveRol.set(CollectiveRolList.OFFICIALNAME, advisorRole.getNombreOficial());
				collectiveRol.set(CollectiveRolList.ROLEDESCRIPTION, advisorRole.getRol());
				collectiveRolList.add(collectiveRol);
			}
			
			return collectiveRolList.getDataList();
		}catch (Exception e) {
			LOGGER.logError("Error en la consulta de Asesores por Rol ---> ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento QueryAdvisorRole");
			}
		}
		
		return null;
	}

}
