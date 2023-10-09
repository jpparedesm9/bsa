package com.cobiscorp.mobile.util;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.Response;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.LoginResponse;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.ISecurityService;
import com.cobiscorp.mobile.services.RestServiceBase;

public class SecurityUtil extends RestServiceBase {

	public static Response setResponse(Credentials credentials, CobisJwt jwt, boolean isEncrypted,
			boolean addExtraAttributes, IConfigurationService configurationService, ISecurityService securityService,
			ILogger logger) throws MobileServiceException {
		LoginResponse loginResponse = securityService.login(credentials, Constants.CHANNEL, isEncrypted);

		if (logger.isDebugEnabled()) {
			logger.logDebug("===============> logged user: " + loginResponse.getLogin());
			logger.logInfo("loginResponse.getClientId():::::::::::::::::::::: " + loginResponse.getClientId());
			logger.logDebug("ip conexion: " + credentials.getConnectAddress());
		}

		jwt.addAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY, loginResponse.getSessionId());
		jwt.addAttribute(JWT_TOKEN_PHONE_NUMBER_KEY, loginResponse.getLogin());
		jwt.addAttribute(JWT_TOKEN_CUSTOMER_ID_KEY, loginResponse.getCustomerId());
		jwt.addAttribute(JWT_TOKEN_CLIENT_ID_KEY, loginResponse.getClientId());
		jwt.addAttribute(JWT_TOKEN_CULTURE, loginResponse.getCulture());
		jwt.addAttribute(JWT_DEVICE_ID, credentials.getDevice());
		jwt.addAttribute(JWT_LATITUDE, "0");
		jwt.addAttribute(JWT_LONGITUDE, "0");

		Map<String, Object> response = new HashMap<String, Object>();
		response.put(JWT_SESSION_TIMEOUT, getSessionTimeOut(loginResponse.getSessionId(), configurationService));
		if (addExtraAttributes) {
			response.put(JWT_TOKEN_CUSTOMER_ID_KEY, loginResponse.getCustomerId());
			response.put(JWT_TOKEN_PHONE_NUMBER_KEY, loginResponse.getLogin());
		}
		return successResponse(response, jwt);
	}

	private static String getSessionTimeOut(String sessionId, IConfigurationService configurationService)
			throws MobileServiceException {
		return configurationService.getParameterValue("MBSTO", "BVI", sessionId);
	}

}
