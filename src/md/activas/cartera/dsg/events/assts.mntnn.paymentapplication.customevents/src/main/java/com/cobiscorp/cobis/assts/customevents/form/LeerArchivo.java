package com.cobiscorp.cobis.assts.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LeerArchivo extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger logger = LogFactory
			.getLogger(LeerArchivo.class);

	public LeerArchivo(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities,IExecuteCommandEventArgs arg1) {
		      
 
        try {
            logger.logDebug("path >>>"+ SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH));
            
         
        } catch (Exception e) {
            logger.logError("error en el archivo" , e);
            arg1.setSuccess(false);
            arg1.getMessageManager().showInfoMsg("Error al subir el archivo, consultar al administrador");
        }
        
	}
	
}
