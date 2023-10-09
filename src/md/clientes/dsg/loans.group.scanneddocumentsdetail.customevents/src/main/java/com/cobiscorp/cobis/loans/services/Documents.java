package com.cobiscorp.cobis.loans.services;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsResponse;
import loans.group.scanneddocumentsdetail.commons.constants.RequestName;
import loans.group.scanneddocumentsdetail.commons.constants.ReturnName;
import loans.group.scanneddocumentsdetail.commons.constants.ServiceId;

public class Documents extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(Documents.class);

	public Documents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	public ScannedDocumentsResponse[] queryScannedDocuments(ScannedDocumentsRequest scannedDocumentsRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("arg1: "+arg1);
		LOGGER.logDebug("getServiceIntegration(): "+getServiceIntegration());
		CallServices callServices = new CallServices(getServiceIntegration());
		return (ScannedDocumentsResponse[]) callServices.callServiceWithReturnArray(RequestName.SCANNED_DOCUMENTS_REQUEST, scannedDocumentsRequest, ServiceId.SEARCH_DOCUMENTS,
				ReturnName.SCANNED_DOCUMENTS_RESPONSE, arg1);

	}
	public boolean updateScannedDocuments(ScannedDocumentsRequest scannedDocumentsRequest, ICommonEventArgs arg1, BehaviorOption options) {
		LOGGER.logDebug("arg1: "+arg1);
		LOGGER.logDebug("getServiceIntegration(): "+getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.SCANNED_DOCUMENTS_REQUEST, scannedDocumentsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.UPDATE_DOCUMENTS, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			return serviceResponse.isResult();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}

	}
}
