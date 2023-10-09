package com.cobiscorp.cobis.busin.customevents.events;

import com.cobiscorp.cobis.busin.customevents.services.ReprintClientTeamServices;
import com.cobiscorp.cobis.busin.model.Applications;
import com.cobiscorp.cobis.busin.model.DocumentProduct;
import com.cobiscorp.cobis.busin.model.PrintClientsTeam;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IGridRowSelecting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponseList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;

@SuppressWarnings("unused")
public class QV_ERPLI1480_97_RowSelecting extends BaseEvent implements IGridRowSelecting {

	private static ILogger LOGGER = LogFactory.getLogger(QV_ERPLI1480_97_RowSelecting.class);

	private final static String INDOCUMENTSREQUEST = "inDocumentsRequest";
	private final static String RETURNDOCUMENTSRESPONSE = "returnDocumentsResponse";
	private final static String OUTDOCUMENTSRESPONSE = "outDocumentsResponseList";
	private final static String SERVICESEARCHDOCUMENTS = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments";	
	private final static String SERVICESEARCHDOCUMENTSBYTYPE = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType";
	private final static String INDOCUMENTSAPPLICATIONREQUEST = "inDocumentsApplicationRequest";
	private final static String RETURNDOCUMENTSAPPLICATIONRESPONSE = "returnDocumentsApplicationResponse";
	private final static String OUTDOCUMENTSAPPLICATIONRESPONSE = "outDocumentsApplicationResponseList";
	private final static String SERVICESEARCHDOCUMENTSAPPLICATION = "Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication";
	private final static String CERO = "0";

	public QV_ERPLI1480_97_RowSelecting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso gridrowselecting -> QV_ERPLI1480_97_RowSelecting");

			String taskId = args.getParameters().getTaskId();
			if (taskId.equals("T_FLCRE_13_RPUME79")) {
				this.reprintdocument(row, args);
			}
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida gridrowselecting -> QV_ERPLI1480_97_RowSelecting");
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REPRINT_ROW_SELECTING, e, args, LOGGER);
		}
		
	}

	@SuppressWarnings("unchecked")
	private void reprintdocument(DataEntity row, IGridRowActionEventArgs args) {
		try {
			DynamicRequest request = args.getDynamicRequest();
			/* Consumo de servicio de consulta de documentos */
			LOGGER.logDebug("Ingresa a reprintdocument ");
			DocumentsRequest documentsRequest = new DocumentsRequest();
			DocumentsResponseList documentsResponse = new DocumentsResponseList();
			ServiceRequestTO serviceRequestDocumentsTO = new ServiceRequestTO();
			ServiceResponse serviceResponseDocument = null;
			ServiceResponseTO serviceResponseDocumentsTO = null;
			documentsRequest.setMode(0);
			documentsRequest.setType(row.get(Applications.FLOWTYPE));
			LOGGER.logDebug("Voy a enviar FLOWTYPE:  " + row.get(Applications.FLOWTYPE));
			documentsRequest.setSubOption(1);
			documentsRequest.setRequest(Integer.valueOf(row.get(Applications.CREDITCODE)));
			LOGGER.logDebug("Voy a enviar CREDITCODE:  " + Integer.valueOf(row.get(Applications.CREDITCODE)));
			
			LOGGER.logDebug("Ingresa A reprintClientOfTeam RowSelection Data>> 85");
			reprintClientOfTeam(args, row.get(Applications.CREDITCODE));
			LOGGER.logDebug("finaliza A reprintClientOfTeam RowSelection Data>>87");
			
			serviceRequestDocumentsTO.getData().put(INDOCUMENTSREQUEST, documentsRequest);
			serviceRequestDocumentsTO.getData().put(OUTDOCUMENTSRESPONSE, documentsResponse);
			serviceResponseDocument = execute(getServiceIntegration(), LOGGER, SERVICESEARCHDOCUMENTS, serviceRequestDocumentsTO);
			if (serviceResponseDocument.isResult()) {
				serviceResponseDocumentsTO = (ServiceResponseTO) serviceResponseDocument.getData();
				DocumentsResponse[] documentsResponseList = (DocumentsResponse[]) serviceResponseDocumentsTO.getValue(RETURNDOCUMENTSRESPONSE);
				DataEntityList documentsEntity = new DataEntityList();
				
				LOGGER.logDebug("Valores del GetData con lista " +  documentsResponseList.length );
				
				/* Consumo de servicio de contador de impresion de documentos */
				DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
				DocumentsApplicationResponseList documentsApplicationResponse = new DocumentsApplicationResponseList();
				ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
				ServiceResponse serviceResponseDocumentsApplication = null;
				ServiceResponseTO serviceResponseDocumentsApplictionTO = null;

				documentsApplicationRequest.setIdRequested(Integer.valueOf(row.get(Applications.CREDITCODE)));
				
				LOGGER.logDebug("Segundo servicio ");
				
				serviceRequestDocumentsApplicationTO.getData().put(INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
				serviceRequestDocumentsApplicationTO.getData().put(OUTDOCUMENTSAPPLICATIONRESPONSE, documentsApplicationResponse);
				serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, SERVICESEARCHDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);
				if (serviceResponseDocumentsApplication.isResult()) {
					
					LOGGER.logDebug("Entra a  serviceResponseDocumentsApplication.isResult()");
					
					serviceResponseDocumentsApplictionTO = (ServiceResponseTO) serviceResponseDocumentsApplication.getData();
					DocumentsApplicationResponse[] documentsApplicationResponseList = (DocumentsApplicationResponse[]) serviceResponseDocumentsApplictionTO.getValue(RETURNDOCUMENTSAPPLICATIONRESPONSE);
					request.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);

					if (documentsApplicationResponseList.length > 0) {
						LOGGER.logDebug("La lista si tiene valores ");
						for (DocumentsResponse documentResponse : documentsResponseList) {
							LOGGER.logDebug("Entra a  documentsResponseList con valores");
							DataEntity document = new DataEntity();
							boolean addRow = false;
							String uno = "";
							String dos = "";

							for (DocumentsApplicationResponse documentApplicationResponse : documentsApplicationResponseList) {

								uno = String.valueOf(documentResponse.getIdDocument());
								dos = String.valueOf(documentApplicationResponse.getIdDocument());
								if (uno.equals(dos)) {
									document.set(DocumentProduct.DOCUMENT, documentResponse.getIdDocument().toString());
									document.set(DocumentProduct.YESNOT, false);
									document.set(DocumentProduct.NEMONIC, documentResponse.getMnemonico());
									document.set(DocumentProduct.DESCRIPTION, documentResponse.getDescription());
									document.set(DocumentProduct.TEMPLATE, documentResponse.getTemplate());
									document.set(DocumentProduct.NROIMPRESSIONS, documentApplicationResponse.getNumber().toString());
									addRow = true;
								}
							}
							if (addRow == true) {
								documentsEntity.add(document);
							}
							LOGGER.logDebug("EL DOCUMENTO: " + documentResponse.getIdDocument().toString());
						}
						request.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);
					} else {
						LOGGER.logDebug("+++++7: ");
					}
				}
			}
			
		} catch (Exception e) {
			LOGGER.logDebug("Error dentro de reprintdocument: " + e);
		}
		
	}
	/**
	 * consultingClient with security medical
	 * @param entities
	 * @param idProcess
	 * @throws Exception
	 */
	public void reprintClientOfTeam(IGridRowActionEventArgs args,String idProcess) throws Exception {
		if (LOGGER.isDebugEnabled()) 
			LOGGER.logDebug(">>>>>>>>>>Starting of calling reprintClientOfTeam>>>>>165>>>>"+idProcess);
		DataEntityList clientOfTeamReprint = new DataEntityList();
		DynamicRequest request = args.getDynamicRequest();
		//request.setEntityList(PrintClientsTeam.ENTITY_NAME, clientOfTeamReprint);
		
		ReprintClientTeamServices reprintClientTeamServices=new ReprintClientTeamServices(getServiceIntegration());
		ConsultingClientTeamResponse[] responseDataClient= reprintClientTeamServices.consultingClientOfteams(idProcess, getServiceIntegration());
		if(responseDataClient!=null && responseDataClient.length>0) {
			for (ConsultingClientTeamResponse clientOfTeamReprintServices : responseDataClient) {				
				if(clientOfTeamReprintServices.getTypeSecure()!=null && !clientOfTeamReprintServices.getTypeSecure().isEmpty()) {
					DataEntity clientDataResult = new DataEntity();
					clientDataResult.set(PrintClientsTeam.OPERATION, clientOfTeamReprintServices.getOperation());
					clientDataResult.set(PrintClientsTeam.IDBANK, clientOfTeamReprintServices.getIdBank());
					clientDataResult.set(PrintClientsTeam.IDCLIENT, clientOfTeamReprintServices.getIdclient());
					clientDataResult.set(PrintClientsTeam.DATESTART, clientOfTeamReprintServices.getDateStart());
					clientDataResult.set(PrintClientsTeam.DATEEND, clientOfTeamReprintServices.getDateEnd());
					clientDataResult.set(PrintClientsTeam.AMOUNT, clientOfTeamReprintServices.getAmount());
					clientDataResult.set(PrintClientsTeam.STATUSCLIENT, String.valueOf(clientOfTeamReprintServices.getStatus()));
					clientDataResult.set(PrintClientsTeam.DATEREPORT, clientOfTeamReprintServices.getDateReport());
					clientDataResult.set(PrintClientsTeam.IDPROCESS, clientOfTeamReprintServices.getIdProcess());
					clientDataResult.set(PrintClientsTeam.IDTEAM, clientOfTeamReprintServices.getIdTeam());
					clientDataResult.set(PrintClientsTeam.AMOUNTPAID, clientOfTeamReprintServices.getAmountPaid());
					clientDataResult.set(PrintClientsTeam.AMOUNTRETURNED, clientOfTeamReprintServices.getAmountReturned());
					clientDataResult.set(PrintClientsTeam.FORMPAID, clientOfTeamReprintServices.getFormPaid());
					clientDataResult.set(PrintClientsTeam.TYPESECURE, clientOfTeamReprintServices.getTypeSecure());
					clientOfTeamReprint.add(clientDataResult);
				}
			}
			
			if (LOGGER.isDebugEnabled()) 
				LOGGER.logDebug(" *****SIZE ARRAY>>>>>194>>>"+clientOfTeamReprint.size());
			request.setEntityList(PrintClientsTeam.ENTITY_NAME, clientOfTeamReprint);
		}
		
		if (LOGGER.isDebugEnabled()) 
			LOGGER.logDebug(" *****END of calling reprintClientOfTeam>>>>>345");
	}
	
}

