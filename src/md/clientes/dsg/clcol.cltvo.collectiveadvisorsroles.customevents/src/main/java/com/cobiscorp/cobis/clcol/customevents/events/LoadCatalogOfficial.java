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
import com.cobiscorp.ecobis.collective.commons.services.CollectiveAdvisorRole;

import cobiscorp.ecobis.collective.dto.AdvisorRoleRequest;
import cobiscorp.ecobis.collective.dto.OfficialByRoleResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoadCatalogOfficial extends BaseEvent implements ILoadCatalog{
	
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogOfficial.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public LoadCatalogOfficial(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}
	
	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		try {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia ejecución del evento LoadCatalogOfficial");
			}
			
			DataEntity collectiveRole = arg0.getEntity(CollectiveRole.ENTITY_NAME);
			String roleDescription = null!=collectiveRole.get(CollectiveRole.ROLEDESCRIPTION) ? collectiveRole.get(CollectiveRole.ROLEDESCRIPTION) : "" ;
			
			AdvisorRoleRequest advisorRoleRequest = new AdvisorRoleRequest();
			advisorRoleRequest.setDescripcionRol(roleDescription);

			CollectiveAdvisorRole collectiveAdvisorRole = new CollectiveAdvisorRole(serviceIntegration);
			OfficialByRoleResponse[] response = collectiveAdvisorRole.queryOfficialByRole(advisorRoleRequest, arg1);
			
			List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
			if(null!=response && response.length >0) {
				for(OfficialByRoleResponse officialByRoleResponse:response) {
					ItemDTO item = new ItemDTO();
					item.setCode(officialByRoleResponse.getIdOficial());
					item.setValue(officialByRoleResponse.getNombreOficial());
					listItemDTO.add(item);
				}
				return listItemDTO;
			}
			
		}catch(Exception e) {
			LOGGER.logError("Error en la carga del catalogo de Oficial: ",e);
		}finally {
			if(LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Fin de ejecución del evento LoadCatalogOfficial");
			}
			
		}
		return null;
	}

}
