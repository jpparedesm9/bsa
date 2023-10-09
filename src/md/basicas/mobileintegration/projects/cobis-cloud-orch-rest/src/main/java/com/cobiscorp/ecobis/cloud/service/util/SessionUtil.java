package com.cobiscorp.ecobis.cloud.service.util;

import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.toInt;

/**
 * @author Cesar Loachamin
 */
public class SessionUtil {

    private static final String USER_CONTEXT_USER = "user-context-user";
    private static final String USER_CONTEXT_ROL = "user-context-rol";
    private static final String USER_CONTEXT_OFFICE = "user-context-office";
    private static final String USER_CONTEXT_FILIAL = "user-context-filial";

    public SessionUtil() {
    }

    public static String getUser() {
        return getStringValue(USER_CONTEXT_USER);
    }

    public static String getRol() {
        return getStringValue(USER_CONTEXT_ROL);
    }

    public static int getOffice() {
        return toInt(getStringValue(USER_CONTEXT_OFFICE));
    }

    public static String getFilial() {
        return getStringValue(USER_CONTEXT_FILIAL);
    }

    private static String getStringValue(String key) {
        String returnValue = null;
        if (SessionManager.getSession() != null && SessionManager.getSession().containsKey(key)) {
            Object value = SessionManager.getSession().get(key);
            if (value != null) {
                returnValue = value.toString();
            }
        }

        return returnValue;
    }
}
