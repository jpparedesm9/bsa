package com.cobiscorp.cobis.assets.commons.events;


import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;

import com.cobiscorp.cobis.assets.commons.services.Documents;
import com.cobiscorp.cobis.assts.model.QueryDocumentCredit;
import com.cobiscorp.cobis.assts.model.QueryDocumentGridDetail;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IGridRowCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridRowCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UploadDocuments extends BaseEvent implements IGridRowCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UploadDocuments.class);
	
	public UploadDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	
	@Override
	public void executeRowCommad(DataEntity entities, IGridRowCommandEventArgs arg1) {
		Integer customerId = -1; 
		Integer groupId = -1;
		Integer processInstance = -1;
		String documentId = "";
		
		LOGGER.logDebug("--->>QueryDocumentCredit.ENTITY_NAME: "+QueryDocumentCredit.ENTITY_NAME);
		LOGGER.logDebug("--->>QueryDocumentGridDetail.ENTITY_NAME: "+QueryDocumentGridDetail.ENTITY_NAME);
		
		if(QueryDocumentCredit.ENTITY_NAME != null){
			
		    customerId = entities.get(QueryDocumentCredit.CUSTOMERID); 
			groupId = entities.get(QueryDocumentCredit.GROUPID); 
			processInstance = entities.get(QueryDocumentCredit.PROCESSINSTANCE);
			documentId = entities.get(QueryDocumentCredit.DOCUMENTID);
			
		}else if (QueryDocumentGridDetail.ENTITY_NAME != null){
			
		    customerId = entities.get(QueryDocumentGridDetail.CUSTOMERID); 
			groupId = entities.get(QueryDocumentGridDetail.GROUPID); 
			processInstance = entities.get(QueryDocumentGridDetail.PROCESSINSTANCE);;
			documentId = entities.get(QueryDocumentGridDetail.DOCUMENTID);
		}
		
		LOGGER.logDebug("getCustomerId: "+customerId);
		LOGGER.logDebug("groupId: "+groupId);
		LOGGER.logDebug("getProcessInst: "+processInstance);
		LOGGER.logDebug("getDocumentType: "+documentId);
		
		ejecutar(customerId, groupId, processInstance, documentId, arg1);
		
	}

	
	public void ejecutar(Integer customerId, Integer groupId, Integer processInstance, String documentId, IGridRowCommandEventArgs arg1){
		LOGGER.logDebug("Ingreso a la actualizacion de documentos");
		LOGGER.logDebug("entra");
	    ScannedDocumentsRequest documentsRequest = new ScannedDocumentsRequest();
	    LOGGER.logDebug("getSession: "+SessionManager.getSession().toString());
	    String pathFile = SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH).toString();
	    int transactionType = 1; //Este valor se usa cuando es individual
		try {
			//Seteo de campos
			String extension = pathFile.substring(pathFile.lastIndexOf('.')+1);
			LOGGER.logDebug("extension: "+extension);
			
			if(customerId!= null){
				documentsRequest.setCustomerId(customerId);
			}

			if(groupId != null){
				if(groupId != 0){
					documentsRequest.setGroupId(groupId);
					transactionType = 3; // Se reasigna puesto que es crédito grupal
				}
			}
			if(processInstance != null){
				if(processInstance != 0){
					documentsRequest.setProcessInst(processInstance);
					transactionType = 3; // Se reasigna puesto que es crédito grupal
				}
			}
						
			if((processInstance != null && customerId == null && groupId == null) ||
					(processInstance != null && customerId == 0 && groupId == 0)){
				if(processInstance != 0){
					documentsRequest.setProcessInst(processInstance);
					transactionType = 4; // Para los requerimientos
				}
			}
			
			documentsRequest.setDocumentType(documentId);
			documentsRequest.setExtension(extension);
			

			LOGGER.logDebug("ejecutar-getCustomerId: "+documentsRequest.getCustomerId());
			LOGGER.logDebug("ejecutar-groupId: "+documentsRequest.getGroupId());
			LOGGER.logDebug("ejecutar-getProcessInst: "+documentsRequest.getProcessInst());
			LOGGER.logDebug("ejecutar-getDocumentType: "+documentsRequest.getDocumentType());
			LOGGER.logDebug("ejecutar-getExtension: "+documentsRequest.getExtension());
			
			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro");
			Documents documentsManager = new Documents(getServiceIntegration());

			
			if (!documentsManager.updateScannedDocuments(documentsRequest, arg1, new BehaviorOption(true))) {
				arg1.setSuccess(false);
			} else {
				LOGGER.logDebug("Ruta: "+SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH));
				LOGGER.logDebug("Ingresa a guardar archivo en Alfresco");
				
				UploadAlfresco loadFilesAlfresco = new UploadAlfresco(getServiceIntegration());
				loadFilesAlfresco.uploadFile(transactionType, String.valueOf(documentsRequest.getCustomerId()), 
						String.valueOf(documentsRequest.getDocumentType()), String.valueOf(documentsRequest.getProcessInst()), 
						String.valueOf(documentsRequest.getGroupId()), pathFile);
				
				arg1.getMessageManager().showSuccessMsg("El documento ha sido subido con exito");
				arg1.setSuccess(true);
			}
				
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.UPLOAD_DOCUMENTS, e, arg1, LOGGER);

		}
	}

}
