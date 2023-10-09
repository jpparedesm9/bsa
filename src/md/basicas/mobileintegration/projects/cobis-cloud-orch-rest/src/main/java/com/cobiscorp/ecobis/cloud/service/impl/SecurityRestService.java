package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.security.rest.services.IUserSrv;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.security.model.User;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.ecobis.cloud.service.SecurityService;
import com.cobiscorp.ecobis.cloud.service.dto.security.AcceptanceDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.security.CodeOtp;
import com.cobiscorp.ecobis.cloud.service.dto.security.LoginRequest;
import com.cobiscorp.ecobis.cloud.service.dto.security.Route;
import com.cobiscorp.ecobis.cloud.service.dto.security.ValidationCodeResponse;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.SecurityUtil;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Created by farid on 7/25/2017.
 */
@Path("/cobis/web/security")
@Component
@Service({ SecurityService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class SecurityRestService implements SecurityService {
	private final ILogger logger = LogFactory.getLogger(SecurityRestService.class);

	@Reference(name = "userService", referenceInterface = IUserSrv.class, bind = "setUserService", unbind = "unSetUserService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IUserSrv userService;

	public void setUserService(IUserSrv userService) {
		this.userService = userService;
	}

	public void unSetUserService(IUserSrv userService) {
	}

	@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	private com.cobiscorp.ecobis.cloud.service.integration.SecurityService securityService;

	@Path("/authenticate10")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response login(LoginRequest loginRequest, @Context HttpServletRequest httpRequest) {

		// com.cobiscorp.ecobis.cloud.service.integration.SecurityService
		// securityService = new
		// com.cobiscorp.ecobis.cloud.service.integration.SecurityService();

		if (!securityService.isValid(loginRequest)) {
			return Response.status(401).entity("User or password are not valid or device id is not authorized").build();
		}
		User user = securityService.getUser(loginRequest);
		ServiceResponse serviceResponseAuthentication = userService.authenticate(user, httpRequest);
		if (!serviceResponseAuthentication.isResult()) {
			return Response.status(401).entity("User or password are not valid or device id is not authorized").build();
		}
		ServiceResponse serviceResponseAuthorization = userService.authorization(user, httpRequest);
		if (!serviceResponseAuthorization.isResult()) {
			return Response.status(401).entity("User or password are not valid or device id is not authorized").build();
		}
		return successResponse(null, "/cobis/web/security/login");
	}

	@Path("/client/sendCode")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response sendCode(@Valid CodeOtp codeOtp, @Context HttpServletRequest httpRequest) {
		Route responseValueRoute;
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		serviceResponse.setSuccess(true);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio: /cobis/web/security/client/sendCode");
		}
		try {
			if (Constants.MAIL_TYPE.equals(codeOtp.getTipo())) {
				if (!SecurityUtil.validateMail(codeOtp.getPhoneMail())) {
					return errorResponse("EL correo enviado, no es un correo válido");
				}
			}

			if (Constants.SMS_TYPE.equals(codeOtp.getTipo())) {
				if (!SecurityUtil.validatePhone(codeOtp.getPhoneMail())) {
					return errorResponse("EL número de teléfono ingresado enviado, no es un número válido");
				}
			}

			this.securityService.setAdminTokenUser(this.adminTokenUser);

			if (logger.isDebugEnabled()) {
				logger.logDebug("sendCode - this.adminTokenUser=" + this.adminTokenUser);
			}
			responseValueRoute = this.securityService.sendOtp(codeOtp, httpRequest);

			return successResponse(responseValueRoute, "/cobis/web/security/client/sendCode");

		} catch (IntegrationException ie) {
			logger.logError("/cobis/web/security/client/sendCode Error al evniar Código", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis/web/security/client/sendCode Error al evniar Código", e);
			return errorResponse("/cobis/web/security/client/sendCode Error al evniar Código");
		}

	}

	@Path("/client/validationCode")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response validationCode(@Valid CodeOtp codeOtp, @Context HttpServletRequest httpRequest) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio: /cobis/web/security/client/validationCode");
		}
		try {
			if (Constants.MAIL_TYPE.equals(codeOtp.getTipo())) {
				if (!SecurityUtil.validateMail(codeOtp.getPhoneMail())) {
					return errorResponse("EL correo enviado, no es un correo válido");
				}
			}

			if (Constants.SMS_TYPE.equals(codeOtp.getTipo())) {
				if (!SecurityUtil.validatePhone(codeOtp.getPhoneMail())) {
					return errorResponse("EL número de teléfono ingresado enviado, no es un número válido");
				}
			}

			ValidationCodeResponse response = this.securityService.validationOtp(codeOtp, httpRequest);

			if (response != null) {
				return successResponse(response, "/cobis/web/security/client/validationCode");
			} else {
				return errorResponse("Error en Cambio de Numero Telefonico");
			}

		} catch (IntegrationException ie) {
			logger.logError("/cobis/web/security/client/validationCode Error al validar Código", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis/web/security/client/validationCode Error al validar Código", e);
			return errorResponse("/cobis/web/security/client/validationCode Error al validar Código");
		}

	}

	// caso #193221 B2B Grupal Digital
	@Path("/saveAcceptance")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response saveAcceptance(AcceptanceDataRequest acceptanceDataRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug(".......---------SecurityRestService.saveAcceptance");
		logger.logInfo("/cobis/web/security/saveAcceptance Request>>" + objectToJson(acceptanceDataRequest));
		try {
			logger.logDebug("----Inicio try-catch-saveAcceptance");
			logger.logDebug("----saveAcceptance:canal: " + httpRequest.getHeader(Constants.CHANNEL));

			ServiceResponse response = this.securityService.saveAcceptance(acceptanceDataRequest, httpRequest);
			if (response == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			return successResponse(response, "/cobis/web/security/saveAcceptance");
		} catch (IntegrationException ie) {
			logger.logError("/cobis/web/security/saveAcceptance Error al guardar aceptacion", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis/web/security/saveAcceptance Error al guardar aceptacion", e);
			return errorResponse("/cobis/web/security/saveAcceptance Error al guardar aceptacion");
		} finally {
			logger.logDebug(".......---------Final SecurityRestService.saveAcceptance");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicio: /cobis/web/security/client/sendCode - setServiceIntegration");
		}
		this.securityService = new com.cobiscorp.ecobis.cloud.service.integration.SecurityService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.securityService = new com.cobiscorp.ecobis.cloud.service.integration.SecurityService(serviceIntegration);
	}

}
