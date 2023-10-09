package com.cobiscorp.cobis.busin.flcre.commons.services;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DocumentProduct;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class DocumentManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(DocumentManagement.class);

	public DocumentManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DocumentsResponse[] getDocuments(String type, int requestId, ICommonEventArgs arg1, BehaviorOption options) {
		DocumentsRequest documentsRequest = new DocumentsRequest();
		documentsRequest.setMode(1);
		documentsRequest.setSubOption(1);
		documentsRequest.setType(type);
		documentsRequest.setRequest(requestId);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INDOCUMENTSREQUEST, documentsRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHDOCUMENTSBYTYPE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DocumentsResponse[]) serviceResponseTO.getValue(ReturnName.DOCUMENTS);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public DocumentsApplicationResponse[] getDocumentsByApplication(int requestId, ICommonEventArgs arg1, BehaviorOption options) {
		DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
		documentsApplicationRequest.setIdRequested(requestId);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.ARCHDOCUMENTSAPPLICATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DocumentsApplicationResponse[]) serviceResponseTO.getValue(ReturnName.DOCUMENTSAPPLICATION);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public void searchAndMappingDocumentByRequest(String requestType, int requestId, DynamicRequest entities, ICommonEventArgs args, BehaviorOption options) {
		DataEntityList documentsEntity = new DataEntityList();
		DocumentsResponse[] documentsDTOList = this.getDocuments(requestType, requestId, args, options);
		if (documentsDTOList != null) {
			DocumentsApplicationResponse[] documentsApplicationDTOList = this.getDocumentsByApplication(requestId, args, options);
			if (documentsApplicationDTOList == null) {
				documentsApplicationDTOList = new DocumentsApplicationResponse[0];
			}

			for (DocumentsResponse documentDTO : documentsDTOList) {
				DataEntity document = new DataEntity();
				document.set(DocumentProduct.DOCUMENT, documentDTO.getIdDocument().toString());
				document.set(DocumentProduct.YESNOT, false);
				document.set(DocumentProduct.NEMONIC, documentDTO.getMnemonico());
				document.set(DocumentProduct.DESCRIPTION, documentDTO.getDescription());
				document.set(DocumentProduct.TEMPLATE, documentDTO.getTemplate());
				document.set(DocumentProduct.REPORTPARAMGUARANTOR, " ");
				document.set(DocumentProduct.NROIMPRESSIONS, Mnemonic.STRING_0);
				if (documentsApplicationDTOList.length > 0) {
					for (DocumentsApplicationResponse documentApplicationDTO : documentsApplicationDTOList) {
						if (documentDTO.getIdDocument().equals(documentApplicationDTO.getIdDocument())) {
							document.set(DocumentProduct.NROIMPRESSIONS, documentApplicationDTO.getNumber().toString());
							break;
						}
					}
				}
				documentsEntity.add(document);
			}
		}
		entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);
	}

	public boolean saveDocumentByRequest(int requestId, DynamicRequest entities, ICommonEventArgs args, BehaviorOption options) {
		boolean resp = true;
		DataEntityList documentsEntityList = entities.getEntityList(DocumentProduct.ENTITY_NAME);
		for (DataEntity dataEntity : documentsEntityList) {
			if (dataEntity.get(DocumentProduct.YESNOT)) {
				DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
				documentsApplicationRequest.setIdDocument(Integer.parseInt(dataEntity.get(DocumentProduct.DOCUMENT)));
				documentsApplicationRequest.setIdRequested(requestId);

				ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
				serviceRequestTO.getData().put(RequestName.INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);

				ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEDOCUMENTSAPPLICATION, serviceRequestTO);
				if (!serviceResponse.isResult()) {
					MessageManagement.show(serviceResponse, args, options);
					resp = false;
				}
			}
		}
		return resp;
	}

	public QueryDocumentsResponse[] queryDocumentsInd(QueryDocumentsRequest queryDocumentsRequest) {
		logger.logDebug("Ingreso DocumentManagement>>:queryDocumentsInd");
		logger.logDebug("getServiceIntegration(): " + getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.QUERY_DOCUMENTS_REQUEST, queryDocumentsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERY_DOCUMENTS_IND, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (QueryDocumentsResponse[]) serviceResponseItemsTO.getValue(ReturnName.QUERY_DOCUMENTS_RESPONSE);
		} else {
			logger.logError("Error en el servicio de consulta de documentos");
			return null;
		}
	}

}
