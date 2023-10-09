package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;

import com.cobiscorp.cobis.assets.commons.services.Documents;
import com.cobiscorp.cobis.assets.commons.services.DocumentsService;
import com.cobiscorp.cobis.assts.model.QueryDocumentCredit;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


public class SearchDocumentsCredit extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocumentsCredit.class);
	
	public SearchDocumentsCredit(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		
		LOGGER.logDebug("Ingreso executeQuery SearchDocumentsCredit");

		DataEntityList lista = new DataEntityList();
	    DataEntity documentos = new DataEntity();
	    QueryDocumentsRequest queryDocuments = new QueryDocumentsRequest();
		try {
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());

			//Seteo de campos
			int processInstance = (arg0.getData().get("processInstance")!=null) ? ((Integer)arg0.getData().get("processInstance")):0;
			if(arg0.getData().get("processInstance")!=null){
				queryDocuments.setProcessInstance(processInstance);
				LOGGER.logDebug("processInstance: "+queryDocuments.getProcessInstance());
			}
			LOGGER.logDebug("processInst: "+queryDocuments.getProcessInstance());
			//queryDocuments.setClientId((Integer)arg0.getData().get("customerId"));
			queryDocuments.setOption("F");
			
			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Miembro del grupo");
			DocumentsService memberManager = new DocumentsService(getServiceIntegration());
							
			QueryDocumentsResponse[] scannedDocumentsResponses = memberManager.queryDocumentsCredit(queryDocuments);

			if (scannedDocumentsResponses != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (QueryDocumentsResponse documents : scannedDocumentsResponses) {
					documentos = new DataEntity();

					String nameDocAux = "";
					
					if (documents.getName() != null){
						String str=documents.getName().trim();
						LOGGER.logDebug("NombreDocumento: " + str);
						
						int indexFin = str.indexOf(".");
						
						nameDocAux = str.substring(0, indexFin);
						LOGGER.logDebug("nameDocAux: " + nameDocAux);						
						
					}
				
					documentos.set(QueryDocumentCredit.DOCUMENTID, nameDocAux);
					documentos.set(QueryDocumentCredit.EXTENSION, documents.getName()); //Nombre del documento
					documentos.set(QueryDocumentCredit.UPLOADED, documents.getLoaded());
					documentos.set(QueryDocumentCredit.DESCRIPTION, documents.getDocumentDescription());
					documentos.set(QueryDocumentCredit.PROCESSINSTANCE, processInstance);
					documentos.set(QueryDocumentCredit.FOLDER, "Inbox");
					documentos.set(QueryDocumentCredit.ENABLEEDITING, documents.getEnableEditing());
									
					lista.add(documentos);
					LOGGER.logDebug("Documento: "+documents.getDocumentId());
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos del cliente-->", e);
		}
		return lista.getDataList();
		
	}
}
