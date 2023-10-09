package com.cobiscorp.cobis.cstmr.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.services.DocumentsManager;
import com.cobiscorp.cobis.cstmr.model.DocumentsUpload;
import com.cobiscorp.cobis.cstmr.model.GeneralData;
import com.cobiscorp.cobis.cstmr.model.OriginalHeader;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsResponse;

public class ValidateDocumentsFI extends BaseEvent implements IExecuteCommand  {
	private static final ILogger LOGGER = LogFactory.getLogger(ValidateDocumentsFI.class);
	
	public ValidateDocumentsFI(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("Inicia validacion de Documentos para flujo Individual");
		try {
		DataEntity generalData = entities.getEntity(GeneralData.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		LOGGER.logDebug("generalData UploadedDocuments---" + generalData);
		LOGGER.logDebug("originalHeader UploadedDocuments---" + originalHeader);
		int clientId = generalData.get(GeneralData.CLIENTID);
		int processInstance = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		LOGGER.logDebug("clientId---" + clientId);
		LOGGER.logDebug("processInstance---" + processInstance);
		UploadedDocumentsRequest request = new UploadedDocumentsRequest();
		request.setProcessInstance(processInstance);
		request.setClientId(clientId);
		
		DocumentsManager documentsManager = new DocumentsManager(getServiceIntegration());
		UploadedDocumentsResponse validate = documentsManager.validateDocumentsUploaded(request, arg1);
		
		DataEntity uploadedEntity = new DataEntity();

		uploadedEntity.set(DocumentsUpload.PROCESSINSTANCE, validate.getProcessInstance());
		uploadedEntity.set(DocumentsUpload.CLIENTID, validate.getGroupId());
		uploadedEntity.set(DocumentsUpload.UPLOADS, ("S".equals(validate.getUploads()) ? true : false));
		
		LOGGER.logDebug("uploadedEntity COMPOSITE PROCESSINSTANCE--- " + validate.getProcessInstance());
		LOGGER.logDebug("uploadedEntity COMPOSITE GROUPID--- " +  validate.getGroupId());
		LOGGER.logDebug("uploadedEntity COMPOSITE UPLOADS--- " + validate.getUploads());
		
		entities.setEntity(DocumentsUpload.ENTITY_NAME, uploadedEntity);
	} catch (Exception e) {
		ExceptionUtils.showError(ExceptionMessage.Clients.VALIDATE_DOCUMENTS, e, arg1, LOGGER);
	}
		

		
	}

}
