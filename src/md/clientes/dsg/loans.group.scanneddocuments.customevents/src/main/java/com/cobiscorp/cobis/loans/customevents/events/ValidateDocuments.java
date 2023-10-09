package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.UploadedDocuments;
import com.cobiscorp.cobis.loans.scanned.services.Documents;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ValidateDocuments extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ValidateDocuments.class);

	public ValidateDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			LOGGER.logDebug("Start searchBusinessByCustomer in SearchBusinessByCustomer en COMPOSITE");
			DataEntity uploadsTmp = entities.getEntity(UploadedDocuments.ENTITY_NAME);
			LOGGER.logDebug("uploadsTmp UploadedDocuments---" + uploadsTmp);
			int groupId = uploadsTmp.get(UploadedDocuments.GROUPID);
			int processInstance = uploadsTmp.get(UploadedDocuments.PROCESSINSTANCE);

			UploadedDocumentsRequest request = new UploadedDocumentsRequest();
			request.setProcessInstance(processInstance);
			request.setGroupId(groupId);

			Documents documentsManager = new Documents(getServiceIntegration());
			UploadedDocumentsResponse validate = documentsManager.validateUploaded(request, args);

			DataEntity uploadedEntity = new DataEntity();

			uploadedEntity.set(UploadedDocuments.PROCESSINSTANCE, validate.getProcessInstance());
			uploadedEntity.set(UploadedDocuments.GROUPID, validate.getGroupId());
			uploadedEntity.set(UploadedDocuments.UPLOADS, ("S".equals(validate.getUploads()) ? true : false));
			
			LOGGER.logDebug("uploadedEntity COMPOSITE PROCESSINSTANCE--- " + validate.getProcessInstance());
			LOGGER.logDebug("uploadedEntity COMPOSITE GROUPID--- " +  validate.getGroupId());
			LOGGER.logDebug("uploadedEntity COMPOSITE UPLOADS--- " + validate.getUploads());
			
			entities.setEntity(UploadedDocuments.ENTITY_NAME, uploadedEntity);
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.VALIDATE_DOCUMENTS, e, args, LOGGER);
		}

	}

}
