package com.cobiscorp.ecobis.frm.business.util;

import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

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
		return Integer.valueOf((getStringValue(USER_CONTEXT_OFFICE)));
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
