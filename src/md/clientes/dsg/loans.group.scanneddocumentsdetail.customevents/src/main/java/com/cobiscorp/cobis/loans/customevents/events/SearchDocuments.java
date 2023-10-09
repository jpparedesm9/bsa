package com.cobiscorp.cobis.loans.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.ScannedDocumentsDetail;
import com.cobiscorp.cobis.loans.services.Documents;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsResponse;

public class SearchDocuments extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocuments.class);
	private static final String TYPE_RENEWAL = "RENOVACION";

	public SearchDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Recupera documentos de proceso");

		DataEntityList lista = new DataEntityList();
		DataEntity documentos = new DataEntity();
		ScannedDocumentsRequest memberRequest = new ScannedDocumentsRequest();
		LOGGER.logDebug("data: " + arg0.getData().toString());
		
		//String typeR = (arg0.getData().get("typeRequest") != null) ? (String) arg0.getData().get("typeRequest") : "vacio";
		
		try {

			memberRequest.setMode(1);// El modo 1 es para grupos
			memberRequest.setCustomerId(Integer.valueOf((String) arg0.getData().get("customerId")));
			memberRequest.setGroupId(Integer.valueOf((String) arg0.getData().get("groupId")));
			memberRequest.setProcessInst(Integer.valueOf((String) arg0.getData().get("processInstance")));

			LOGGER.logDebug("getCustomerId: " + memberRequest.getCustomerId());
			LOGGER.logDebug("getGroupId: " + memberRequest.getGroupId());
			LOGGER.logDebug("getProcessInst: " + memberRequest.getProcessInst());
			LOGGER.logDebug("getMode: " + memberRequest.getMode());

			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro del grupo");
			Documents memberManager = new Documents(getServiceIntegration());
			ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequest, arg1);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (ScannedDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();
					documentos.set(ScannedDocumentsDetail.DESCRIPTION, documents.getDocumentType());
					documentos.set(ScannedDocumentsDetail.UPLOADED, documents.getLoaded());
					documentos.set(ScannedDocumentsDetail.CUSTOMERID, documents.getCustomerId());
					documentos.set(ScannedDocumentsDetail.DOCUMENTID, documents.getDocumentId().trim());
					documentos.set(ScannedDocumentsDetail.PROCESSINSTANCE, documents.getProcessInst());
					documentos.set(ScannedDocumentsDetail.GROUPID, documents.getGroupId());
					documentos.set(ScannedDocumentsDetail.EXTENSION, documents.getExtension());
					lista.add(documentos);
					LOGGER.logDebug("Documento: " + documents.getDocumentId());
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_GROUP, e, arg1, LOGGER);
		}

		LOGGER.logDebug("Recupera documentos de Clientes");

		ScannedDocumentsRequest memberRequestInd = new ScannedDocumentsRequest();
		try {

			memberRequestInd.setCustomerId(Integer.valueOf((String) arg0.getData().get("customerId")));
			memberRequestInd.setProcessInst(0);// Es 0 porque para personas naturales no se tiene una instancia de proceso
			memberRequestInd.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo
			// El modo 4 es para clientes individuales en Verificar y Digitalizar
			memberRequestInd.setMode(4);

			LOGGER.logDebug("groupId: " + memberRequestInd.getGroupId());
			LOGGER.logDebug("customerId: " + memberRequestInd.getCustomerId());
			LOGGER.logDebug("processInst: " + memberRequestInd.getProcessInst());
			LOGGER.logDebug("mode: " + memberRequestInd.getMode());

			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Cliente");
			Documents memberManager = new Documents(getServiceIntegration());
			ScannedDocumentsResponse[] scannedDocumentsResponses = memberManager.queryScannedDocuments(memberRequestInd, arg1);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (ScannedDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();
					documentos.set(ScannedDocumentsDetail.DESCRIPTION, documents.getDocumentType());
					documentos.set(ScannedDocumentsDetail.UPLOADED, documents.getLoaded());
					documentos.set(ScannedDocumentsDetail.CUSTOMERID, documents.getCustomerId());
					documentos.set(ScannedDocumentsDetail.DOCUMENTID, documents.getDocumentId().trim());
					documentos.set(ScannedDocumentsDetail.EXTENSION, documents.getExtension());
					documentos.set(ScannedDocumentsDetail.PROCESSINSTANCE, memberRequestInd.getProcessInst());
					lista.add(documentos);
					LOGGER.logDebug("Documento: " + documents.getDocumentId());
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_DOCUMENTS, e, arg1, LOGGER);
		}

		return lista.getDataList();

	}
}
