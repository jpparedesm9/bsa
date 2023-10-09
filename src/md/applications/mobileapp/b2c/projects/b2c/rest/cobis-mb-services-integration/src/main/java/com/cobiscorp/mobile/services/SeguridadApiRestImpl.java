package com.cobiscorp.mobile.services;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.InvalidTokenException;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.b2c.jwt.TokenExpiredException;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenRequest;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenResponse;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Answer;
import com.cobiscorp.mobile.model.Answers;
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.mobile.model.ChangePasswordRequest;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.ConfigParameter;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.EnrollDevicelClient;
import com.cobiscorp.mobile.model.GeneralParameters;
import com.cobiscorp.mobile.model.NotificationRequest;
import com.cobiscorp.mobile.model.OtpResponse;
import com.cobiscorp.mobile.model.ParameterRequest;
import com.cobiscorp.mobile.model.Password;
import com.cobiscorp.mobile.model.Phone;
import com.cobiscorp.mobile.model.Question;
import com.cobiscorp.mobile.model.Registration;
import com.cobiscorp.mobile.model.RegistryCode;
import com.cobiscorp.mobile.model.ResetPasswordRequest;
import com.cobiscorp.mobile.model.SecurityImageRequest;
import com.cobiscorp.mobile.model.SecurityImageResponse;
import com.cobiscorp.mobile.rest.interfaces.IRestSecurityService;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.IParameterService;
import com.cobiscorp.mobile.service.interfaces.IRegistrationService;
import com.cobiscorp.mobile.service.interfaces.ISecurityImageService;
import com.cobiscorp.mobile.service.interfaces.ISecurityService;
import com.cobiscorp.mobile.util.BankGeolocationUtil;
import com.cobiscorp.mobile.util.SecurityUtil;

/**
 * Crédito en Línea
 * 
 * <p>
 * Servicios para aplicación de crédito en
 * 
 */
@Path("/channels/mobilebanking")
@Component
@Service({ IRestSecurityService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class SeguridadApiRestImpl extends RestServiceBase implements IRestSecurityService {

	@Reference(bind = "setSecurityService", unbind = "unsetSecurityService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISecurityService securityService;

	@Reference(bind = "setRegistrationService", unbind = "unsetRegistrationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IRegistrationService registrationService;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IParameterService parameterService;

	@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	@Reference(bind = "setImageService", unbind = "unsetImageService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISecurityImageService imageService;

	@POST
	@Path("/security/password")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response passwordPost(@Valid Password password, @Context HttpServletRequest httpRequest) {
		CobisJwt cobisJwt;
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("*******************>Inicio de servicio  passwordPost:");
			}
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String phoneNumber = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			Integer clientId = Integer.valueOf(cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY));
			String oldPhoneNumber = cobisJwt.getAttribute(JWT_TOKEN_OLD_PHONE_NUMBER_KEY);

			EnrollDevicelClient enrollDevicelClient = new EnrollDevicelClient();
			enrollDevicelClient.setPhoneNumber(phoneNumber);
			enrollDevicelClient.setPassword(password.getValue());
			enrollDevicelClient.setChannel(Constants.CHANNEL);
			enrollDevicelClient.setClientId(clientId);
			enrollDevicelClient.setOldPhoneNumber(oldPhoneNumber);

			enrollDevicelClient.setBrandDevice(password.getBrandDevice());
			enrollDevicelClient.setModelDevice(password.getModelDevice());
			enrollDevicelClient.setVersionOS(password.getVersionOS());
			enrollDevicelClient.setCarrier(password.getCarrier());
			enrollDevicelClient.setConnectAddress(password.getConnectAddress());
			registrationService.enrollClient(enrollDevicelClient, true);

			Credentials credentials = new Credentials();
			credentials.setPassword(password.getValue());
			credentials.setUsername(phoneNumber);
			credentials.setCulture(Constants.CULTURE);
			credentials.setConnectAddress(password.getConnectAddress());
			if (logger.isDebugEnabled()) {
				logger.logDebug("Valor device: " + credentials.getDevice());
			}

			credentials.setDevice(password.getDevice());

			return SecurityUtil.setResponse(credentials, cobisJwt, true, false, configurationService, securityService, logger);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			logger.logError("Error: ", e);
			return errorResponse(e);
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			logger.logError("Error: ", e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@PUT
	@Path("/security/password")
	@Consumes({ "application/json" })
	public Response passwordPut(@Valid ChangePasswordRequest password, @Context HttpServletRequest httpRequest) {
		CobisJwt cobisJwt;
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio PUT: /security/password");
			}
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY);
			String phoneNumber = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			Client client = new Client();
			client.setIdCliente(clientId);
			client.setTelefono(phoneNumber);
			this.securityService.changePassword(client, password, cobisSessionId);
			return Response.ok().build();

		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}

	}

	@POST
	@Path("/security/challenge")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response challengeGet(@Valid Client cliente, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio: /security/challenge");
			}
			CobisJwt cobisJwt = new CobisJwt(new ShakeJwtKeyGenerator());// new
																			// CobisJwt(httpRequest.getHeader(AUTHORIZATION),
																			// new
																			// ShakeJwtKeyGenerator());
			List<Question> questions = this.securityService.findSecurityQuestions(Integer.valueOf(cliente.getIdCliente()));
			cobisJwt.addAttribute(JWT_TOKEN_CUSTOMER_ID_KEY, cliente.getIdCliente());
			cobisJwt.addAttribute(JWT_TOKEN_PHONE_NUMBER_KEY, cliente.getTelefono());

			StringBuilder questionIds = new StringBuilder();
			for (Iterator<Question> iterator = questions.iterator(); iterator.hasNext();) {
				questionIds.append(iterator.next().getQuestionId());
				if (iterator.hasNext()) {
					questionIds.append(",");
				}
			}
			cobisJwt.addAttribute("questionIds", questionIds.toString());

			return successResponse(questions, cobisJwt);
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		}
	}

	@PUT
	@Path("/security/challenge")
	@Produces({ "application/json" })
	public Response challengePut(@Valid Answers answers, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio PUT: /security/challenge");
			}

			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			validateQuestionIds(answers, jwt.getAttribute("questionIds"));

			String idCliente = (String) jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			this.securityService.validateSecurityAnswers(Integer.valueOf(idCliente), answers.getAnswers());
			return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@PUT
	@Path("/security/client/block")
	@Consumes({ "application/json" })
	public Response blockPhonePut(@Context HttpServletRequest httpRequest) {
		logger.logInfo("Servicio rest de bloqueo... /security/client/block");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			this.securityService.temporalBlock(cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY), cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY),
					cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY));
			return Response.ok().build();
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		}
	}

	@PUT
	@Path("/security/client/unblock")
	@Produces({ "application/json" })
	public Response unblockPhonePut(@Valid Answers answers, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio PUT: /security/client/unblock");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			validateQuestionIds(answers, jwt.getAttribute("questionIds"));

			String phone = (String) jwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			String customerId = (String) jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			this.securityService.unblock(phone, Integer.valueOf(customerId), answers.getAnswers());
			return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	private void validateQuestionIds(Answers answers, String questionIds) throws TokenExpiredException, InvalidTokenException {
		if (questionIds == null) {
			errorResponse("No se obtuvieron los ids de las preguntas");
		} else {
			String[] ids = questionIds.split(",");
			for (String id : ids) {
				boolean found = false;
				for (Answer answer : answers.getAnswers()) {
					if (answer.getQuestionId().toString().equals(id)) {
						found = true;
					}
				}
				if (!found) {
					errorResponse("Los ids de las respuestas no son los esperados");
				}
			}
		}
	}

	@POST
	@Path("/security/client/changePhone")
	@Produces({ "application/json" })
	public Response changePhonePost(@Valid OtpResponse otpResponse, @Context HttpServletRequest httpRequest) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio: /security/client/changePhone");
		}
		CobisJwt cobisJwt;
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			String phoneNumber = cobisJwt.getAttribute("phoneNumber");

			DataTokenRequest dataIn = new DataTokenRequest();
			dataIn.setChannel(Constants.CHANNEL);
			dataIn.setClientId(Integer.valueOf(clientId));
			dataIn.setClientPhoneNumber(phoneNumber);
			dataIn.setToken(String.valueOf(otpResponse.getOtp()));
			dataIn.setLogin(clientId);

			DataTokenResponse validationResponse = adminTokenUser.validateTokenUser(dataIn);
			if (!validationResponse.getSuccess()) {
				logger.logInfo("--->>SeguridadApiRestImpl--Error en changePhonePost cliente: " + clientId);
				return errorResponse("El código ingresado NO Existe");
			}

			logger.logInfo("Va a cambiar el cliente: " + clientId);
			logger.logInfo("Va a cambiar el telefono: " + phoneNumber);

			return Response.ok().header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
		} catch (TokenExpiredException e) {
			e.printStackTrace();
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error TokenExpiredException InvalidTokenException: " + e);
			return unauthorizedResponse(e.getMessage());
			// } catch (MobileServiceException e) {
			// return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error en Cambio de Numero Telefonico");
		}

	}

	@PUT
	@Path("/security/client/changePhone")
	@Produces({ "application/json" })
	@Consumes({ "application/json" })
	public Response changePhonePut(@Valid Phone telefono, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio PUT: /security/client/changePhone");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			generateAndSendToken(telefono.getNumero(), null, Constants.SMS_TYPE, httpRequest);

			jwt.addAttribute(JWT_TOKEN_OLD_PHONE_NUMBER_KEY, jwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY));
			jwt.addAttribute(JWT_TOKEN_CUSTOMER_ID_KEY, clientId);
			jwt.addAttribute(JWT_TOKEN_PHONE_NUMBER_KEY, telefono.getNumero());

			return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
		} catch (TokenExpiredException e) {
			e.printStackTrace();
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error TokenExpiredException InvalidTokenException: " + e);
			return unauthorizedResponse(e.getMessage());
//		} catch (MobileServiceException e) {
//			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error en Cambio de Numero Telefonico");
		}
	}

	@GET
	@Path("/security/client/changePhone")
	@Produces({ "application/json" })
	@Consumes({ "application/json" })
	public Response changePhoneGet(@Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio GET: /security/client/changePhone");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			generateAndSendToken(jwt.getAttribute("phoneNumber"), null, Constants.SMS_TYPE, httpRequest);
			return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
		} catch (TokenExpiredException e) {
			e.printStackTrace();
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error TokenExpiredException InvalidTokenException: " + e);
			return unauthorizedResponse(e.getMessage());
//		} catch (MobileServiceException e) {
//			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error en Cambio de Numero Telefonico");
		}
	}

	@POST
	@Path("/security/client/sendEmailToken")
	@Produces({ "application/json" })
	@Consumes({ "application/json" })
	public Response sendEmailToken(@Valid NotificationRequest notificationRequest, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio GET: /security/client/sendEmailToken");
				logger.logDebug(notificationRequest);
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			generateAndSendToken(null, notificationRequest.getSendingSource(), notificationRequest.getSendingType(), httpRequest);
			return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
		} catch (TokenExpiredException e) {
			logger.logDebug("Error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error TokenExpiredException InvalidTokenException: " + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al enviar token por correo.");
		}

	}

	private void generateAndSendToken(String phone, String email, String type, HttpServletRequest httpRequest) throws TokenExpiredException, InvalidTokenException {
		DataTokenRequest dataIn = new DataTokenRequest();
		CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
		String clientId = jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
		dataIn.setLogin(jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY));
		dataIn.setChannel(Constants.CHANNEL);
		dataIn.setClientPhoneNumber(phone);
		dataIn.setDestinationMail(email);
		dataIn.setSmsFlag(clientId);
		dataIn.setSendingType(type);
		dataIn.setClientId(Integer.valueOf(clientId));
		dataIn.setOperation(email != null ? Constants.VALIDATION_MAIL : Constants.CLIENT_MAIL);
		adminTokenUser.generateTokenUser(dataIn);
	}

	@POST
	@Path("/security/client/parameters")
	public Response parametersGet(@Valid ParameterRequest parameterRequest, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio: /security/client/parameters");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = (String) jwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			String customerId = (String) jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			GeneralParameters generalParameters = this.configurationService.getGeneralParameters(cobisSessionId, parameterRequest.getLoanId(), Integer.valueOf(customerId));
			if (generalParameters != null) {
				generalParameters.setNotificaciones(this.configurationService.getNotifications(cobisSessionId, Integer.valueOf(customerId)));
			}
			logger.logDebug("generalParameters " + generalParameters);
			return successResponse(generalParameters, jwt);
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@GET
	@Path("/security/client/parameters")
	public Response getGeneralParameters(@Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Servicio: /security/client/generalParameters");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = (String) jwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			ArrayList<ConfigParameter> cobisParameters = this.parameterService.getParameters(cobisSessionId);
			logger.logDebug("cobisParameters " + cobisParameters);

			return successResponse(cobisParameters, jwt);
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@POST
	@Path("/security/login")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response loginPost(@Valid Credentials credentials, @Context HttpServletRequest httpRequest) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIA LOGIN MOBIL");
		}

		try {

			boolean isEncrypted = credentials.getMode() == 0 ? true : false;
			return SecurityUtil.setResponse(credentials, new CobisJwt(new ShakeJwtKeyGenerator()), isEncrypted, false, configurationService, securityService, logger);
		} catch (MobileServiceException e) {
			return errorResponse(e);
		}
	}

	@POST
	@Path("/security/logout")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response logoutPost(@Context HttpServletRequest httpRequest) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIA LOGOUT MOBIL");
		}
		CobisJwt jwt;
		try {
			jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
		return performLogout(jwt, httpRequest);
	}

	@POST
	@Path("/security/onboard")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response onboardRegistryCodeGet(@Valid RegistryCode registryCode, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("INICIA SERVICIO /security/onboard");
			}
			Client client = this.registrationService.validateOnboardCode(registryCode.getCodigo());
			CobisJwt jwt = new CobisJwt(new ShakeJwtKeyGenerator());
			jwt.addAttribute(JWT_TOKEN_CUSTOMER_ID_KEY, client.getIdCliente());
			jwt.addAttribute(JWT_TOKEN_PHONE_NUMBER_KEY, client.getTelefono());
			jwt.addAttribute(JWT_LATITUDE, "0");
			jwt.addAttribute(JWT_LONGITUDE, "0");
			return successResponse(client, jwt);
		} catch (MobileServiceException e) {
			return errorResponse(e);
		}
	}

	@POST
	@Path("/security/password/reset")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response resetPasswordPut(@Valid ResetPasswordRequest resetPasswordRequest, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("INICIA SERVICIO /security/password/reset");
			}
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String customerId = (String) jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			this.securityService.resetPassword(customerId, resetPasswordRequest.getPhone(), resetPasswordRequest.getPassword());

			Credentials credentials = new Credentials();
			credentials.setPassword(resetPasswordRequest.getPassword());
			credentials.setUsername(resetPasswordRequest.getPhone());
			credentials.setCulture(Constants.CULTURE);
			credentials.setDevice(resetPasswordRequest.getDevice());
			credentials.setConnectAddress(resetPasswordRequest.getConnectAddress());

			return SecurityUtil.setResponse(credentials, jwt, true, false, configurationService, securityService, logger);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		}
	}

	@GET
	@Path("/image/getRandomImages")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response getRandomImages(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest) {
		logger.logDebug("Inicia getRandomImages /security/image/random");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			// logger.logDebug("/security/image/random >> CobisJwt " +
			// cobisJwt);
			SecurityImageResponse images = imageService.getRandomImages(request, null);
			return successResponse(images.getSecurityImageItems(), cobisJwt);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		}

	}

	@PUT
	@Path("/image/insert")
	@Consumes({ "application/json" })
	public Response insertLoginImage(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest) {
		logger.logDebug("Inicia getRandomImages /security/image/registry");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/security/image/registry >> CobisJwt " + cobisJwt);
			// String cobisSessionId =
			// cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			String login = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			request.setLogin(login);

			if (request.getMode() != null && request.getMode().equals("U")) {
				String clientId = cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY);
				request.setCustomerId(clientId);
			}
			imageService.insertLoginImage(request, null);
			return successResponse(null, cobisJwt);
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@POST
	@Path("/image/getImageLogin")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response getImageLogin(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest) {
		logger.logDebug("Inicia getRandomImages security/image/login");
		try {
			// CobisJwt cobisJwt = new
			// CobisJwt(httpRequest.getHeader(AUTHORIZATION), new
			// ShakeJwtKeyGenerator());
			// logger.logDebug("security/image/login >> CobisJwt " + cobisJwt);
			// String login = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);

			SecurityImageResponse images = imageService.getImageLogin(request, null);
			return successResponse(images.getSecurityImageItems(), new CobisJwt(new ShakeJwtKeyGenerator()));
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		}
	}

	@POST
	@Path("/security/mail/valid")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response validateMail(@Valid Registration request, @Context HttpServletRequest httpRequest) {
		logger.logDebug("Inicia validateMail security/registration/valid");
		try {
			CobisJwt cobisJwt = new CobisJwt(new ShakeJwtKeyGenerator());
			return successResponse(securityService.validateRegistration(request), cobisJwt);
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logError(e);
			return errorResponse(e);
		}
	}

	protected void setSecurityService(ISecurityService securityService) {
		this.securityService = securityService;
	}

	protected void unsetSecurityService(ISecurityService securityService) {
		this.securityService = null;
	}

	protected void setRegistrationService(IRegistrationService registrationService) {
		this.registrationService = registrationService;
	}

	protected void unsetRegistrationService(IRegistrationService registrationService) {
		this.registrationService = null;
	}

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

	public void setParameterService(IParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(IParameterService parameterService) {
		this.parameterService = null;
	}

	public void setImageService(ISecurityImageService imageService) {
		this.imageService = imageService;
	}

	public void unsetImageService(ISecurityImageService imageService) {
		this.imageService = null;
	}

	public Response performLogout(CobisJwt jwt, HttpServletRequest httpRequest) {
		try {
			String sessionId = (String) jwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			String login = (String) jwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			String terminal = (String) jwt.getAttribute(JWT_DEVICE_ID);
			securityService.logout(sessionId, login, terminal);
			if (logger.isDebugEnabled()) {
				logger.logDebug("===============> logout user: ");
			}
			return Response.ok().build();
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logInfo(e);
			return errorResponse(e.getMessage());
		}
	}

}
