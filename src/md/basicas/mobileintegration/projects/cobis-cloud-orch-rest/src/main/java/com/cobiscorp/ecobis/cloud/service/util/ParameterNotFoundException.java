package com.cobiscorp.ecobis.cloud.service.util;

/**
 * @author Cesar Loachamin
 */
public class ParameterNotFoundException extends RuntimeException {

    public ParameterNotFoundException(String parameterName) {
        super("Parameter " + parameterName + " not found");
    }
}
