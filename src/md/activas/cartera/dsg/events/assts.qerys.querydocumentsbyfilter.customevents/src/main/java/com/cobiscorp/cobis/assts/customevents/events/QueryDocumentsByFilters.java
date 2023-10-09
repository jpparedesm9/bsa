package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.DocumentFilterRequest;
import cobiscorp.ecobis.assets.cloud.dto.DocumentFilterResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ResultQueryByFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QueryDocumentsByFilters extends BaseEvent implements IExecuteQuery {
	private static final ILogger LOGGER = LogFactory.getLogger(QueryDocumentsByFilters.class);

	public QueryDocumentsByFilters(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeDataEvent clase QueryDocumentsByFilters");
		}

		Map<String, Object> headerQueryDocuments = entities.getData();
		DataEntityList results = new DataEntityList();
		ServiceRequestTO request = new ServiceRequestTO();

		// Filtros
		DocumentFilterRequest documentFilterRequest = new DocumentFilterRequest();
		LOGGER.logDebug("headerQueryDocuments: " + headerQueryDocuments);

		documentFilterRequest.setClientId(headerQueryDocuments.get("clientId") == null || "".equals(String.valueOf(headerQueryDocuments.get("clientId")).trim()) ? null : Integer
				.valueOf(String.valueOf(headerQueryDocuments.get("clientId"))));

		documentFilterRequest.setClientType(headerQueryDocuments.get("clientType") == null || "".equals(String.valueOf(headerQueryDocuments.get("clientType")).trim()) ? null
				: String.valueOf(headerQueryDocuments.get("clientType")).charAt(0));

		String documentTypeCode = headerQueryDocuments.get("codDocumentType") == null || "".equals(String.valueOf(headerQueryDocuments.get("codDocumentType")).trim()) ? null
				: String.valueOf(headerQueryDocuments.get("codDocumentType"));
		if (documentTypeCode != null) {
			documentFilterRequest.setDocumentType(documentTypeCode.substring(0, documentTypeCode.indexOf("-")));
			documentFilterRequest.setModule(documentTypeCode.substring(documentTypeCode.indexOf("-") + 1, documentTypeCode.length()));
		}
		documentFilterRequest.setLoanNumber(headerQueryDocuments.get("loanNumber") == null || "".equals(String.valueOf(headerQueryDocuments.get("loanNumber")).trim()) ? null
				: String.valueOf(headerQueryDocuments.get("loanNumber")));

		documentFilterRequest.setProcedureNumber(headerQueryDocuments.get("procedureNumber") == null
				|| "".equals(String.valueOf(headerQueryDocuments.get("procedureNumber")).trim()) ? null : Integer.valueOf(String.valueOf(headerQueryDocuments
				.get("procedureNumber"))));
		try {
			request.addValue(Parameter.REQUESTDOCUMENTFILTER, documentFilterRequest);

			ServiceResponse response = this.execute(getServiceIntegration(), LOGGER, Parameter.QUERYDOCUMENTSBYFILTER, request);
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {
					DocumentFilterResponse[] documents = (DocumentFilterResponse[]) resultado.getValue(Parameter.RETURNDOCUMENTFILTER);
					if (documents != null && documents.length > 0) {

					for (DocumentFilterResponse document : documents) {
							if (document != null) {
						DataEntity result = new DataEntity();
						result.set(ResultQueryByFilter.CLIENTID, document.getClientId());
						result.set(ResultQueryByFilter.CLIENTGROUPNAME, document.getClientName());
						result.set(ResultQueryByFilter.CLIENTTYPE, document.getClientType());
						result.set(ResultQueryByFilter.DOCUMENTTYPE, document.getDocumentType());
						result.set(ResultQueryByFilter.CODDOCUMENTTYPE, document.getCodDocumentType());
						result.set(ResultQueryByFilter.ENTRYDATE, document.getEntryDate() == null ? null : document.getEntryDate().getTime());
						result.set(ResultQueryByFilter.LOANNUMBER, document.getLoanNumber());
						result.set(ResultQueryByFilter.PROCEDURENUMBER, document.getProcedureNumber());
						result.set(ResultQueryByFilter.PROCESSID, document.getProcessId());
						result.set(ResultQueryByFilter.EXTENSION, document.getExtension());
						result.set(ResultQueryByFilter.FOLDER, document.getFolder());
						result.set(ResultQueryByFilter.DOCUMENTNAME, document.getDocumentName());
								result.set(ResultQueryByFilter.GROUPID, document.getGroupId());
						results.add(result);
					}
						}

				}
			}
			}
		} catch (Exception ex) {
			args.setSuccess(false);
			LOGGER.logError("Error en la clase QueryDocumentsByFilters: ", ex);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza executeDataEvent clase QueryDocumentsByFilters");
			}
		}

		return results.getDataList();
	}
}
