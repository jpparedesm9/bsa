package com.cobiscorp.ecobis.cloud.service.util;

import javax.servlet.http.HttpServletRequest;

public class RequestUtil {

    private RequestUtil() {
    }

    public static <T> T getParameter(HttpServletRequest request, String param, Class<T> clazz) {
        String value =request.getParameter(param);
        if (value == null) {
            throw new ParameterNotFoundException(param);
        }
        return DataTypeUtil.convertType(value, clazz);
    }
}
