package com.cobis.cloud.sofom.operationsexecution.santander.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobis.cloud.sofom.operationsexecution.santander.dto.ProcedureEntityResponseDTO;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.cts.services.orchestrator.IServiceOrchestrator;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

public class SPUtil {
	private static final ILogger LOGGER = LogFactory.getLogger(SPUtil.class);

	protected static final String SP_EXECUTOR_FILTER_FIELD = "SPExecutorServiceFactoryFilter";
	protected static final String SP_EXECUTOR_FILTER_VALUE = "(service.impl=object)";

	public static IProcedureRequest addHeaderToStoreProcedure(String sessionId, String contextId, String backendId, String spName, String trn) {

		IProcedureRequest procedureRequest = new ProcedureRequestAS();
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_STRING_TYPE, trn);
		procedureRequest.addFieldInHeader("isFormatterEnabled", ICOBISTS.HEADER_STRING_TYPE, "false");
		procedureRequest.addFieldInHeader(SP_EXECUTOR_FILTER_FIELD, ICOBISTS.HEADER_STRING_TYPE, SP_EXECUTOR_FILTER_VALUE);
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_CONTEXT_ID, ICOBISTS.HEADER_STRING_TYPE, contextId);
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_BACK_END_ID, ICOBISTS.HEADER_STRING_TYPE, backendId);
		procedureRequest.setSpName(spName);
		return procedureRequest;
	}

	public static List<ProcedureEntityResponseDTO> mapProcedureEntityResponse(IProcedureResponse procedureResponse, String columnEntityId, String procedureNumber)
			throws BusinessException {
		List<ProcedureEntityResponseDTO> procedureEntityResponses = new ArrayList<ProcedureEntityResponseDTO>();
		if (procedureResponse.getReturnCode() != 0) {
			if (procedureResponse.hasError()) {
				LOGGER.logError("Error " + procedureResponse.getErrors());
			}
			throw new BusinessException(procedureResponse.getReturnCode(), "Error: Error en Job al consultar.");
		}

		Iterator it = procedureResponse.getResultSets().iterator();

		while (it.hasNext()) {
			IResultSetBlock rs = (IResultSetBlock) it.next();

			for (int j = 1; j <= rs.getData().getRowsNumber(); j++) {
				ProcedureEntityResponseDTO procedureEntityResponseDTO = new ProcedureEntityResponseDTO();
				LOGGER.logDebug("rs.getMetaData():" + rs.getMetaData());
				for (int i = 1; i <= rs.getMetaData().getColumnsNumber(); i++) {
					LOGGER.logDebug("rs.getMetaData().getColumnMetaData(i): " + rs.getMetaData().getColumnMetaData(i));
					int type = rs.getMetaData().getColumnMetaData(i).getType();
					String name = rs.getMetaData().getColumnMetaData(i).getName();
					String value = rs.getData().getRow(j).getRowData(i).getValue();
					LOGGER.logDebug("value: " + value);
					if (columnEntityId.equals(name)) {
						LOGGER.logDebug(columnEntityId);
						procedureEntityResponseDTO.setEntityId(value == null ? null : Integer.valueOf(value));
					} else if (procedureNumber.equals(name)) {
						LOGGER.logDebug(procedureNumber);
						procedureEntityResponseDTO.setProcedureNumber(value == null ? null : Integer.valueOf(value));
					}

				}
				procedureEntityResponses.add(procedureEntityResponseDTO);

			}

		}
		return procedureEntityResponses;
	}

	public static OrchestrationClientValidationResponse executeService(Integer customerId, String sessionId, String contextId, IServiceOrchestrator servOrchestator,
			String serviceId, String input, String output) throws Exception {

		try {
			ServiceRequest serviceRequest = new ServiceRequest();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			serviceRequest.setValueFieldInHeader("sessionId", sessionId);
			serviceRequest.addFieldInHeader(ICOBISTS.HEADER_SERVICE_ID, ICOBISTS.HEADER_STRING_TYPE, serviceId);
			serviceRequest.setValueFieldInHeader("contextId", contextId);

			ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
			ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
			validationProspectRequest.setCustomerId(customerId);
			validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);
			serviceRequestTO.addValue(input, validationProspectServiceRequest);
			LOGGER.logDebug("servOrchestator>>" + servOrchestator);
			LOGGER.logDebug("serviceRequest>>" + serviceRequest);
			LOGGER.logDebug("serviceRequestTO>>" + serviceRequestTO);
			LOGGER.logInfo("serviceResponseTO");
			ServiceResponseTO serviceResponseTO = servOrchestator.execute(serviceRequest, serviceRequestTO, null);
			LOGGER.logInfo(" despues serviceResponseTO");
			if (serviceResponseTO.isSuccess()) {
				LOGGER.logInfo(" serviceResponseTO ok");

				return (OrchestrationClientValidationResponse) serviceResponseTO.getValue(output);
			}

			LOGGER.logInfo(" serviceResponseTO error1");
			List<MessageTO> errorMessages = (List<MessageTO>) serviceResponseTO.getMessages();
			StringBuilder messages = new StringBuilder();
			LOGGER.logInfo(" serviceResponseTO error2");
			for (MessageTO messageTO : errorMessages) {
				LOGGER.logInfo(" messageTO.getMessage()..." + messageTO.getMessage());
				messages.append(messageTO.getMessage());

			}

			return null;
		} catch (Exception ex) {
			LOGGER.logError("Exception executeService in OrchestrationClientValidationResponse", ex);
			throw ex;
		}

	}
}
