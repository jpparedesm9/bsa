package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SynchronizationMovil extends BaseEvent implements IExecuteCommand{
	private static final ILogger LOGGER = LogFactory.getLogger(SynchronizationMovil.class);
	
	public SynchronizationMovil(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);		
	}
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			//SynchronizationMovil requestMovil = new SynchronizationMovil(super.getServiceIntegration());
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity originalHeader =  entities.getEntity(OriginalHeader.ENTITY_NAME);
			
			SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
			SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
						
			synchronizationRequest.setApplicationNumber(context.get(Context.REQUESTID)); // nro de tramite
            synchronizationRequest.setNameActivity(context.get(Context.TASKSUBJECT)); //etapa del flujo
            LOGGER.logDebug("Boton sincroniza tramite>>> " +context.get(Context.REQUESTID));
            LOGGER.logDebug("Boton sincroniza etapa>>> "+context.get(Context.TASKSUBJECT));
            //Se comenta porque se requiere que siempre se sincronize cuando regresa a la etapa de ingreso
            //SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true));
            //if(synchronizationResponse != null && synchronizationResponse.getSynchronization() == null){
            	synchronizationRequest.setProcessNumber(originalHeader.get(OriginalHeader.APPLICATIONNUMBER)); //instancia de proceso           	
            	if(originalHeader.get(OriginalHeader.PRODUCTTYPE).equals("GRUPAL")){
            		 LOGGER.logDebug("Boton sincroniza grupal>>> ");
            		synchronizationManagement.xMLIngresoGrupal(synchronizationRequest, args, new BehaviorOption(true));
            		synchronizationRequest.setSynchronization("S");
            	}else if(originalHeader.get(OriginalHeader.PRODUCTTYPE).equals("INDIVIDUAL")){
            		LOGGER.logDebug("Boton sincroniza individual>>> ");
            		synchronizationManagement.xMLIngresoIndividual(synchronizationRequest, args, new BehaviorOption(true));
            		synchronizationRequest.setSynchronization("S");
            		
            	}
            	
            	if (synchronizationManagement.updateSynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true))) {
            		//context.set(Context.ENABLE, "N"); //para bloquear la pantalla
                    args.setSuccess(true);
                } else {                	
                    args.setSuccess(false);
                }
            //}                
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_SYNC, e, args, LOGGER);
		}
		
		
		
	}
	
}
