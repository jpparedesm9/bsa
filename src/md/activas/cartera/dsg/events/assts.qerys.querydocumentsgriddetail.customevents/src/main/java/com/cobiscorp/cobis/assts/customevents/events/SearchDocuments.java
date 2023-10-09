package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.assets.commons.services.DocumentsService;
import com.cobiscorp.cobis.assts.model.QueryDocumentGridDetail;
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


public class SearchDocuments extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocuments.class);
	
	public SearchDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		
		LOGGER.logDebug("Ingreso executeQuery SearchDocument");

		DataEntityList lista = new DataEntityList();
	    DataEntity documentos = new DataEntity();
	    QueryDocumentsRequest queryDocuments = new QueryDocumentsRequest();
		try {
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());

			//Seteo de campos
			queryDocuments.setProcessInstance((Integer)arg0.getData().get("processInstance"));
			queryDocuments.setClientId((Integer)arg0.getData().get("customerId"));
			LOGGER.logDebug("processInst: "+queryDocuments.getProcessInstance());
			
			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro del grupo");
			DocumentsService memberManager = new DocumentsService(getServiceIntegration());
			QueryDocumentsResponse[] scannedDocumentsResponses = memberManager.queryDocuments(queryDocuments);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (QueryDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();
					documentos.set(QueryDocumentGridDetail.DESCRIPTION, documents.getDocumentDescription());
					documentos.set(QueryDocumentGridDetail.UPLOADED, documents.getLoaded());
					documentos.set(QueryDocumentGridDetail.CUSTOMERID, documents.getClientId());
					documentos.set(QueryDocumentGridDetail.DOCUMENTID, documents.getDocumentId().trim());
					documentos.set(QueryDocumentGridDetail.PROCESSINSTANCE, queryDocuments.getProcessInstance());
					documentos.set(QueryDocumentGridDetail.GROUPID, documents.getGroupId());
					documentos.set(QueryDocumentGridDetail.EXTENSION, documents.getExtension());
					documentos.set(QueryDocumentGridDetail.FOLDER, "Customer");
					documentos.set(QueryDocumentGridDetail.ENABLEEDITING, documents.getEnableEditing());
					lista.add(documentos);
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos del grupo-->", e);
		}
		
		LOGGER.logDebug("Ingreso executeQuery SearchDocumentsInd");


	    QueryDocumentsRequest queryDocumentsInd = new QueryDocumentsRequest();
		try {
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());

			//Seteo de campos
			queryDocumentsInd.setProcessInstance(0); //Es 0 porque debe buscar los documentos individuales del cliente
			queryDocumentsInd.setClientId((Integer)arg0.getData().get("customerId"));
			LOGGER.logDebug("processInst: "+queryDocumentsInd.getProcessInstance());
			
			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro del grupo");
			DocumentsService memberManager = new DocumentsService(getServiceIntegration());
			QueryDocumentsResponse[] scannedDocumentsResponses = memberManager.queryDocumentsInd(queryDocumentsInd);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (QueryDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();
					documentos.set(QueryDocumentGridDetail.DESCRIPTION, documents.getDocumentDescription());
					documentos.set(QueryDocumentGridDetail.UPLOADED, documents.getLoaded());
					documentos.set(QueryDocumentGridDetail.CUSTOMERID, documents.getClientId());
					documentos.set(QueryDocumentGridDetail.DOCUMENTID, documents.getDocumentId().trim());
					documentos.set(QueryDocumentGridDetail.PROCESSINSTANCE, queryDocumentsInd.getProcessInstance());
					documentos.set(QueryDocumentGridDetail.GROUPID, documents.getGroupId());
					documentos.set(QueryDocumentGridDetail.EXTENSION, documents.getExtension());
					documentos.set(QueryDocumentGridDetail.FOLDER, "Customer");
					documentos.set(QueryDocumentGridDetail.ENABLEEDITING, documents.getEnableEditing());
					
					lista.add(documentos);
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos del cliente-->", e);
		}
		
		
		return lista.getDataList();
		
	}
}
