package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common.AuthenticationStatus;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common.OutputData;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.ArrayUtil.Predicate;

import javax.ws.rs.core.Response;
import java.util.Map;

import static com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.DataTypeUtil.convertType;

/**
 * @author Cesar Loachamin, Fernando Abad
 */
public class ServiceResponseUtil {

    private ServiceResponseUtil() {
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

    public static Response createServiceResponse(int httpStatus, boolean result,
                                                 int errorCode, String message) {
        ServiceResponse response = new ServiceResponse();
        response.setResult(result);
        response.setData(null);
        response.addMessage(Integer.toString(errorCode), message);
        return Response.status(httpStatus).entity(response).build();

    }

    public static Response createServiceResponse(AuthenticationStatus authenticationStatus) {
        ServiceResponse response = new ServiceResponse();
        response.setResult(authenticationStatus.isAuthenticationResult());
        response.setData(null);
        response.addMessage(Integer.toString(authenticationStatus.getErrorCode()),
                authenticationStatus.getMessage());
        return Response.status(
                authenticationStatus.getStatus().getStatusCode()).entity(response).build();

    }



    public static ServiceResponse createServiceResponse(OutputData responseData) {
        ServiceResponse result = null;
        if (responseData != null) { //search for a response that not have a false result
            result = ArrayUtil.find(responseData.getResponses(), new Predicate<ServiceResponse>() {
                @Override
                public boolean test(ServiceResponse obj) {
                    return obj != null && !obj.isResult();
                }
            });
        }
        return createServiceResponse(responseData, result == null);
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

    public static Response response(OutputData responseData) {
        ServiceResponse serviceResponse = createServiceResponse(responseData);
        return Response.ok().entity(serviceResponse).build();
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
        ServiceResponse response = ArrayUtil.find(responses, new Predicate<ServiceResponse>() {
            @Override
            public boolean test(ServiceResponse obj) {
                return !obj.isResult();
            }
        });
        return response == null;
    }
}
