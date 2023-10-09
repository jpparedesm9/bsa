package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.services.DocumentsService;
import com.cobiscorp.cobis.assts.model.QueryDocumentCredit;
import com.cobiscorp.cobis.assts.model.QueryDocumentIndividualGridDetail;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


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
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());

			//Seteo de campos
			queryDocuments.setProcessInstance(0); //Es 0 porque debe buscar los documentos individuales del cliente
			queryDocuments.setClientId((Integer)arg0.getData().get("customerId"));
			LOGGER.logDebug("processInst: "+queryDocuments.getProcessInstance());
			
			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro del grupo");
			DocumentsService memberManager = new DocumentsService(getServiceIntegration());
			QueryDocumentsResponse[] scannedDocumentsResponses = memberManager.queryDocumentsInd(queryDocuments);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (QueryDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();
					documentos.set(QueryDocumentIndividualGridDetail.DESCRIPTION, documents.getDocumentDescription());
					documentos.set(QueryDocumentIndividualGridDetail.UPLOADED, documents.getLoaded());
					documentos.set(QueryDocumentIndividualGridDetail.CUSTOMERID, documents.getClientId());
					documentos.set(QueryDocumentIndividualGridDetail.DOCUMENTID, documents.getDocumentId().trim());
					documentos.set(QueryDocumentIndividualGridDetail.PROCESSINSTANCE, queryDocuments.getProcessInstance());
					documentos.set(QueryDocumentIndividualGridDetail.GROUPID, documents.getGroupId());
					documentos.set(QueryDocumentIndividualGridDetail.EXTENSION, documents.getExtension());
					documentos.set(QueryDocumentIndividualGridDetail.FOLDER, "Customer");
						
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
