package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.extractValue;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businesstobusiness.dto.OperationRequest;
import cobiscorp.ecobis.businesstobusiness.dto.OperationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.common.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.dto.OperationResponseDTO;
import com.cobiscorp.ecobis.cloud.service.util.Constants;

public class OperationIntegration extends RestServiceBase {
	private final ILogger LOGGER = LogFactory.getLogger(OperationIntegration.class);
	private final String className = "[OperationIntegration] ";

	public OperationIntegration(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	public List<OperationResponseDTO> searchOperations(Integer clientGroupCode, String type, String correspondent) throws Exception {
		List<OperationResponseDTO> result = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start searchOperations in " + className);
		}
		try {
			OperationRequest operationRequest = new OperationRequest();
			operationRequest.setCustomerGroupId(clientGroupCode);
			operationRequest.setCustomerGroupType(type);
			operationRequest.setCorrespondent(correspondent);
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.setServiceId(Constants.SERV_SEARCHOPERATIONS);
			serviceRequestTO.addValue(Constants.IN_OPERATIONREQUEST, operationRequest);
			ServiceResponse response = execute(Constants.SERV_SEARCHOPERATIONS, serviceRequestTO);

			OperationResponse[] operationResponses = extractValue(response, Constants.RETURN_OPERATIONRESPONSE, OperationResponse[].class);
			if (operationResponses != null && operationResponses.length > 0) {
				result = new ArrayList<OperationResponseDTO>();
				for (OperationResponse operationResponse : operationResponses) {
					OperationResponseDTO operationResponseDTO = new OperationResponseDTO();
					operationResponseDTO.fromResponse(operationResponse);
					result.add(operationResponseDTO);
				}
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish searchOperations in " + className);
			}
		}
		return result;
	}
}
