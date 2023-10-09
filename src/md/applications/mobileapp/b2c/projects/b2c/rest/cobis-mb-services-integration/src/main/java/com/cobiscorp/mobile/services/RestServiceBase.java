package com.cobiscorp.mobile.services;

import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.InvalidTokenException;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.b2c.jwt.TokenExpiredException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.mobile.converter.ErrorConverter;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.KeyValue;

/**
 * @author Cesar Loachamin
 */
public class RestServiceBase {

	protected static final String JWT_TOKEN_ID = "cobis-jwt";
	protected static final String JWT_TOKEN_CUSTOMER_ID_KEY = "customerId";
	protected static final String JWT_TOKEN_LOAN_ID_KEY = "loanId";
	protected static final String JWT_TOKEN_PHONE_NUMBER_KEY = "phoneNumber";
	protected static final String JWT_TOKEN_COBIS_SESSION_ID_KEY = "cobisSessionId";
	protected static final String JWT_TOKEN_CULTURE = "culture";
	protected static final String AUTHORIZATION = "Authorization";
	protected static final String JWT_TOKEN_OLD_PHONE_NUMBER_KEY = "oldPhoneNumber";
	protected static final String JWT_TOKEN_CLIENT_ID_KEY = "clientId";
	protected static final String JWT_SESSION_TIMEOUT = "sessionTimeOut";
	protected static final String JWT_DEVICE_ID = "deviceId";
	protected static final String JWT_LATITUDE = "latitudePos";
	protected static final String JWT_LONGITUDE = "longitudePos";

	protected ILogger logger = LogFactory.getLogger(RestServiceBase.class);

	public static <T> Response successResponse(T data, CobisJwt jwt) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(true);
		serviceResponse.setData(data);
		return Response.ok(serviceResponse).header(JWT_TOKEN_ID, jwt.generateJws()).build();
	}

	protected Response errorResponse(String message) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(false);
		serviceResponse.addMessage("0000", message);
		return Response.status(406).entity(serviceResponse).build();
	}

	protected Response unauthorizedResponse(String message) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(false);
		serviceResponse.addMessage("", message);
		return Response.status(401).entity(serviceResponse).build();
	}

	protected Response errorResponse(MobileServiceException exception) {
		int statusCode = 406;
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setResult(false);
		if (exception.getErrors() != null) {
			for (KeyValue error : exception.getErrors()) {
				KeyValue convertedError = ErrorConverter.convertError(error);
				serviceResponse.addMessage(convertedError.getKey(), (String) convertedError.getValue());
				statusCode = defineStatusCode(Integer.valueOf(convertedError.getKey()));
			}
		} else {
			serviceResponse.addMessage("0000", exception.getMessage());
		}
		return Response.status(statusCode).entity(serviceResponse).build();
	}

	private int defineStatusCode(int error) {
		if (error < 100000) {
			return 501;
		}
		if (error == 1890011) {
			return 403;
		}
		return 406;
	}

	protected void appendJwtToken(HttpServletResponse httpResponse) {
		CobisJwt jwt = new CobisJwt(new ShakeJwtKeyGenerator());
		httpResponse.addHeader(JWT_TOKEN_ID, jwt.generateJws());
	}

	protected void appendJwtToken(HttpServletResponse httpResponse, String key, String value) {
		CobisJwt jwt = new CobisJwt(new ShakeJwtKeyGenerator());
		jwt.addAttribute(key, value);
		String token = jwt.generateJws();
		httpResponse.addHeader(JWT_TOKEN_ID, token);
	}

	protected void appendJwtToken(HttpServletResponse httpResponse, Map<String, String> payload) {
		CobisJwt jwt = new CobisJwt(new ShakeJwtKeyGenerator());
		for (Entry<String, String> entry : payload.entrySet()) {
			jwt.addAttribute(entry.getKey(), entry.getValue());
		}
		String token = jwt.generateJws();
		httpResponse.addHeader(JWT_TOKEN_ID, token);
	}

	protected Object findTokenData(HttpServletRequest httpRequest, String payloadKey) throws MobileServiceException {
		Map<String, Object> payload = getTokenPayload(httpRequest);
		if (payload.containsKey(payloadKey)) {
			return payload.get(payloadKey);
		} else {
			throw new MobileServiceException("Token no contiene la data necesaria");
		}
	}

	private Map<String, Object> getTokenPayload(HttpServletRequest httpRequest) throws MobileServiceException {
		CobisJwt jwt;
		try {
			jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			return jwt.getPayload();
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			throw new MobileServiceException(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			throw new MobileServiceException(e.getMessage());
		}
	}
}
