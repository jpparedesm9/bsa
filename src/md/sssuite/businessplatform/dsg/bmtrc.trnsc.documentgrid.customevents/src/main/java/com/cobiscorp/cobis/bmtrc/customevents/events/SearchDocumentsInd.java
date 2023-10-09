package com.cobiscorp.cobis.bmtrc.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.bmtrc.model.Document;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Constants;
import com.cobiscorp.cobis.busin.flcre.commons.services.DocumentManagement;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchDocumentsInd extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocumentsInd.class);

	public SearchDocumentsInd(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Ingreso executeQuery SearchDocumentsInd");

		DataEntityList lista = new DataEntityList();
		DataEntity documentos = new DataEntity();
		QueryDocumentsRequest queryDocuments = new QueryDocumentsRequest();
		try {
			LOGGER.logDebug("data: " + arg0.getData().toString());
			LOGGER.logDebug("dataCustomerId: " + arg0.getData().get("customerId"));

			// Seteo de campos
			queryDocuments.setProcessInstance(0); // Es 0 porque debe buscar los documentos individuales del cliente
			queryDocuments.setClientId((Integer) arg0.getData().get("customerId"));
			LOGGER.logDebug("processInst: " + queryDocuments.getProcessInstance());
			LOGGER.logDebug("customerId: " + queryDocuments.getClientId());

			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro");
			DocumentManagement memberManager = new DocumentManagement(getServiceIntegration());
			QueryDocumentsResponse[] scannedDocumentsResponses = memberManager.queryDocumentsInd(queryDocuments);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (QueryDocumentsResponse documents : scannedDocumentsResponses) {
					LOGGER.logDebug("documentId: " + documents.getDocumentId());
					LOGGER.logDebug("DOCUMENTO_PROBATORIO_ANVERSO: " + Constants.DOCUMENTO_PROBATORIO_ANVERSO);
					if (Constants.DOCUMENTO_PROBATORIO_ANVERSO.equals(documents.getDocumentId().trim())) {
						LOGGER.logDebug("Entra documento: " + documents.getDocumentId());
						documentos = new DataEntity();
						documentos.set(Document.DESCRIPTION, documents.getDocumentDescription());
						documentos.set(Document.UPLOADED, documents.getLoaded());
						documentos.set(Document.CUSTOMERID, documents.getClientId());
						documentos.set(Document.DOCUMENTID, documents.getDocumentId().trim());
						documentos.set(Document.PROCESSINSTANCE, queryDocuments.getProcessInstance());
						documentos.set(Document.GROUPID, documents.getGroupId());
						documentos.set(Document.EXTENSION, documents.getExtension());
						documentos.set(Document.FOLDER, "Customer");

						lista.add(documentos);
					}
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los documentos del cliente-->", e);
		}
		return lista.getDataList();
	}
}
