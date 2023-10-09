package com.cobis.cloud.lcr.b2b.service.common;

import static com.cobis.cloud.lcr.b2b.service.common.DataTypeTool.convertType;

import java.util.Map;

import javax.ws.rs.core.Response;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * @author Cesar Loachamin
 */
public class ServiceResponseTool {

    private ServiceResponseTool() {
    }

    public static <T> ServiceResponse createServiceResponse(T data) {
        return createServiceResponse(data, true);
    }

    public static <T> ServiceResponse createEmptyServiceResponse() {
        return createServiceResponse(null);
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

    public static <T> T extractOutputValue(ServiceResponse response, String value, Class<T> clazz) {
        Map<String, Object> output = extractOutputMap(response);
        if (output.containsKey(value) && output.get(value) != null) {
            return convertType(output.get(value).toString(), clazz);
        }
        return null;
    }

    static void clearCodesInMessages(ServiceResponse response) {
        if (!response.isResult()) {
            if (response.getMessages() != null) {
                for (Message message : response.getMessages()) {
                    message.setMessage(
                            message.getMessage()
                                    .replaceAll("(\\[.*?\\])", "")
                                    .replaceAll("&apos;", "'")
                                    .trim()
                    );
                }
            }
        }
    }

    public static <T> Response successResponse(T data) {
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setResult(true);
        serviceResponse.setData(data);
        return Response.ok(serviceResponse).build();
    }

    public static <T> Response errorResponse(T data) {
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setData(data);
        return Response.serverError().entity(serviceResponse).build();
    }

    public static Response errorResponse(Response.Status status) {
        ServiceResponse serviceResponse = new ServiceResponse();
        return Response.status(status).entity(serviceResponse).build();
    }

    public static Response errorResponse(IntegrationException ie) {
        return Response.status(500).entity(ie.getResponse()).build();
    }

    public static Response errorResponse(String message) {
        return Response.status(500).entity(message).build();
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> extractOutputMap(ServiceResponse response) {
        return extractValue(
                response,
                "com.cobiscorp.cobis.cts.service.response.output",
                Map.class
        );
    }

    public static boolean calculateResult(ServiceResponse... responses) {
        if (responses == null) {
            return true;
        }
        ServiceResponse response = ArrayTool.find(responses, new ArrayTool.Predicate<ServiceResponse>() {
            @Override
            public boolean test(ServiceResponse obj) {
                return !obj.isResult();
            }
        });
        return response == null;
    }
}
