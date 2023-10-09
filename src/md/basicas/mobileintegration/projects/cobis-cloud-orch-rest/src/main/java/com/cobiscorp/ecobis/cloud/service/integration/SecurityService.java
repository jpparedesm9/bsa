package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.security.model.User;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.ecobis.cloud.service.dto.security.AcceptanceDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.security.CodeOtp;
import com.cobiscorp.ecobis.cloud.service.dto.security.LoginRequest;
import com.cobiscorp.ecobis.cloud.service.dto.security.Route;
import com.cobiscorp.ecobis.cloud.service.dto.security.ValidationCodeResponse;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.businesstobusiness.dto.AcceptanceRequest;
import cobiscorp.ecobis.businesstobusiness.dto.SendCodeRequest;
import cobiscorp.ecobis.businesstobusiness.dto.ValidateCodeRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Created by farid on 7/25/2017.
 */
public class SecurityService extends RestServiceBase {
	private final ILogger logger = LogFactory.getLogger(SecurityService.class);
	private final String className = "[SecurityService] ";

	public SecurityService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public SecurityService() {
	}

	private IAdminTokenUser adminTokenUser;

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	public Boolean isValid(LoginRequest loginRequest) {
		return true;
	}

	public User getUser(LoginRequest loginRequest) {
		User user = new User();
		user.setUserName(loginRequest.getUser());
		user.setPassword(loginRequest.getPassword());
		user.setOfficeId(1);
		user.setRoleId(3);
		return user;
	}

	public Route sendOtp(CodeOtp codeOtp, HttpServletRequest httpRequest) { // throws MobileServiceException {
		String tokenLength;
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		SendCodeRequest sendCodeRequest = new SendCodeRequest();
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		Route responseValue = null;

		sendCodeRequest.setCanal(codeOtp.getCanal());
		sendCodeRequest.setNumMail(codeOtp.getPhoneMail());
		sendCodeRequest.setTipo(codeOtp.getTipo());
		sendCodeRequest.setCodEnte(codeOtp.getCodEnte());

		if (logger.isDebugEnabled()) {
			logger.logDebug("sendOtp -> " + sendCodeRequest.getCanal() + ", " + sendCodeRequest.getNumMail() + ", " + sendCodeRequest.getTipo() + ", " + sendCodeRequest.getCodEnte() + ", ");
		}

		tokenLength = adminTokenUser.getTokenLength();
		// Logica para generar el token
		String aux1 = "9", aux2 = "0";
		Random randomGenerator = new Random();

		for (int idx = 1; idx < Integer.parseInt(tokenLength); ++idx) {
			aux1 = aux1 + "0";
			aux2 = aux2 + "9";
		}

		int randomInt = randomGenerator.nextInt(Integer.parseInt(aux1)) + Integer.parseInt(aux2);
		sendCodeRequest.setOtp(String.valueOf(randomInt));
		serviceRequest.addValue("inSendCodeRequest", sendCodeRequest);
		if (logger.isDebugEnabled()) {
			logger.logDebug("sendOtp -> " + randomInt);
		}

		ServiceResponse response = execute("BusinessToBusiness.SecurityManagement.SendOtp", serviceRequest);

		responseValue = new Route(extractOutputValue(response, "@o_ente", Integer.class), extractOutputValue(response, "@o_proceso", Integer.class));

		return responseValue;
	}

	public ValidationCodeResponse validationOtp(CodeOtp codeOtp, HttpServletRequest httpRequest) { // throws MobileServiceException {
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ValidateCodeRequest validationCodeRequest = new ValidateCodeRequest();

		ValidationCodeResponse response = null;

		validationCodeRequest.setCanal(codeOtp.getCanal());
		validationCodeRequest.setNumMail(codeOtp.getPhoneMail());
		validationCodeRequest.setTipo(codeOtp.getTipo());
		validationCodeRequest.setCodigo(codeOtp.getCode());

		serviceRequest.addValue("inValidateCodeRequest", validationCodeRequest);

		ServiceResponse servResponse = execute("BusinessToBusiness.SecurityManagement.ValidationOtp", serviceRequest);

		if (servResponse != null) {
			response = new ValidationCodeResponse();
			response.setValue("Validado");
			response.setFecha(new Date().toString());
		}

		return response;

	}

	public ServiceResponse saveAcceptance(AcceptanceDataRequest acceptanceDataRequest, HttpServletRequest httpRequest) {
		logger.logDebug(".......---------SecurityService.saveAcceptance");

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		AcceptanceRequest acceptanceRequest = new AcceptanceRequest();

		int channel = Integer.parseInt(httpRequest.getHeader(Constants.CHANNEL));
		logger.logDebug("----SecurityService.saveAcceptance:canal: " + channel);

		acceptanceRequest.setAcceptanceType(acceptanceDataRequest.getAcceptanceType());
		acceptanceRequest.setResult(acceptanceDataRequest.getResult());
		acceptanceRequest.setChannel(channel);
		acceptanceRequest.setClientId(acceptanceDataRequest.getClientId());
		acceptanceRequest.setOperation("I");
		acceptanceRequest.setDateAcceptance(acceptanceDataRequest.getDateAcceptance());

		serviceRequest.addValue("inAcceptanceRequest", acceptanceRequest);

		ServiceResponse servResponse = execute("BusinessToBusiness.SecurityManagement.SaveAcceptance", serviceRequest);

		return servResponse;
	}

}
