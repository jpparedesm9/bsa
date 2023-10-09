package com.cobiscorp.cobis.loans.customevents.events;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.loans.model.ScannedDocumentsDetail;
import com.cobiscorp.cobis.loans.services.Documents;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IGridRowCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridRowCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;



public class UploadDocuments extends BaseEvent implements IGridRowCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UploadDocuments.class);
	
	public UploadDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	
	@Override
	public void executeRowCommad(DataEntity entities, IGridRowCommandEventArgs arg1) {
		
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
			documentsRequest.setCustomerId(entities.get(ScannedDocumentsDetail.CUSTOMERID));
			if(entities.get(ScannedDocumentsDetail.GROUPID) != null){
				if(entities.get(ScannedDocumentsDetail.GROUPID) != 0){
					documentsRequest.setGroupId(entities.get(ScannedDocumentsDetail.GROUPID));
					transactionType = 3; // Se reasigna puesto que es crédito grupal
				}
			}
			if(entities.get(ScannedDocumentsDetail.PROCESSINSTANCE) != null){
				if(entities.get(ScannedDocumentsDetail.PROCESSINSTANCE) != 0){
					documentsRequest.setProcessInst(entities.get(ScannedDocumentsDetail.PROCESSINSTANCE));
					transactionType = 3; // Se reasigna puesto que es crédito grupal
				}
			}
			documentsRequest.setDocumentType(entities.get(ScannedDocumentsDetail.DOCUMENTID));
			documentsRequest.setExtension(extension);
			

			LOGGER.logDebug("getCustomerId: "+documentsRequest.getCustomerId());
			LOGGER.logDebug("groupId: "+documentsRequest.getGroupId());
			LOGGER.logDebug("getProcessInst: "+documentsRequest.getProcessInst());
			LOGGER.logDebug("getDocumentType: "+documentsRequest.getDocumentType());
			LOGGER.logDebug("getExtension: "+documentsRequest.getExtension());
			
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
