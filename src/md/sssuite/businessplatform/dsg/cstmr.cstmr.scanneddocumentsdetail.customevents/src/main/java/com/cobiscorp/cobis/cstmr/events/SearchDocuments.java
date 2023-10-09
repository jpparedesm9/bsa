package com.cobiscorp.cobis.cstmr.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.ScannedDocumentsDetail;
import com.cobiscorp.cobis.cstmr.services.Documents;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchDocuments extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocuments.class);
	private static final String TYPE_COLLECTIVE = "COLECTIVO";
	private static final String TYPE_RENEWAL= "RENOVACION";

	public SearchDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Ingreso executeQuery SearchDocument");
		String origen = null;
		String sinHuellaDactilar = null;
		if (arg1.getParameters().getCustomParameters() != null && (arg1.getParameters().getCustomParameters().get("origen") != null)) {
			origen = arg1.getParameters().getCustomParameters().get("origen").toString();
		}
		LOGGER.logDebug("sin Huella" + arg1.getParameters().getCustomParameters().get("sinHuellaDactilar"));
		if (arg1.getParameters().getCustomParameters() != null && (arg1.getParameters().getCustomParameters().get("sinHuellaDactilar") != null)) {
			sinHuellaDactilar = arg1.getParameters().getCustomParameters().get("sinHuellaDactilar").toString();
		}

		LOGGER.logDebug(".get(origen): " + origen);
		DataEntityList lista = new DataEntityList();
		DataEntity documentos = new DataEntity();
		ScannedDocumentsRequest memberRequest = new ScannedDocumentsRequest();
		try {
			// Seteo del código del Grupo
			LOGGER.logDebug("data: " + arg0.getData().toString());

			// Seteo de campos
			int customerId = (Integer) arg0.getData().get("customerId");
			int processInstance = (arg0.getData().get("processInstance") != null) ? Integer.valueOf((String) arg0.getData().get("processInstance")) : 0;
			String typeR = (arg0.getData().get("typeRequest") != null) ? (String) arg0.getData().get("typeRequest") : "vacio";

			if (processInstance > 0) {
				LOGGER.logDebug("Ingreso executeQuery SearchDocument Flujo Individual");
				memberRequest.setProcessInst(processInstance);
				memberRequest.setCustomerId(customerId);
				memberRequest.setSinHuellaDactilar(sinHuellaDactilar);

				if (TYPE_COLLECTIVE.equals(typeR)) {
					memberRequest.setMode(6);// El modo 6 Colectivos
					Documents memberManager = new Documents(getServiceIntegration());
					ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequest, arg1);
					if (scannedDocumentsResponses != null) {
						LOGGER.logDebug("Entra a scannedDocumentsResponses");
						lista = getDocuments(scannedDocumentsResponses, lista);
					}
				} if (TYPE_RENEWAL.equals(typeR)) {
					int customerID = (Integer) arg0.getData().get("customerId");
					memberRequest.setMode(7);// El modo 7 Renovaciones
					memberRequest.setCustomerId(customerID);
					memberRequest.setGroupId(0);
					memberRequest.setProcessInst(processInstance);
					
					Documents memberManager = new Documents(getServiceIntegration());
					ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequest, arg1);
					if (scannedDocumentsResponses != null) {
						LOGGER.logDebug("Entra a scannedDocumentsResponses");
						lista = getDocuments(scannedDocumentsResponses, lista);
					}
				}else {
					// primera llamada
					memberRequest.setMode(3);// El modo 3 es para el flujo individual
					memberRequest.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo
					memberRequest.setOrigen(origen);

					LOGGER.logDebug("groupId: " + memberRequest.getGroupId());
					LOGGER.logDebug("customerId: " + memberRequest.getCustomerId());
					LOGGER.logDebug("processInst: " + memberRequest.getProcessInst());
					LOGGER.logDebug("mode: " + memberRequest.getMode());

					LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Cliente en el flujo");
					Documents memberManager = new Documents(getServiceIntegration());
					ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequest, arg1);

					if (scannedDocumentsResponses != null) {
						LOGGER.logDebug("Entra a scannedDocumentsResponses");
						lista = getDocuments(scannedDocumentsResponses, lista);
					}
					// segunda llamada
					LOGGER.logDebug("Recupera documentos de Clientes que fueron llenados en Mantenimiento");

					ScannedDocumentsRequest memberRequestInd = new ScannedDocumentsRequest();
					// Seteo del código del Grupo
					LOGGER.logDebug("data: " + arg0.getData().toString());

					int customerId1 = (Integer) arg0.getData().get("customerId");
					// Seteo de campos
					// int customerId = (Integer) arg0.getData().get("customerId");
					memberRequestInd.setCustomerId(customerId1);
					memberRequestInd.setProcessInst(0);// Es 0 porque para personas naturales no se tiene una instancia de proceso
					memberRequestInd.setMode(4);// El modo 4 es para clientes individuales en Verificar y Digitalizar
					memberRequestInd.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo
					// memberRequest.setCustomerId(customerId);

					LOGGER.logDebug("groupId: " + memberRequestInd.getGroupId());
					LOGGER.logDebug("customerId: " + memberRequestInd.getCustomerId());
					LOGGER.logDebug("processInst: " + memberRequestInd.getProcessInst());
					LOGGER.logDebug("mode: " + memberRequestInd.getMode());

					LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Cliente en el flujo");
					Documents memberManager1 = new Documents(getServiceIntegration());
					ScannedDocumentsResponse[] scannedDocumentsResponses1 = memberManager1.queryScannedDocuments(memberRequestInd, arg1);

					if (scannedDocumentsResponses1 != null) {
						LOGGER.logDebug("Entra a scannedDocumentsResponses");
						lista = getDocuments(scannedDocumentsResponses1, lista);
					}
					// tercera llamada
					LOGGER.logDebug("Recupera documentos de Clientes del aval");

					ScannedDocumentsRequest memberRequestAval = new ScannedDocumentsRequest();
					// Seteo del código del Grupo
					LOGGER.logDebug("data: " + arg0.getData().toString());

					memberRequestAval.setProcessInst(processInstance);
					memberRequestAval.setCustomerId(customerId);
					memberRequestAval.setMode(5);// El modo 5 es para los documentos del Aval
					memberRequestAval.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo

					LOGGER.logDebug("groupId: " + memberRequestInd.getGroupId());
					LOGGER.logDebug("customerId: " + memberRequestInd.getCustomerId());
					LOGGER.logDebug("processInst: " + memberRequestInd.getProcessInst());
					LOGGER.logDebug("mode: " + memberRequestInd.getMode());

					LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por el aval");
					Documents memberManager2 = new Documents(getServiceIntegration());
					ScannedDocumentsResponse[] scannedDocumentsResponses2 = memberManager2.queryScannedDocuments(memberRequestAval, arg1);

					if (scannedDocumentsResponses2 != null) {
						LOGGER.logDebug("Entra a scannedDocumentsResponses");
						lista = getDocuments(scannedDocumentsResponses2, lista);
					}

				}
			} else {
				memberRequest.setProcessInst(0);// Es 0 porque para personas naturales no se tiene una instancia de proceso
				memberRequest.setMode(2);// El modo 2 es para clientes individuales

				// primera llamada
				memberRequest.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo
				memberRequest.setCustomerId(customerId);
				memberRequest.setOrigen(origen);
				memberRequest.setSinHuellaDactilar(sinHuellaDactilar);
				LOGGER.logDebug("groupId: " + memberRequest.getGroupId());
				LOGGER.logDebug("customerId: " + memberRequest.getCustomerId());
				LOGGER.logDebug("processInst: " + memberRequest.getProcessInst());
				LOGGER.logDebug("mode: " + memberRequest.getMode());

				LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Cliente en el flujo");
				Documents memberManager = new Documents(getServiceIntegration());
				ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequest, arg1);

				if (scannedDocumentsResponses != null) {
					LOGGER.logDebug("Entra a scannedDocumentsResponses");
					lista = getDocuments(scannedDocumentsResponses, lista);
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_DOCUMENTS, e, arg1, LOGGER);
		}

		return lista.getDataList();

	}

	private DataEntityList getDocuments(ScannedDocumentsResponse[] scannedDocumentsResponses, DataEntityList listaDocumentos) {

		for (ScannedDocumentsResponse documents : scannedDocumentsResponses) {
			DataEntity documento = new DataEntity();
			documento.set(ScannedDocumentsDetail.DESCRIPTION, documents.getDocumentType());
			documento.set(ScannedDocumentsDetail.UPLOADED, documents.getLoaded());
			documento.set(ScannedDocumentsDetail.CUSTOMERID, documents.getCustomerId());
			documento.set(ScannedDocumentsDetail.DOCUMENTID, documents.getDocumentId().trim());
			documento.set(ScannedDocumentsDetail.EXTENSION, documents.getExtension());
			documento.set(ScannedDocumentsDetail.PROCESSINSTANCE, documents.getProcessInst());
			listaDocumentos.add(documento);
			LOGGER.logDebug("Documento: " + documents.getDocumentId());
		}
		return listaDocumentos;
	}
}
