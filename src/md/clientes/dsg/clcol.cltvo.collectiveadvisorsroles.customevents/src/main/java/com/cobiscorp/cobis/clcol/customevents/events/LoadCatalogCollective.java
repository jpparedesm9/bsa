package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.clcol.model.CollectiveRole;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

import cobiscorp.ecobis.collective.dto.OfficialByRoleResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveAdvisorRole;
import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveAdvisorRoleResponse;

public class LoadCatalogCollective extends BaseEvent implements ILoadCatalog{

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogCollective.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public LoadCatalogCollective(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}
	
	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		try {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia ejecución del evento LoadCatalogCollective");
			}
			
			final String DIRECCION = "OFICINA VIRTUAL";
			
			CollectiveAdvisorRole collectiveAdvisorRole = new CollectiveAdvisorRole();
			collectiveAdvisorRole.setOperacion('R');
			collectiveAdvisorRole.setDireccion(DIRECCION);
			
			com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole services = new com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole(serviceIntegration);
			CollectiveAdvisorRoleResponse[] response = services.queryCollective(collectiveAdvisorRole, arg1);
			
			List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
			if(null!=response && response.length >0) {
				for(CollectiveAdvisorRoleResponse collectiveAdvisorRoleResponse:response) {
					ItemDTO item = new ItemDTO();
					String idOficina = String.valueOf(collectiveAdvisorRoleResponse.getIdOficina());
					item.setCode(idOficina );
					item.setValue(collectiveAdvisorRoleResponse.getOficinaDescripcion());
					listItemDTO.add(item);
				}
				return listItemDTO;
			}			
		}catch(Exception e) {
			LOGGER.logError("Error en la carga del combo Colectivo: ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin ejecución del evento LoadCatalogCollective");
			}
		}
		return null;
	}

}
