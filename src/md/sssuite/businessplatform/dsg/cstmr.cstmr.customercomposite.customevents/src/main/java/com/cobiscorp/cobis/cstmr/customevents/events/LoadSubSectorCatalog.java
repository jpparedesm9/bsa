package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CatalogResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.SubSectorRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.EconomicActivity;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class LoadSubSectorCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory.getLogger(LoadSubSectorCatalog.class);
	
	public LoadSubSectorCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia LoadSubSectorCatalog");}
		
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
        ServiceRequestTO request = new ServiceRequestTO();
        ServiceResponse response;
        
        DataEntityList economicActivityList = arg0.getEntityList(EconomicActivity.ENTITY_NAME);
        
        Integer gridRow = economicActivityList.get(0).get(EconomicActivity.GRIDROW);
        
        if (gridRow > economicActivityList.size() - 1) 
        	gridRow = economicActivityList.size() - 1;
                
        DataEntity economicActivity = economicActivityList.get(gridRow);
        
        SubSectorRequest subSectorRequest = new SubSectorRequest();
        
        int recordCount;
        String sequential = "";
        Integer mode = 0; 

        do {
               recordCount = 0;
               subSectorRequest.setSequential(sequential);
               subSectorRequest.setSector(economicActivity.get(EconomicActivity.ECONOMICSECTOR));
               subSectorRequest.setMode(mode);
               request.addValue("inSubSectorRequest", subSectorRequest);              
               response = this.execute(logger,"CustomerDataManagementService.CustomerManagement.ReadSubSector", request);
               try {
                   if (response.isResult()) {
                       ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
                       if (resultado.isSuccess()) {
                    	   CatalogResponse[] catalogResponseList = (CatalogResponse[]) resultado.getValue("returnCatalogResponse");
                             for (CatalogResponse item : catalogResponseList) {
                                    ItemDTO itemDTO = new ItemDTO();
                                    itemDTO.setCode(item.getCode());
                                    itemDTO.setValue(item.getDescription());
                                    lista.add(itemDTO);
                                    sequential = item.getCode();
                                    mode = 1;
                                    recordCount = recordCount + 1;
                             }
                       }
                }
			} catch (Exception e) {
            	logger.logError(e);
                this.manageException(e, logger);
			}
        } while (recordCount == 20);
        
        return lista;
	}

}
