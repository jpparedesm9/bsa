package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import com.cobiscorp.cobis.cts.webtoken.impl.WebTokenFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceStatus;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common.AuthenticationStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Response;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.ServiceResponseUtil.createServiceResponse;
import static com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.ServiceResponseUtil.successResponse;

public class AuthenticationManagementUtil {
	public static final String COBIS_SESSION_ID = "cobis-session-id";
	public static final String REGISTERED = "R";
	public static final String PRE_REGISTERED = "P";

	private static ILogger logger = LogFactory.getLogger(AuthenticationManagementUtil.class);

	public static AuthenticationStatus getResponseFromInitSession(ServiceResponse serviceResponseAuthorization) {
		AuthenticationStatus authenticationStatus;
		List<Message> messageList = serviceResponseAuthorization.getMessages();
		Message errorMessage = messageList.get(0);
		if (errorMessage.getMessage().contains(AuthenticationStatus.USUARIO_USADO_EN_OTRO_DISPOSITIVO.getSearch())) {
			authenticationStatus = AuthenticationStatus.USUARIO_USADO_EN_OTRO_DISPOSITIVO;
		} else if (errorMessage.getMessage().contains(AuthenticationStatus.PASSWORD_CADUCADO.getSearch())) {
			authenticationStatus = AuthenticationStatus.PASSWORD_CADUCADO;
		} else if (errorMessage.getMessage().contains(AuthenticationStatus.USUARIO_BLOQUEADO.getSearch())) {
			authenticationStatus = AuthenticationStatus.USUARIO_BLOQUEADO;
		} else {
			authenticationStatus = AuthenticationStatus.CREDENCIALES_INVALIDAS;
		}
		return authenticationStatus;
	}

	private static void fillSuccessResponseParameters(Map<String, Object> loginRequest, Map<String, Object> loginResponse, ICobisParameter cobisParameter,
			HttpServletRequest httpRequest, DeviceStatus deviceStatus) {
		loginResponse.put("idleTimeout", getIdleTimeout(cobisParameter));
		IWebTokenService webTokenService = WebTokenFactory.getService(loginRequest);

		Map<String, Object> tokenRequest = new HashMap<String, Object>(loginRequest);
		tokenRequest.remove("password");

		HttpSession session = httpRequest.getSession();
		String wSessionId = (String) session.getAttribute(COBIS_SESSION_ID);
		tokenRequest.put("sessionId", wSessionId);

		int expirationSeconds = getExpirationTime(cobisParameter);
		// String token = webTokenService.generateToken(tokenRequest);
		String token = webTokenService.generateToken(tokenRequest, expirationSeconds);
		loginResponse.put("token", token);

		loginResponse.put("proceedToCompleteRegistration", deviceStatus.getProceedToCompleteRegistration().booleanValue());

		cleanSessionToAvoidCTSClosing(session);

	}

	public static Response getResponseFromDeviceStatus(ServiceResponse serviceResponse, ICobisParameter cobisParameter, HttpServletRequest httpRequest,
			Map<String, Object> loginRequest) {

		Map<String, Object> loginResponse = new HashMap<String, Object>();
		if (serviceResponse.isResult()) {
			DeviceStatus deviceStatus = (DeviceStatus) serviceResponse.getData();
			logger.logDebug("deviceStatus:" + deviceStatus);
			if (deviceStatus == null) {
				return createServiceResponse(AuthenticationStatus.DISPOSITIVO_NO_REGISTRADO);
			} else if (!deviceStatus.getLock() && REGISTERED.equals(deviceStatus.getStatus())) {
				fillSuccessResponseParameters(loginRequest, loginResponse, cobisParameter, httpRequest, deviceStatus);
				return successResponse(loginResponse);
			} else if (deviceStatus.getLock() && !deviceStatus.getProceedToClearData()) {
				return createServiceResponse(AuthenticationStatus.DISPOSITIVO_BLOQUEADO);
			} else if (deviceStatus.getLock() && deviceStatus.getProceedToClearData()) {
				return createServiceResponse(AuthenticationStatus.DISPOSITIVO_BLOQUEADO_LIMPIAR_DATA);
			} else if (!deviceStatus.getLock() && PRE_REGISTERED.equals(deviceStatus.getStatus())) {
				loginResponse.put("officerName", deviceStatus.getOfficerName());
				fillSuccessResponseParameters(loginRequest, loginResponse, cobisParameter, httpRequest, deviceStatus);
				return successResponse(loginResponse);
			} else {
				throw new COBISInfrastructureRuntimeException("Please review device status parameters");
			}

		} else {
			logger.logError("error al momento de obtener device status");
			return createServiceResponse(AuthenticationStatus.PROBLEMAS_AL_OBTENER_REGISTRO);
		}

	}

	private static int getIdleTimeout(ICobisParameter cobisParameter) {
		Long idleTimeoutSecondsL = cobisParameter.getParameter(null, "ADM", "MOBIDT", Long.class);
		if (idleTimeoutSecondsL == null) {
			logger.logError("Debe estar configurado el Tiempo de inactividad para desplegar pantalla de login en segundos: parámetro MOBIDT en modulo ADM");
			logger.logError("Poniendo por default 10 minutos");
			idleTimeoutSecondsL = 600L;
		}
		int idleTimeoutSeconds = idleTimeoutSecondsL.intValue();
		logger.logDebug("idleTimeout:" + idleTimeoutSeconds);
		return idleTimeoutSeconds;
	}

	private static int getExpirationTime(ICobisParameter cobisParameter) {
		Long expirationSecondsL = cobisParameter.getParameter(null, "ADM", "MOBEXP", Long.class);
		if (expirationSecondsL == null) {
			logger.logError("Debe estar configurado el tiempo de expiración de dispositivos móviles: parámetro MOBEXP en modulo ADM");
			expirationSecondsL = 0L;
		}
		int expirationSeconds = expirationSecondsL.intValue();
		logger.logDebug("expirationSeconds:" + expirationSeconds);
		return expirationSeconds;
	}

	private static void cleanSessionToAvoidCTSClosing(HttpSession session) {
		logger.logDebug("cleanning session!!!");
		// se quita la sesion porque ya esta en el token
		session.removeAttribute(COBIS_SESSION_ID);
		session.invalidate();
		logger.logDebug("cleaned session!!!");
	}

}
