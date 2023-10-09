package com.cobiscorp.cobis.cstmr.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.SearchAddressesByCustomer;
import com.cobiscorp.cobis.cstmr.model.CustomerTmp;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class InitDataAdresses extends BaseEvent implements IInitDataEvent {

    private static final ILogger LOGGER = LogFactory.getLogger(InitDataAdresses.class);

    public InitDataAdresses(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    @Override
    public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start executeDataEvent in InitDataAdresses");
        }
        
        ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
		ParameterResponse parameterDto;
		String paraVPMAIL = "N";

        try {
        	LOGGER.logInfo("consulta de parametro 1: VPMAIL");
			parameterDto = parameterManagement.getParameter(4, "VPMAIL", "CLI", args);
			LOGGER.logInfo("valor de parametro VPMAIL: " + parameterDto.getParameterValue());
			paraVPMAIL = parameterDto.getParameterValue();
			
			DataEntity addressEntity = entities
					.getEntity(CustomerTmp.ENTITY_NAME);
			
			addressEntity.set(CustomerTmp.PARAMVAMAIL, paraVPMAIL);
        } catch (Exception e) {
			ExceptionUtils.showError("Error al consultar parámetro VPMAIL", e, args, LOGGER);
		}
        
        
		try {	
            SearchAddressesByCustomer searchAddressesByCustomer = new SearchAddressesByCustomer(getServiceIntegration());
            searchAddressesByCustomer.searchAddressesByCustomer(entities, args);
        } catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INITDATA_ADDRESS, e, args, LOGGER);
		}

    }


}