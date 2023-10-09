package com.cobiscorp.cobis.loans.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsResponse;

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

public class SearchDocumentsInd extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocumentsInd.class);

	public SearchDocumentsInd(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Ingreso executeQuery SearchDocument clientes");

		DataEntityList lista = new DataEntityList();
		DataEntity documentos = new DataEntity();
		ScannedDocumentsRequest memberRequest = new ScannedDocumentsRequest();
		try {
			// Seteo del código del Grupo
			LOGGER.logDebug("data: " + arg0.getData().toString());

			// Seteo de campos
			//int customerId = (Integer) arg0.getData().get("customerId");
			memberRequest.setCustomerId(Integer.valueOf((String)arg0.getData().get("customerId")));
			memberRequest.setProcessInst(0);// Es 0 porque para personas naturales no se tiene una instancia de proceso
			memberRequest.setMode(4);// El modo 4 es para clientes individuales en Verificar y Digitalizar
			memberRequest.setGroupId(0);// Es 0 porque para personas individuales no tiene grupo
			//memberRequest.setCustomerId(customerId);

			LOGGER.logDebug("groupId: " + memberRequest.getGroupId());
			LOGGER.logDebug("customerId: " + memberRequest.getCustomerId());
			LOGGER.logDebug("processInst: " + memberRequest.getProcessInst());
			LOGGER.logDebug("mode: " + memberRequest.getMode());

			LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos por Cliente");
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
					documentos.set(ScannedDocumentsDetail.EXTENSION, documents.getExtension());
					documentos.set(ScannedDocumentsDetail.PROCESSINSTANCE, documents.getProcessInst());
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
