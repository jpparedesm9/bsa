package com.cobiscorp.cobis.loans.scanned.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.UploadedDocumentsResponse;

import com.cobiscorp.cobis.loans.scanned.constants.RequestName;
import com.cobiscorp.cobis.loans.scanned.constants.ReturnName;
import com.cobiscorp.cobis.loans.scanned.constants.ServiceId;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class Documents extends BaseEvent {

	//private static final ILogger LOGGER = LogFactory.getLogger(Documents.class);

	public Documents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public UploadedDocumentsResponse validateUploaded(UploadedDocumentsRequest addressHomeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		UploadedDocumentsResponse addressHomeResponse = (UploadedDocumentsResponse) callService.callServiceWithReturn(RequestName.VALIDATE_REQUEST, addressHomeRequest, ServiceId.VALIDATE_DOCUMENTS,
				ReturnName.VALIDATE_RESPONSE, arg1);
		return addressHomeResponse;
	}
	
}
