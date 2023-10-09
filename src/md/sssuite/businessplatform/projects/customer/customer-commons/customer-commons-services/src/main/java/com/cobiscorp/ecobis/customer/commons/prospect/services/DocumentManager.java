package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.DocumentTypeRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.DocumentTypeResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class DocumentManager extends BaseEvent {

	public DocumentManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public DocumentTypeResponse[] searchDocumentTypes(DocumentTypeRequest documentTypeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		DocumentTypeResponse[] documents = callService.callServiceWithReturnArray(RequestName.DOCUMENT_REQUEST, documentTypeRequest, ServiceId.SEARCH_DOCUMENT_TYPES,
				ReturnName.DOCUMENT_RETURN, arg1);
		return documents == null ? new DocumentTypeResponse[0] : documents;
	}

}
