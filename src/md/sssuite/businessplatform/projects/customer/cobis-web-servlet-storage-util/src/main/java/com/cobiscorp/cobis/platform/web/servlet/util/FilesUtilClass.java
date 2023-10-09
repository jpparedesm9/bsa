package com.cobiscorp.cobis.platform.web.servlet.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class FilesUtilClass {

	protected static final boolean SUCCESS = true;
	protected static final String SERVER_NAME = "ServerName";
    protected static final String USER_NAME = "UserName";
    protected static final String USER_PASSWORD = "PasswordName";
    public static final String ROOT_FOLDER = "Customer";
    public static final String ROOT_FOLDER_PROCESS = "Inbox";

    protected static final String HTTP = "http://";
    protected static final String DOMAIN = "Cobiscorp\\";
    protected static final String URL = "/_vti_bin/";
    protected static final String COPY_WSDL = "Copy.asmx?wsdl";
    protected static final String COPY_ASMX = "Copy.asmx";
    protected static final String DWS_WSDL = "Dws.asmx?wsdl";
    protected static final String DWS_ASMX = "Dws.asmx";

	
	public String getSession(HttpServletRequest request){
		
		String sessionId = null;
		HttpSession session = request.getSession(false); 
		if (session != null) { 
			sessionId = (String) session.getAttribute(SessionManager.COBIS_SESSION_ID); 
		}
		
		return sessionId;
	}
	
	
}
