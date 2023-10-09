package com.cobiscorp.cobis.busin.customevents.executeCommand;

//import org.apache.log4j.Category;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExeCommandVA_ATACATEGRY1902_PDUP258 extends BaseEvent implements IExecuteCommand  {

	private static final ILogger LOGGER = LogFactory
			.getLogger(ExeCommandVA_ATACATEGRY1902_PDUP258.class);
	
	
	
	public ExeCommandVA_ATACATEGRY1902_PDUP258(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Inicio ejecucion Save Items");
		}
		try {
			
			DataEntity item = arg0.getEntity(Category.ENTITY_NAME);		
			ItemsManagement itemManager = new ItemsManagement(getServiceIntegration());	
			itemManager.saveItem(arg0, arg1, null, 0.00, item);
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.UPDATE_ITEM, e, arg1, LOGGER);
		}
			
	}
	
}

