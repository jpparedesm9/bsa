package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponseList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.DocumentProduct;
import com.cobiscorp.cobis.busin.model.SearchCriteriaPrintingDocuments;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandPrint extends BaseEvent implements IExecuteCommand {

	private final static String SERVICEUPDATEDOCUMENTSAPPLICATION = "Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication";
	private final static String INDOCUMENTSREQUEST = "inDocumentsRequest";
	private final static String RETURNDOCUMENTSRESPONSE = "returnDocumentsResponse";
	private final static String OUTDOCUMENTSRESPONSE = "outDocumentsResponseList";
	private final static String SERVICESEARCHDOCUMENTS = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments";
	private final static String SERVICESEARCHDOCUMENTSBYTYPE = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType";
	private final static String INDOCUMENTSAPPLICATIONREQUEST = "inDocumentsApplicationRequest";
	private final static String RETURNDOCUMENTSAPPLICATIONRESPONSE = "returnDocumentsApplicationResponse";
	private final static String OUTDOCUMENTSAPPLICATIONRESPONSE = "outDocumentsApplicationResponseList";
	private final static String SERVICESEARCHDOCUMENTSAPPLICATION = "Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication";

	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandPrint.class);

	public ExecuteCommandPrint(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try{
			DataEntity criterialSearchEntity = entities.getEntity(SearchCriteriaPrintingDocuments.ENTITY_NAME);
			DataEntityList documentsApplicationEntityList = new DataEntityList();
			documentsApplicationEntityList = entities.getEntityList(DocumentProduct.ENTITY_NAME);
			entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsApplicationEntityList);

			// DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest ();

			for (DataEntity dataEntity : documentsApplicationEntityList) {

				if (dataEntity.get(DocumentProduct.YESNOT) == true) {
					DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();

					documentsApplicationRequest.setIdDocument(Integer.parseInt(dataEntity.get(DocumentProduct.DOCUMENT)));
					documentsApplicationRequest.setIdRequested(Integer.parseInt(criterialSearchEntity.get(SearchCriteriaPrintingDocuments.CODEPROCESS)));

					ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
					ServiceResponse serviceResponseDocumentsApplication = null;

					serviceRequestDocumentsApplicationTO.getData().put(INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
					serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, SERVICEUPDATEDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);

					List<Message> errorMessage = new ArrayList<Message>();
					if (serviceResponseDocumentsApplication.isResult()) {
						args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_SUUPRINTG_25476");
						args.setSuccess(true);
					} else {
						args.setSuccess(false);
						errorMessage = serviceResponseDocumentsApplication.getMessages();
						for (Message message : errorMessage) {
							args.getMessageManager().showErrorMsg(message.getMessage() + "/n");
						}
					}
				}
			}

			/* Consumo de servicio de consulta de documentos */
			DocumentsRequest documentsRequest = new DocumentsRequest();
			DocumentsResponseList documentsResponse = new DocumentsResponseList();
			ServiceRequestTO serviceRequestDocumentsTO = new ServiceRequestTO();
			ServiceResponse serviceResponseDocument = null;
			ServiceResponseTO serviceResponseDocumentsTO = null;

			documentsRequest.setMode(0);
			documentsRequest.setType(criterialSearchEntity.get(SearchCriteriaPrintingDocuments.TYPEPROCESS));
			documentsRequest.setRequest(Integer.valueOf(criterialSearchEntity.get(SearchCriteriaPrintingDocuments.CODEPROCESS)));			
			documentsRequest.setSubOption(1);

			serviceRequestDocumentsTO.getData().put(INDOCUMENTSREQUEST, documentsRequest);
			serviceRequestDocumentsTO.getData().put(OUTDOCUMENTSRESPONSE, documentsResponse);
			serviceResponseDocument = execute(getServiceIntegration(), LOGGER, SERVICESEARCHDOCUMENTS, serviceRequestDocumentsTO);
			if (serviceResponseDocument.isResult()) {
				serviceResponseDocumentsTO = (ServiceResponseTO) serviceResponseDocument.getData();
				DocumentsResponse[] documentsResponseList = (DocumentsResponse[]) serviceResponseDocumentsTO.getValue(RETURNDOCUMENTSRESPONSE);
				DataEntityList documentsEntity = new DataEntityList();

				/* Consumo de servicio de contador de impresion de documentos */
				DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
				DocumentsApplicationResponseList documentsApplicationResponse = new DocumentsApplicationResponseList();
				ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
				ServiceResponse serviceResponseDocumentsApplication = null;
				ServiceResponseTO serviceResponseDocumentsApplictionTO = null;

				documentsApplicationRequest.setIdRequested(Integer.valueOf(criterialSearchEntity.get(SearchCriteriaPrintingDocuments.CODEPROCESS)));
				serviceRequestDocumentsApplicationTO.getData().put(INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
				serviceRequestDocumentsApplicationTO.getData().put(OUTDOCUMENTSAPPLICATIONRESPONSE, documentsApplicationResponse);
				serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, SERVICESEARCHDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);
				if (serviceResponseDocumentsApplication.isResult()) {
					serviceResponseDocumentsApplictionTO = (ServiceResponseTO) serviceResponseDocumentsApplication.getData();
					DocumentsApplicationResponse[] documentsApplicationResponseList = (DocumentsApplicationResponse[]) serviceResponseDocumentsApplictionTO.getValue(RETURNDOCUMENTSAPPLICATIONRESPONSE);

					for (DocumentsResponse documentResponse : documentsResponseList) {
						DataEntity document = new DataEntity();
						boolean addRow = false;
						document.set(DocumentProduct.DOCUMENT, documentResponse.getIdDocument().toString());
						document.set(DocumentProduct.NEMONIC, documentResponse.getMnemonico());
						document.set(DocumentProduct.DESCRIPTION, documentResponse.getDescription());
						document.set(DocumentProduct.TEMPLATE, documentResponse.getTemplate());
						document.set(DocumentProduct.NROIMPRESSIONS, "0");
						document.set(DocumentProduct.YESNOT, null);
						for (DataEntity dataEntity : documentsApplicationEntityList) {
							if (dataEntity.get(DocumentProduct.DOCUMENT).equals(documentResponse.getIdDocument().toString())) {
								if (dataEntity.get(DocumentProduct.YESNOT) == true)
									document.set(DocumentProduct.YESNOT, true);
								else
									document.set(DocumentProduct.YESNOT, false);
							}
						}
						for (DocumentsApplicationResponse documentApplicationResponse : documentsApplicationResponseList) {
							if (documentResponse.getIdDocument().equals(documentApplicationResponse.getIdDocument())) {
								document.set(DocumentProduct.NROIMPRESSIONS, documentApplicationResponse.getNumber().toString());
								addRow = true;
							}
						}
						if (addRow == true) {
							documentsEntity.add(document);
						}
					}
					entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);
				}

			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REPRINT_EXECUTE_PRINT, e, args, LOGGER);
		}

	}

}
