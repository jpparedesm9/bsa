package com.cobiscorp.ecobis.frm.business.util;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.Response;

import org.codehaus.jackson.map.ObjectMapper;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

public class ServiceResponseUtil {

	private static final ILogger LOGGER = LogFactory.getLogger(ServiceResponseUtil.class);

	private ServiceResponseUtil() {
	}

	public static <T> ServiceResponse createEmptyServiceResponse() {
		return createServiceResponse(null);
	}

	public static <T> ServiceResponse createServiceResponse(T data) {
		return createServiceResponse(data, true);
	}

	public static <T> ServiceResponse createServiceResponse(T data, boolean result) {
		ServiceResponse response = new ServiceResponse();
		response.setResult(result);
		response.setData(data);
		return response;
	}

	public static <T> T extractValue(ServiceResponse response, String value, Class<T> clazz) {
		if (response.isResult() && response.getData() != null) {
			ServiceResponseTO dataResponse = (ServiceResponseTO) response.getData();
			return clazz.cast(dataResponse.getData().get(value));
		}
		return null;
	}

	public static <T> Response successResponse(T data, String methodName) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(true);
		serviceResponse.setData(data);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("REST " + methodName + " Response >>" + objectToJson(serviceResponse));
		}
		return Response.ok(serviceResponse).build();
	}

	public static String objectToJson(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.writeValueAsString(obj);
		} catch (Exception e) {
			LOGGER.logError("Error al obtener trama JSON de respuesta:", e);
			return null;
		}
	}

	public static <T> Response successResponse(T data, boolean success, String methodName) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(success);
		serviceResponse.setData(data);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("REST " + methodName + " Response >>" + objectToJson(serviceResponse));
		}
		return Response.ok(serviceResponse).build();
	}

	public static <T> Response errorResponse(T data) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setData(data);
		return Response.status(406).entity(serviceResponse).build();
	}

	public static <T> Response errorResponse(T data, String methodName) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setData(data);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("REST " + methodName + " Response >>" + objectToJson(serviceResponse));
		}
		return Response.status(406).entity(serviceResponse).build();
	}

	public static Response errorResponse(Response.Status status) {
		ServiceResponse serviceResponse = new ServiceResponse();
		return Response.status(status).entity(serviceResponse).build();
	}

	public static Response errorResponse(String message) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(false);
		Message msj = new Message();
		msj.setMessage(message);
		serviceResponse.setMessages(Arrays.asList(msj));
		return Response.status(406).entity(objectToJson(serviceResponse)).build();
	}

	@SuppressWarnings("unchecked")
	private static Map<String, Object> extractOutputMap(ServiceResponse response) {
		return extractValue(response, "com.cobiscorp.cobis.cts.service.response.output", Map.class);
	}

	public static String getMessages(List<Message> messages) {
		StringBuilder messagesList = new StringBuilder();
		for (Message message : messages) {
			messagesList.append(message.getMessage());
			messagesList.append(" ");
		}
		return messagesList.toString();
	}
}
