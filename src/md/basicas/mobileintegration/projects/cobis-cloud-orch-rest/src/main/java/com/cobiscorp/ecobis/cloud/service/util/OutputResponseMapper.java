package com.cobiscorp.ecobis.cloud.service.util;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import java.util.HashMap;
import java.util.Map;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;

/**
 * @author Cesar Loachamin
 */
public class OutputResponseMapper {

    private Map<String, Object> result;
    private ServiceResponse serviceResponse;

    @SuppressWarnings("unchecked")
    private OutputResponseMapper(ServiceResponse serviceResponse) {
        this.serviceResponse = serviceResponse;
        result = new HashMap<String, Object>();
    }

    public OutputResponseMapper map(String field, String to) {
        return map(field, to, String.class);
    }

    public <T> OutputResponseMapper map(String field, String to, Class<T> clazz) {
        result.put(to, extractOutputValue(serviceResponse, field, clazz));
        return this;
    }

    public ServiceResponse process() {
        serviceResponse.setData(result);
        return serviceResponse;
    }


    public static OutputResponseMapper from(ServiceResponse response) {
        return new OutputResponseMapper(response);
    }

}
