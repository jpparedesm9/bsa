package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.credit.report.validation.dto.ValidationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.ValidatePrintService;
import com.cobiscorp.cobis.busin.flcre.commons.services.WorkflowManagement;
import com.cobiscorp.cobis.busin.model.DocumentProduct;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandPrint extends BaseEvent implements IExecuteCommand {
	
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandPrint.class);

	public ExecuteCommandPrint(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
	
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>ExecuteCommandPrint Inicio:>:>");
			}
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList documentsApplicationEntityList = new DataEntityList();
			documentsApplicationEntityList = entities.getEntityList(DocumentProduct.ENTITY_NAME);
			entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsApplicationEntityList);

			//ValidationResponse validationPrint = getInfoValidatePrint(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)), arg1, new BehaviorOption());
			String valueState = "";
			int maxImpress = 1;
			
			//if (validationPrint != null) {			
			//	valueState = validationPrint.getDesEstado();
			//}

			String nameDocState = "";
			String nameDocMax = "";

			for (DataEntity dataEntity : documentsApplicationEntityList) {
				if (dataEntity.get(DocumentProduct.YESNOT) == true) {
					String maxImpresion = "100";
					//CAME
					//executeRule(dataEntity.get(DocumentProduct.NEMONIC), valueState, arg1, new BehaviorOption(true));
					if (maxImpresion!=null ) {
						maxImpress = Integer.parseInt(maxImpresion);
						int nroImpressions = Integer.parseInt(dataEntity.get(DocumentProduct.NROIMPRESSIONS));
						
						if (nroImpressions < maxImpress) {
							
							DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();

							documentsApplicationRequest.setIdDocument(Integer.parseInt(dataEntity.get(DocumentProduct.DOCUMENT)));
							documentsApplicationRequest.setIdRequested(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));

							ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
							ServiceResponse serviceResponseDocumentsApplication = null;

							serviceRequestDocumentsApplicationTO.getData().put(RequestName.INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
							serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICEUPDATEDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);

							List<Message> errorMessage = new ArrayList<Message>();
							if (serviceResponseDocumentsApplication.isResult()) {
								arg1.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_SUUPRINTG_25476");
								arg1.setSuccess(true);
							} else {
								arg1.setSuccess(false);
								errorMessage = serviceResponseDocumentsApplication.getMessages();
								for (Message message : errorMessage) {
									arg1.getMessageManager().showErrorMsg(message.getMessage() + "/n");
								}
							}
						} else {
							
							dataEntity.set(DocumentProduct.YESNOT, false);
					
							if ("".equals(nameDocMax)) {
								nameDocMax = nameDocMax + dataEntity.get(DocumentProduct.NEMONIC);
							} else {
								nameDocMax = nameDocMax + ", " + dataEntity.get(DocumentProduct.NEMONIC);
							}
						}
					} else {
				
						dataEntity.set(DocumentProduct.YESNOT, false);
						
						if ("".equals(nameDocState)) {
							nameDocState = nameDocState + dataEntity.get(DocumentProduct.NEMONIC);
						} else {
							nameDocState = nameDocState + ", " + dataEntity.get(DocumentProduct.NEMONIC);
						}
					}
				}
			}
			if (!nameDocState.equals("")) {
				arg1.getMessageManager().showInfoMsg("Estado de la operación no permitido para impresión de el(los) documento(s): " + nameDocState);
				arg1.setSuccess(true);
			}

			/*
			 * if (!nameDocMax.equals("")) { arg1.getMessageManager().showInfoMsg("Excede el máximo número de impresiones, el(los) documento(s): " + nameDocMax); arg1.setSuccess(true); }
			 */
		
			DocumentsRequest documentsRequest = new DocumentsRequest();
			ServiceRequestTO serviceRequestDocumentsTO = new ServiceRequestTO();
			ServiceResponse serviceResponseDocument = null;
			ServiceResponseTO serviceResponseDocumentsTO = null;

			documentsRequest.setMode(0);
			documentsRequest.setSubOption(1);
			documentsRequest.setType(originalHeader.get(OriginalHeader.TYPEREQUEST));
			documentsRequest.setRequest(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
			documentsRequest.setTypeOperation(originalHeader.get(OriginalHeader.PRODUCTTYPE));
			LOGGER.logDebug(":>:>TIPO DE OPERACION:>:>"+documentsRequest.getTypeOperation());
			serviceRequestDocumentsTO.getData().put(RequestName.INDOCUMENTSREQUEST, documentsRequest);
			serviceResponseDocument = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICESEARCHDOCUMENTS, serviceRequestDocumentsTO);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>ExecuteCommandPrint consulta de documentos:>:>");
			}
			if (serviceResponseDocument.isResult()) {
				serviceResponseDocumentsTO = (ServiceResponseTO) serviceResponseDocument.getData();
				DocumentsResponse[] documentsResponseList = (DocumentsResponse[]) serviceResponseDocumentsTO.getValue(ReturnName.DOCUMENTS);
				DataEntityList documentsEntity = new DataEntityList();

				DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
				ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
				ServiceResponse serviceResponseDocumentsApplication = null;
				ServiceResponseTO serviceResponseDocumentsApplictionTO = null;

				documentsApplicationRequest.setIdRequested(Integer.valueOf(originalHeader.get(OriginalHeader.IDREQUESTED)));
				serviceRequestDocumentsApplicationTO.getData().put(RequestName.INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
				serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, ServiceId.ARCHDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);
				if (serviceResponseDocumentsApplication.isResult()) {
					serviceResponseDocumentsApplictionTO = (ServiceResponseTO) serviceResponseDocumentsApplication.getData();
					DocumentsApplicationResponse[] documentsApplicationResponseList = (DocumentsApplicationResponse[]) serviceResponseDocumentsApplictionTO.getValue(ReturnName.DOCUMENTSAPPLICATION);

					for (DocumentsResponse documentResponse : documentsResponseList) {
						if (documentResponse.getState() != null) {
							if (!documentResponse.getState().trim().equals("C")) {

						DataEntity document = new DataEntity();
						document.set(DocumentProduct.DOCUMENT, documentResponse.getIdDocument().toString());
						document.set(DocumentProduct.NEMONIC, documentResponse.getMnemonico());
						document.set(DocumentProduct.DESCRIPTION, documentResponse.getDescription());
						document.set(DocumentProduct.TEMPLATE, documentResponse.getTemplate());
						document.set(DocumentProduct.NROIMPRESSIONS, "0");
						document.set(DocumentProduct.REPORTPARAMGUARANTOR, " ");
								
						for (DataEntity dataEntity : documentsApplicationEntityList) {
									//si DOCUMENT cambia por un secuencial ya no pinta un # mas despues de imprimir
									//por la validacion YESNOT==
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
							}
						}
								
						documentsEntity.add(document);
					}
						}
					}
					entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);
				}

			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>ExecuteCommandPrint Fin:>:>");
			}

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PRINTACTIVITY_EXECUTE_PRINT, ex, arg1, LOGGER);
		}

	}

	/***
	 * CONSULTA LOS PARAMETROS GENERALES (# DE IMPRESIONES Y ESTADO DE OPERACION) PARA VALIDACION DE IMPRESION
	 * 
	 * @param tramitNum
	 * @param arg1
	 * @param options
	 * @return
	 */
	public ValidationResponse getInfoValidatePrint(int tramitNum, ICommonEventArgs arg1, BehaviorOption options) {
		LOGGER.logDebug(" *****-- INICIO LLAMADA SERVICIO DE VALIDACION --> # TRAMITE " + tramitNum);
		ValidatePrintService validateServ = new ValidatePrintService(this.getServiceIntegration());
		ValidationResponse validationResponse = validateServ.getValidatePrint(tramitNum, arg1, options);
		LOGGER.logDebug(" *****-- RESULTADO SERVICIO DE VALIDACION --> " + validationResponse);
		return validationResponse;
	}

	/***
	 * Consulta la regla para verificar estado de la operación
	 * 
	 * @param tipoDocumento
	 * @param estado
	 * @param arg1
	 * @param options
	 * @return
	 */
	public String executeRule(String tipoDocumento, String estado, ICommonEventArgs arg1, BehaviorOption options) {

		try {

			VariableProcess variableResult = null;

			WorkflowManagement workflowManagement = new WorkflowManagement(getServiceIntegration());

			HashMap<String, Object> variables = new HashMap<String, Object>();

			variables.put("TIPO DE DOCUMENTO", tipoDocumento);
			variables.put("TIPO ESTADO", estado);

			List<RuleProcess> ruleProcessList = workflowManagement.executeRule("VALEST", variables, arg1, new BehaviorOption(true));

			if (ruleProcessList != null && !ruleProcessList.isEmpty()) {
				RuleProcess ruleProcess = ruleProcessList.get(0);
				for (VariableProcess variableProcess : ruleProcess.getVariableProcesses()) {
				
					if (Mnemonic.VARIABLE_NAME_RESULT_ESTADO.equals(variableProcess.getVariable().getNombreVariable())) {

						variableResult = variableProcess;
				
					}
				}
			}

			if (variableResult != null ) {

					return variableResult.getValue();
				
			}

		} catch (Exception e) {
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
			arg1.setSuccess(false);
			return null;
		}
		return null;
	}
}
