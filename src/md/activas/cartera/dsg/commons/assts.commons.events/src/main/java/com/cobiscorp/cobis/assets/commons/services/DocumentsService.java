package com.cobiscorp.cobis.assets.commons.services;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ReturnName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;

public class DocumentsService extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(DocumentsService.class);

	public DocumentsService(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public QueryDocumentsResponse[] queryDocuments(QueryDocumentsRequest queryDocumentsRequest) {
		LOGGER.logDebug("getServiceIntegration(): "+getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.QUERY_DOCUMENTS_REQUEST, queryDocumentsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_DOCUMENTS, serviceRequestApplicationTO);
		if(serviceResponse.isResult()){
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (QueryDocumentsResponse[]) serviceResponseItemsTO.getValue(ReturnName.QUERY_DOCUMENTS_RESPONSE);
		}else{
			LOGGER.logError("Error en el servicio de consulta de documentos");
			return null;
		}

	}
	public QueryDocumentsResponse[] queryDocumentsInd(QueryDocumentsRequest queryDocumentsRequest) {
		LOGGER.logDebug("getServiceIntegration(): "+getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.QUERY_DOCUMENTS_REQUEST, queryDocumentsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_DOCUMENTS_IND, serviceRequestApplicationTO);
		if(serviceResponse.isResult()){
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (QueryDocumentsResponse[]) serviceResponseItemsTO.getValue(ReturnName.QUERY_DOCUMENTS_RESPONSE);
		}else{
			LOGGER.logError("Error en el servicio de consulta de documentos");
			return null;
		}
	}
	public QueryDocumentsResponse[] queryDocumentsCredit(QueryDocumentsRequest queryDocumentsRequest) {
		LOGGER.logDebug("getServiceIntegration(): "+getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.QUERY_DOCUMENTS_REQUEST, queryDocumentsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_DOCUMENTS_CREDIT, serviceRequestApplicationTO);
		if(serviceResponse.isResult()){
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (QueryDocumentsResponse[]) serviceResponseItemsTO.getValue(ReturnName.QUERY_DOCUMENTS_RESPONSE);
		}else{
			LOGGER.logError("Error en el servicio de consulta de documentos");
			return null;
		}
	}
}
