package com.cobiscorp.mobile.services.impl;

import java.net.InetAddress;
import java.security.Key;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Answer;
import com.cobiscorp.mobile.model.ChangePasswordRequest;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.LoginResponse;
import com.cobiscorp.mobile.model.LogoutResponse;
import com.cobiscorp.mobile.model.Registration;
import com.cobiscorp.mobile.model.Question;
import com.cobiscorp.mobile.service.interfaces.ISecurityService;
import com.cobiscorp.mobile.services.impl.utils.Activator;
import com.cobiscorp.mobile.services.impl.utils.KeepSecurity;
import com.cobiscorp.mobile.services.impl.utils.PasswordUtils;

import cobiscorp.ecobis.businesstoconsumer.dto.ValidateAnswersRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.ValidationQuestionRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.ValidationQuestionResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.ValidationRequest;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.cts.integration.services.dto.CTSLoginRequest;
import cobiscorp.ecobis.cts.integration.services.dto.CTSLoginResponse;
import cobiscorp.ecobis.cts.integration.services.dto.CTSSessionRequest;
import cobiscorp.ecobis.mobilebanking.dto.Ente;

/**
 * @author fespinosa
 * 
 */
@Component
@Service({ ISecurityService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class SecurityServiceImpl extends ServiceBase implements ISecurityService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private static final String ID_APPLICATION = "bancaMovil";

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> SecurityServiceImpl] ";

	/** Logger. */
	private ILogger LOGGER = LogFactory.getLogger(SecurityServiceImpl.class);

	private Map<String, Key> privateKeysMap;

	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	@Override
	public LoginResponse login(Credentials credentials, Integer channel, boolean isEncripted)
			throws MobileServiceException {
		
		LoginResponse response = new LoginResponse();
		Activator.loadConfig();
		CTSLoginRequest ctsLoginRequest = new CTSLoginRequest();

		ctsLoginRequest.setApplication(ID_APPLICATION);
		ctsLoginRequest.setAuthenticationType(ID_APPLICATION);
		ctsLoginRequest.setNcs(true);
		ctsLoginRequest.setSecondaryLogin(null);
		ctsLoginRequest.addData("servicio", channel);

		try {
			if (credentials != null) {
				LOGGER.logInfo(CLASS_NAME + "Iniciando login de usuario " + credentials.getUsername() + " en B2C");

				String decryptedPass = null;
				if (isEncripted) {
					String cryptedPasswordHexa = credentials.getPassword();
					if (cryptedPasswordHexa == null) {
						throw new MobileServiceException("password parameter is required for mobile");
					}
					KeepSecurity keepSecurity = new KeepSecurity(null,
							Activator.getPrivateKey().toString().toCharArray());
					decryptedPass = keepSecurity.decrypt(cryptedPasswordHexa);
				} else {
					decryptedPass = credentials.getPassword();
				}

				String pwd = this.cobisCrypt.enCrypt(decryptedPass, decryptedPass);
				ctsLoginRequest.setPassword(pwd);
				ctsLoginRequest.setLogin(credentials.getUsername());
				ctsLoginRequest.addData("culture", credentials.getCulture());
				ctsLoginRequest.addData("connectAddress", credentials.getConnectAddress());
				if (credentials.getDevice() != null) {
					ctsLoginRequest.setTerminal(credentials.getDevice());
				} else {
					ctsLoginRequest.setTerminal(credentials.getUsername());
				}

			}
		} catch (Exception e) {
			LOGGER.logError(e, e);
			throw new MobileServiceException(e);
		}

		try {
			LOGGER.logInfo(CLASS_NAME + "Login hostname: " + InetAddress.getLocalHost().getHostName());
			ctsLoginRequest.addData("webserver", InetAddress.getLocalHost().getHostName());

		} catch (Exception e) {
			LOGGER.logError(e, e);
			throw new MobileServiceException(e);
		}

		if (credentials != null) {
			response = loginCTS(ctsLoginRequest, credentials.getUsername());
			LOGGER.logInfo(CLASS_NAME + "Finalizando login de usuario " + credentials.getUsername() + " en B2C");
		}

		return response;
	}

	public LoginResponse loginCTS(CTSLoginRequest ctsLoginRequest, String username) throws MobileServiceException {
		CTSLoginResponse ctsLoginResponse;
		LoginResponse response = new LoginResponse();
		try {
			ctsLoginResponse = this.serviceIntegration.authenticateUser(ctsLoginRequest);
		} catch (Exception e) {
			LOGGER.logError(e, e);
			throw new MobileServiceException(e);
		}
		if (ctsLoginResponse != null) {
			if (ctsLoginResponse.isSucess()) {
				if (ctsLoginResponse.getResponseData().getString("sessionID") != null) {
					response.setSessionId(ctsLoginResponse.getResponseData().getString("sessionID"));
				}
				if (ctsLoginResponse.getResponseData().getString("cultura") != null) {
					response.setCulture(ctsLoginResponse.getResponseData().getString("cultura"));
				}
				if (ctsLoginResponse.getResponseData().getString("cliente") != null) {
					response.setClientId(ctsLoginResponse.getResponseData().getString("cliente"));
				}
				if (ctsLoginResponse.getResponseData().getString("cliente_mis") != null) {
					response.setCustomerId(ctsLoginResponse.getResponseData().getString("cliente_mis"));
				}
				response.setLogin(username);
			} else {
				LOGGER.logInfo(CLASS_NAME + "Fallo en la ejecucion del servicio.");
				manageResponseError(LOGGER, ctsLoginResponse.getMessages());
			}
		}
		return response;
	}

	@Override
	public LogoutResponse logout(String cobisSessionId, String phoneNumber, String deviceId)
			throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Logout SessionID : " + cobisSessionId + " de usuario: " + phoneNumber);
		}

		LogoutResponse logoutResponse = new LogoutResponse();

		// FINALIZANDO USUARIO
		CTSSessionRequest ctsSessionRequest = new CTSSessionRequest();
		ctsSessionRequest.setUser(phoneNumber);
		ctsSessionRequest.setSessionId(cobisSessionId);

		try {
			// Method to get CTS hostname
			LOGGER.logInfo(CLASS_NAME + "Logout hostname: " + InetAddress.getLocalHost().getHostName());
			ctsSessionRequest.addData("webserver", InetAddress.getLocalHost().getHostName());

		} catch (Exception e) {
			logoutResponse.setSuccess(false);
			LOGGER.logError(e, e);
			throw new MobileServiceException(e);
		}

		// ctsSessionRequest.addData("webserver", phoneNumber);
		if (deviceId != null) {
			ctsSessionRequest.addData("terminalIP", deviceId);
		} else {
			ctsSessionRequest.addData("terminalIP", phoneNumber);
		}
		ctsSessionRequest.setApplicationId(ID_APPLICATION);

		try {
			this.serviceIntegration.finalizeSession(ctsSessionRequest);
		} catch (Exception e) {
			LOGGER.logError(e, e);
			logoutResponse.setSuccess(false);
			throw new MobileServiceException(e);
		}
		logoutResponse.setSuccess(true);
		LOGGER.logInfo(CLASS_NAME + "Finalizando logout de usuario " + phoneNumber + " en B2C");
		return logoutResponse;
	}

	@Override
	public List<Question> findSecurityQuestions(Integer customerId) throws MobileServiceException {
		List<Question> questions = null;

		ValidationQuestionRequest validationQuestionRequest = new ValidationQuestionRequest();
		validationQuestionRequest.setCustomerId(customerId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inValidationQuestionRequest", validationQuestionRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion", EMPTY_COBIS_SESSION_ID,
					serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				ValidationQuestionResponse[] validationQuestionResponseList = (ValidationQuestionResponse[]) serviceResponseTO
						.getValue("returnValidationQuestionResponse");
				questions = new ArrayList<Question>();
				for (ValidationQuestionResponse validationQuestion : validationQuestionResponseList) {
					Question question = new Question();
					question.setQuestionId(validationQuestion.getQuestionId());
					question.setQuestion(validationQuestion.getQuestionText());
					question.setResponseType(validationQuestion.getAnswerType());
					question.setAllowEmptyAnswer((validationQuestion.getAllowEmptyAnswer() != null
							&& validationQuestion.getAllowEmptyAnswer().equals("S")) ? Boolean.TRUE : Boolean.FALSE);
					questions.add(question);
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}

		return questions;
	}

	@Override
	@SuppressWarnings("unchecked")
	public void validateSecurityAnswers(Integer customerId, List<Answer> answers) throws MobileServiceException {
		ValidateAnswersRequest validateAnswerRequest = new ValidateAnswersRequest();

		validateAnswerRequest.setCustomerId(customerId);
		validateAnswerRequest.setQuestion1(answers.get(0).getQuestionId());
		validateAnswerRequest.setAnswer1(answers.get(0).getAnswer());
		validateAnswerRequest.setQuestion2(answers.get(1).getQuestionId());
		validateAnswerRequest.setAnswer2(answers.get(1).getAnswer());
		validateAnswerRequest.setQuestion3(answers.get(2).getQuestionId());
		validateAnswerRequest.setAnswer3(answers.get(2).getAnswer());

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inValidateAnswersRequest", validateAnswerRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"BusinessToConsumer.RegistrationManagement.ValidateAnswers", EMPTY_COBIS_SESSION_ID,
					serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("============= validateSecurityAnswers =============");
					LOGGER.logDebug("====> serviceResponseTO.data " + serviceResponseTO.getData());
				}
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseTO
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				String resultado = applicationResponse.get("@o_resultado").toString();
				if (resultado == null || "N".equalsIgnoreCase(resultado)) {
					MessageTO message = new MessageTO();
					message.setCode(
							serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.return").toString());

					String messageText = applicationResponse.get("@o_msg").toString();
					message.setMessage(messageText.trim().isEmpty() ? "Las respuestas ingresadas son incorrectas"
							: messageText.trim());
					manageResponseError(LOGGER, message);
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	@Override
	public void changePassword(Client client, ChangePasswordRequest changePassword, String cobisSessionId)
			throws MobileServiceException {
		Ente ente = new Ente();
		String cryptedPasswordHexaNew = changePassword.getNewPassword();
		String cryptedPasswordHexaOld = changePassword.getOldPassword();
		if (cryptedPasswordHexaNew == null || cryptedPasswordHexaOld == null) {
			throw new MobileServiceException("Password parameter is required for mobile");
		}
		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
		String decryptedPassOld = keepSecurity.decrypt(cryptedPasswordHexaOld);
		String decryptedPassNew = keepSecurity.decrypt(cryptedPasswordHexaNew);

		validatePass(decryptedPassNew);

		String pwdNew = this.cobisCrypt.enCrypt(decryptedPassNew, decryptedPassNew);
		String pwdOld = this.cobisCrypt.enCrypt(decryptedPassOld, decryptedPassOld);
		ente.setIdEnte(Integer.parseInt(client.getIdCliente()));
		ente.setPassword(pwdNew);
		ente.setRealPassword(pwdOld);
		ente.setUser(client.getTelefono());
		ente.setChannel(Integer.valueOf(Constants.CHANNEL));

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inEnte", ente);
		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"MobileBanking.Service.Password.UpdateDefinitivePassword", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess() && LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("*******************> Se actualiza el password");
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	private void validatePass(String decryptedPassNew) throws MobileServiceException {
		if (!PasswordUtils.validateComplexity(decryptedPassNew)) {
			throw new MobileServiceException("La clave no puede contener 3 dÃ­gitos repetidos de forma consecutiva");
		}
	}

	@Override
	public void resetPassword(String customerId, String phone, String password) throws MobileServiceException {
		Activator.loadConfig();
		Ente ente = new Ente();
		if (password == null) {
			throw new MobileServiceException("password parameter is required for mobile");
		}
		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
		String decryptedPass = keepSecurity.decrypt(password);

		validatePass(decryptedPass);

		String pwdNew = this.cobisCrypt.enCrypt(decryptedPass, decryptedPass);
		ente.setEnteMis(Integer.valueOf(customerId));
		ente.setTemporalPassword(pwdNew);
		ente.setUser(phone);
		ente.setChannel(Integer.valueOf(Constants.CHANNEL));

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inEnte", ente);
		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"MobileBanking.Service.Password.CreateDefinitivePassword", EMPTY_COBIS_SESSION_ID, serviceRequest);
			if (serviceResponseTO.isSuccess() && LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("*******************> Se actualiza el password");
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	@Override
	public void temporalBlock(String phone, String clientId, String cobisSessionId) throws MobileServiceException {
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		Ente ente = new Ente();
		ente.setLogin(phone);
		ente.setChannel(Integer.valueOf(Constants.CHANNEL));
		ente.setIdEnte(Integer.valueOf(clientId));
		serviceRequest.addValue("inEnte", ente);
		ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
				"BusinessToConsumer.RegistrationManagement.BlockingByClient", cobisSessionId, serviceRequest);
		if (serviceResponseTO.isSuccess() && LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("*******************> Se actualiza el password");
		} else {
			manageResponseError(serviceResponseTO, LOGGER);
		}
	}

	@Override
	public void unblock(String phone, Integer customerId, List<Answer> answers) throws MobileServiceException {
		validateSecurityAnswers(customerId, answers);

		LOGGER.logInfo("Respuestas correctas, procede a desbloquear");

		Ente ente = new Ente();

		LOGGER.logInfo("Login o phone: " + phone);
		ente.setLogin(phone);
		ente.setChannel(Integer.valueOf(Constants.CHANNEL));
		ente.setEnteMis(customerId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inEnte", ente);

		ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
				"BusinessToConsumer.RegistrationManagement.UnlockByClient", EMPTY_COBIS_SESSION_ID, serviceRequest);
		if (serviceResponseTO.isSuccess() && LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("*******************> Cliente desbloqueado");
		} else {
			manageResponseError(serviceResponseTO, LOGGER);
		}
	}

	@Override
	public Registration validateRegistration(Registration registration) throws MobileServiceException {
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ValidationRequest validation = new ValidationRequest();
		validation.setMail(registration.getMail());
		validation.setCellphoneNumber(registration.getCellphoneNumber());
		validation.setValidationType(registration.getValidationType());
		serviceRequest.addValue("inValidationRequest", validation);

		ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
				"BusinessToConsumer.RegistrationManagement.ValidateRegistration", EMPTY_COBIS_SESSION_ID,
				serviceRequest);

		Registration registrationResponse = new Registration();

		if (serviceResponseTO.isSuccess() && LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("*******************> Mensaje enviado");
			registrationResponse.setIsValid(true);
		} else {
			manageResponseError(serviceResponseTO, LOGGER);
		}
		return registrationResponse;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public Map<String, Key> getPrivateKeysMap() {
		return this.privateKeysMap;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
