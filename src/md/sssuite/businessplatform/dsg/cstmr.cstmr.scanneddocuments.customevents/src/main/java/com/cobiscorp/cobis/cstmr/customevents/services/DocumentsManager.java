package com.cobiscorp.cobis.cstmr.customevents.services;


import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.constantes.RequestName;
import com.cobiscorp.cobis.cstmr.customevents.constantes.ReturnName;
import com.cobiscorp.cobis.cstmr.customevents.constantes.ServiceId;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsResponse;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsResponse;


public class DocumentsManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(DocumentsManager.class);

	public DocumentsManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	public UploadedDocumentsResponse validateDocumentsUploaded(UploadedDocumentsRequest addressHomeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		UploadedDocumentsResponse validateDocuemntsFI = (UploadedDocumentsResponse) callService.callServiceWithReturn(RequestName.VALIDATE_DOCUMENTS_REQUEST_FI, addressHomeRequest, ServiceId.VALIDATE_DOCUMENTS_FI,
				ReturnName.VALIDATE_DOCUMENTS_RESPONSE, arg1);
		return validateDocuemntsFI;
	}
}
