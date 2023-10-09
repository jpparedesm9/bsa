package com.cobiscorp.cobis.platform.web.servlet.util;
 
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;
 

import org.codehaus.jackson.type.TypeReference;
 

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ResponseTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
 

import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.exceptions.COBISRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.JSONSerializerService;
 
public class ServiceBase {
 
    private static final String MESSAGE_ERROR_CODE = "0001";
    private static final String MESSAGE_ERROR_MESSAGE = "Application Error";
    private static final String SERVICE_PARAMETERS = "SERVICE_PARAMETERS";
    private static final String SERVICE_PARAMETERS_TYPE = "SERVICE_PARAMETERS_TYPE";
    private static final String SERVICE_RESPONSE = "SERVICE_RESPONSE";
 
    private String sessionId;
    
    protected ServiceResponse execute(
            ICTSServiceIntegration serviceIntegration, ILogger logger,
            String serviceId, String serviceRequest, Object[] arrInDataType) {
        JSONSerializerService jsonSerializerService = new JSONSerializerService();
        Object[] arrInData = jsonSerializerService.deserializeToObjectArray(
                serviceRequest, arrInDataType);
        Class<?>[] paramClasses = new Class[arrInDataType.length];
        for (int i = 0; i < arrInDataType.length; i++) {
            if (arrInDataType[i] instanceof TypeReference) {
                TypeReference<?> typeRef = (TypeReference<?>)arrInDataType[i];
                ParameterizedType paramType = (ParameterizedType)(typeRef.getType());
                paramClasses[i] = (Class<?>)(paramType.getRawType());
            } else {
                paramClasses[i] = (Class<?>)arrInDataType[i];
            }
        }
        return execute(serviceIntegration, logger, serviceId, arrInData,
                paramClasses);
    }
 
    protected ServiceResponse execute(
            ICTSServiceIntegration serviceIntegration, ILogger logger,
            String serviceId, Object[] arrInData) {
        return execute(serviceIntegration, logger, serviceId, arrInData, null);
    }
 
    protected ServiceResponse execute(
            ICTSServiceIntegration serviceIntegration, ILogger logger,
            String serviceId, Object[] arrInData, Class<?>[] arrInDataType) {
        try {
            ServiceRequest header = new ServiceRequest();
            header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID,
                    ICOBISTS.HEADER_STRING_TYPE, SessionManager.getSessionId());
            ServiceResponse serviceWebResponse = new ServiceResponse();
            ServiceRequestTO serviceRequest = new ServiceRequestTO();
            serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
            serviceRequest.setSessionId(SessionManager.getSessionId());
            ServiceResponseTO serviceResponse = new ServiceResponseTO();
            serviceRequest.setServiceId(serviceId);
            serviceRequest.addValue(SERVICE_PARAMETERS, arrInData);
            if (arrInDataType != null) {
                serviceRequest.addValue(SERVICE_PARAMETERS_TYPE, arrInDataType);
            }
            serviceResponse = serviceIntegration
                    .getResponseFromCTS(serviceRequest);
            if (!serviceResponse.isSuccess()) {
                serviceWebResponse.addMessages(serviceResponse.getMessages());
                this.manageResponseError(serviceResponse, logger);
                serviceWebResponse.setResult(false);
                return serviceWebResponse;
            } else {
                serviceWebResponse.setData(serviceResponse
                        .getValue(SERVICE_RESPONSE));
                serviceWebResponse.setResult(true);
                return serviceWebResponse;
            }
        } catch (Exception ex) {
            return this.manageException(ex, logger);
        }
 
    }
 
    protected ServiceResponse execute(
            ICTSServiceIntegration serviceIntegration, ILogger logger,
            String serviceId, ServiceRequestTO serviceRequest) {
        try {
            ServiceRequest header = new ServiceRequest();
            header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID,
                    ICOBISTS.HEADER_STRING_TYPE, SessionManager.getSessionId());
            ServiceResponse serviceWebResponse = new ServiceResponse();
            serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
            serviceRequest.setSessionId(SessionManager.getSessionId());
            ServiceResponseTO serviceResponse = new ServiceResponseTO();
            serviceRequest.setServiceId(serviceId);
            serviceResponse = serviceIntegration
                    .getResponseFromCTS(serviceRequest);
            if (!serviceResponse.isSuccess()) {
                serviceWebResponse.addMessages(serviceResponse.getMessages());
                this.manageResponseError(serviceResponse, logger);
                serviceWebResponse.setResult(false);
                return serviceWebResponse;
            } else {
                serviceWebResponse.setData(serviceResponse);
                serviceWebResponse.setResult(true);
                return serviceWebResponse;
            }
        } catch (Exception ex) {
            return this.manageException(ex, logger);
        }
 
    }
 
    public ServiceResponseTO manageExceptionServiceResponseTO(Exception ex,
            ILogger logger) {
        ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
        serviceResponseTO.setSuccess(false);
        serviceResponseTO.addMessage(getErrorMessage(ex));
        return serviceResponseTO;
    }
 
    public ResponseTO manageExceptionResponseTO(Exception ex, ILogger logger) {
        ResponseTO responseTO = new ResponseTO();
        List<MessageTO> messages = new ArrayList<MessageTO>();
        messages.add(getErrorMessage(ex));
        responseTO.setSucess(false);
        responseTO.setMessages((MessageTO[]) messages.toArray());
        return responseTO;
    }
 
    public ServiceResponse manageException(Exception ex, ILogger logger) {
        ServiceResponse serviceResponse = new ServiceResponse();
        MessageTO message = getErrorMessage(ex);
        serviceResponse.addMessage(message.getCode(), message.getMessage());
        serviceResponse.setResult(false);
        if (logger.isErrorEnabled()) {
            logger.logError("", ex);
        }
        return serviceResponse;
    }
 
    public void manageResponseError(ServiceResponseTO serviceResponse,
            ILogger logger) {
        if (serviceResponse != null && logger.isErrorEnabled()) {
            for (int i = 0; i < serviceResponse.getMessages().size(); i++) {
                MessageTO message = (MessageTO) serviceResponse.getMessages()
                        .get(i);
                logger.logDebug("Error: " + message.getCode() + " "
                        + message.getMessage());
            }
        }
    }
 
    public ServiceRequestTO fillServiceRequestTO(
            ServiceRequestTO serviceRequest, ILogger logger) {
        ServiceRequest header = new ServiceRequest();
        logger.logInfo("Session id: " + SessionManager.getSessionId());
        header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID,
                ICOBISTS.HEADER_STRING_TYPE, SessionManager.getSessionId());
        serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
        serviceRequest.setSessionId(SessionManager.getSessionId());
        return serviceRequest;
    }
 
    private MessageTO getErrorMessage(Exception ex) {
        String errorText = "";
        String errorCode = "";
        // error especifico
        if (ex instanceof COBISException) {
            COBISException cobisException = (COBISException) ex;
            errorCode = Integer.toString(cobisException.getClientErrorCode());
            errorText = cobisException.getClientErrorMessage();
        } else if (ex instanceof COBISRuntimeException) {
            COBISRuntimeException cobisException = (COBISRuntimeException) ex;
            errorCode = Integer.toString(cobisException.getClientErrorCode());
            errorText = cobisException.getClientErrorMessage();
        } else if (ex instanceof COBISInfrastructureRuntimeException) {
            COBISInfrastructureRuntimeException cobisException = (COBISInfrastructureRuntimeException) ex;
            errorCode = Integer.toString(cobisException.getClientErrorCode());
            errorText = cobisException.getClientErrorMessage();
        } else {
            errorText = ex.getMessage();
        }
        if ((errorText == null) || (errorText.isEmpty())) {
            // error general
            errorText = MESSAGE_ERROR_MESSAGE;
            errorCode = MESSAGE_ERROR_CODE;
        }
        MessageTO message = new MessageTO();
        message.setCode(errorCode);
        message.setMessage(errorText);
        return message;
    }
    
	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

 
}
