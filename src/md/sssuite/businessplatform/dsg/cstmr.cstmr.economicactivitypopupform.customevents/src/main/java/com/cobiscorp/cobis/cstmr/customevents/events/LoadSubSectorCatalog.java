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
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadSubSectorCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadSubSectorCatalog.class);
	
	public LoadSubSectorCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
        ServiceRequestTO request = new ServiceRequestTO();
        ServiceResponse response;
        
        DataEntity economicActivity = arg0.getEntity(EconomicActivity.ENTITY_NAME);
        
        SubSectorRequest subSectorRequest = new SubSectorRequest();
        
        int recordCount = 0;
        String sequential = "";
        Integer mode = 0;
        try{

        do {
               recordCount = 0;
               subSectorRequest.setSequential(sequential);
               subSectorRequest.setSector(economicActivity.get(EconomicActivity.ECONOMICSECTOR));
               subSectorRequest.setMode(mode);
               request.addValue("inSubSectorRequest", subSectorRequest);              
               response = this.execute(LOGGER,"CustomerDataManagementService.CustomerManagement.ReadSubSector", request);
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
            	LOGGER.logError(e);
                this.manageException(e, LOGGER);
			}
        } while (recordCount == 20);

        return lista;
        }
        catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_SUBSECTOR, e, arg1, LOGGER);
		}
        return lista;
	}

}
