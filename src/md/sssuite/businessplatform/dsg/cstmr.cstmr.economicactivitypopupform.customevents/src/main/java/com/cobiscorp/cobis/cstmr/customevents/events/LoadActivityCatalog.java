package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ActivityRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CatalogResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
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

public class LoadActivityCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadActivityCatalog.class);
	
	public LoadActivityCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia LoadActivityCatalog");}

		List<ItemDTO> lista = new ArrayList<ItemDTO>();
        ServiceRequestTO request = new ServiceRequestTO();
        ServiceResponse response;
        
        DataEntity economicActivity = arg0.getEntity(EconomicActivity.ENTITY_NAME);

        ActivityRequest activityRequest = new ActivityRequest();
        try{
        int recordCount = 0;
        String codeAuxiliar = "";
        Integer mode = 0; 

        do {
            recordCount = 0;
            
       		if (economicActivity.get(EconomicActivity.SUBSECTOR) != null && !"".equals(economicActivity.get(EconomicActivity.SUBSECTOR))) {
    			activityRequest.setOperation(String.valueOf(Parameter.OPERATION_QUERY));
    			activityRequest.setSubSector(economicActivity.get(EconomicActivity.SUBSECTOR));
    		} else {
    			activityRequest.setOperation("Z");
    			activityRequest.setSector(economicActivity.get(EconomicActivity.ECONOMICSECTOR));
    		}
       		activityRequest.setMode(mode);
       		activityRequest.setCode(codeAuxiliar);
            request.addValue("inActivityRequest", activityRequest);
            response = this.execute(LOGGER,"CustomerDataManagementService.CustomerManagement.ReadActivity", request);
            if (response.isResult()) {
                  ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
                  if (resultado.isSuccess()) {
            	      	CatalogResponse[] catalogResponseList = (CatalogResponse[]) resultado.getValue("returnCatalogResponse");
                        for (CatalogResponse item : catalogResponseList) {
                               	ItemDTO itemDTO = new ItemDTO();
                               	itemDTO.setCode(item.getCode());
                               	itemDTO.setValue(item.getDescription());
                               	lista.add(itemDTO);
                          		codeAuxiliar = item.getCode();
                                mode = 1;
                                recordCount = recordCount + 1;
                        }
                        LOGGER.logDebug("recordCount --> " + recordCount);
                  }
            }
            else {
                  String mensaje = "Error al cargar las actividades económicas";
                  arg1.getMessageManager().showErrorMsg(mensaje);
            }
        
        } while (recordCount == 20);
        
        return lista;
        }
        catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_ACTIVITY, e, arg1, LOGGER);
		}
        return lista;
	}

}
