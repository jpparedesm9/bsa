package com.cobiscorp.ecobis.cobiscloudsecurity.rest.impl;

import static com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.ServiceResponseUtil.createServiceResponse;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.IServerParamService;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import com.cobiscorp.cobis.cts.webtoken.impl.WebTokenFactory;
import com.cobiscorp.cobis.security.rest.services.IUserSrv;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobis.web.services.security.model.User;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.GetStatusRequest;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.api.ISecurityServiceRest;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common.AuthenticationStatus;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.AuthenticationManagementUtil;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.KeepSecurity;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.cts.integration.services.dto.CTSSessionRequest;

/**
 * Created by farid on 7/25/2017. Modified by fabad
 */
@Path("/cobis/web/security")
@Component
@Service({ ISecurityServiceRest.class })
public class SecurityRestServiceImpl extends ServiceBase implements ISecurityServiceRest {

	private static final String IS_FIRST_TIME_LOGIN = "firstTime";

	private final ILogger logger = LogFactory.getLogger(SecurityRestServiceImpl.class);

	private static final String COBIS_SESSION_ID = "cobis-session-id";

	@Reference(name = "userService", referenceInterface = IUserSrv.class, bind = "setUserService", unbind = "unSetUserService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IUserSrv userService;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setServerParamService", unbind = "unsetServerParamService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IServerParamService serverParamService;

	@Reference(bind = "setCobisParameter", unbind = "unsetCobisParameter", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisParameter cobisParameter;

	private String privateKey;

	public void setCobisParameter(ICobisParameter cobisParameter) {
		this.cobisParameter = cobisParameter;
	}

	public void unsetCobisParameter(ICobisParameter cobisParameter) {
		this.cobisParameter = null;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public void setUserService(IUserSrv userService) {
		this.userService = userService;
	}

	public void unSetUserService(IUserSrv userService) {
		this.userService = null;
	}

	public void setServerParamService(IServerParamService service) {
		this.serverParamService = service;
	}

	public void unsetServerParamService(IServerParamService service) {
		this.serverParamService = null;
	}

	@Path("/authenticate")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response login(Map<String, Object> loginRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug("version7!!!!!");
		if (!isValid(loginRequest)) {
			logger.logDebug("paso1");
			return createServiceResponse(AuthenticationStatus.CREDENCIALES_INVALIDAS);
		}
		User user = getUser(loginRequest, httpRequest);
		if (user == null) {
			return createServiceResponse(AuthenticationStatus.CREDENCIALES_INVALIDAS);
		}
		ServiceResponse serviceResponseAuthentication = userService.authenticate(user, httpRequest);
		if (!serviceResponseAuthentication.isResult()) {
			logger.logDebug("paso2");
			return createServiceResponse(AuthenticationStatus.CREDENCIALES_INVALIDAS);
		}
		ServiceResponse serviceResponseAuthorization = userService.authorization(user, httpRequest);
		if (!serviceResponseAuthorization.isResult()) {
			logger.logDebug("paso3");
			AuthenticationStatus authenticationStatus = AuthenticationManagementUtil
					.getResponseFromInitSession(serviceResponseAuthorization);
			return createServiceResponse(authenticationStatus);
		}

		GetStatusRequest getStatusRequest = new GetStatusRequest();
		DeviceIdentification deviceIdentification = new DeviceIdentification();
		deviceIdentification.setDeviceId((String) loginRequest.get("deviceId"));
		deviceIdentification.setLogin((String) loginRequest.get("user"));
		if (loginRequest.containsKey(IS_FIRST_TIME_LOGIN)) {
			if(logger.isDebugEnabled()) {
				logger.logDebug("Es primera vez: "+(Integer) loginRequest.get(IS_FIRST_TIME_LOGIN));
			}
			deviceIdentification.setFirstTime((Integer) loginRequest.get(IS_FIRST_TIME_LOGIN));
		}
		getStatusRequest.setDeviceIdentification(deviceIdentification);
		getStatusRequest.setReturnName(true);
		setSessionThreadLocal(httpRequest);

		ServiceResponse serviceResponse = getDeviceStatus(getStatusRequest);

		return AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse, cobisParameter, httpRequest,
				loginRequest);
	}

	private void setSessionThreadLocal(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return;
		}

		String wSessionId = (String) session.getAttribute(COBIS_SESSION_ID);

		if (session != null && wSessionId != null) {
			com.cobiscorp.cobis.jaxrs.publisher.SessionManager.setSessionID(wSessionId);
			com.cobiscorp.cobis.jaxrs.publisher.SessionManager.setSession(session);

			if (logger.isDebugEnabled()) {
				logger.logDebug("--- Session ID CON TOKEN!! -- "
						+ com.cobiscorp.cobis.jaxrs.publisher.SessionManager.getSessionId());
			}
		}
	}

	private ServiceResponse getDeviceStatus(GetStatusRequest getStatusRequest) {
		return this.execute(serviceIntegration, logger, "DeviceRegistrationSERVImpl.getStatus",
				new Object[] { getStatusRequest });
	}

	@Path("/logout")
	@Produces({ "application/json" })
	@Consumes({ "application/json" })
	@POST
	public ServiceResponse logout(Map<String, Object> logoutRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug("logout");

		try {
			IWebTokenService webTokenService = getWebTokenService(httpRequest);

			String bearerToken = httpRequest.getHeader("Authorization");
			String token = webTokenService.extractTokenFromBearerToken(bearerToken);
			Map<String, Object> properties = webTokenService.getProperties(token);

			ServiceResponse serviceResponse = new ServiceResponse();
			serviceResponse.setResult(false);
			logger.logDebug("pasoaaa2");
			CTSSessionRequest ctsSessionRequest = new CTSSessionRequest();
			ctsSessionRequest.setUser((String) properties.get(IWebTokenService.USER));
			String terminal = "CEW";
			if (httpRequest.getRemoteHost() != null) {
				logger.logDebug("pasoaaa3");
				terminal = httpRequest.getRemoteHost();
			}
			ctsSessionRequest.setTerminal(terminal);
			ctsSessionRequest.setServer(this.serverParamService.getServerName());
			// ctsSessionRequest.setSessionId(SessionManager.getSessionId());
			ctsSessionRequest.setSessionId((String) properties.get(IWebTokenService.SESSION_ID));

			logger.logDebug("pasoaaa5:" + properties.get(IWebTokenService.SESSION_ID));
			this.serviceIntegration.finalizeSession(ctsSessionRequest);
			serviceResponse.setResult(true);
			return serviceResponse;
		} catch (Exception ex) {
			return manageException(ex, logger);
		}
	}

	private IWebTokenService getWebTokenService(HttpServletRequest httpRequest) {
		String channelStr = httpRequest.getHeader(IWebTokenService.CHANNEL);
		String token = httpRequest.getHeader("Authorization");
		if (channelStr != null && token != null) {
			int channel = Integer.parseInt(channelStr);
			IWebTokenService webTokenService = WebTokenFactory.getService(channel);
			return webTokenService;
		} else {
			return null;
		}
	}

	private Integer getChannel(Map<String, Object> loginRequest) {
		Integer channel = (Integer) loginRequest.get(IWebTokenService.CHANNEL);
		return channel;
	}

	public Boolean isValid(Map<String, Object> loginRequest) {
		return true;
	}

	public User getUser(Map<String, Object> loginRequest, HttpServletRequest httpRequest) {
		User user = new User();
		user.setUserName((String) loginRequest.get("user"));

		Integer channel = getChannel(loginRequest);
		if (channel == null) {
			throw new COBISInfrastructureRuntimeException("channel parameter is required for mobile");
		}
		user.addAttribute(IWebTokenService.CHANNEL, channel);
		String cryptedPasswordHexa = (String) loginRequest.get("password");

		if (cryptedPasswordHexa == null) {
			throw new COBISInfrastructureRuntimeException("password parameter is required for mobile");
		}

		// logger.logDebug("BORRAR:!!! cryptedPasswordHexa:" + cryptedPasswordHexa + "
		// getPrivateKey():" + Activator.getPrivateKey());
		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toCharArray());
		user.setPassword(keepSecurity.decrypt(cryptedPasswordHexa));
		// logger.logDebug("BORRAR:!!! obtained password:" + cryptedPasswordHexa + "
		// cryptedPasswordHexa:" + cryptedPasswordHexa);

		Long roleLong = cobisParameter.getParameter(null, "ADM", "MOBROL", Long.class);
		if (roleLong == null) {
			logger.logError("Debe estar configurado rol para movil: parametro MOBROL en modulo ADM");
			return null;
		}
		Long officeIdLong = cobisParameter.getParameter(null, "ADM", "MOBOFF", Long.class);
		if (officeIdLong == null) {
			logger.logError("Debe estar configurada oficina para movil: parametro MOBOFF en modulo ADM");
			return null;
		}

		Integer officeId = officeIdLong.intValue();
		Integer rol = roleLong.intValue();

		user.setOfficeId(officeId);
		user.setRoleId(rol);
		logger.logDebug("rol:" + rol);
		logger.logDebug("officeId:" + officeId);
		return user;
	}

}