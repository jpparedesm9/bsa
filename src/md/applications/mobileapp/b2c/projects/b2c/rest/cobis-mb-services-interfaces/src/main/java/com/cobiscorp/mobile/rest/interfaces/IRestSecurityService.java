package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.Answers;
import com.cobiscorp.mobile.model.ChangePasswordRequest;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.Mail;
import com.cobiscorp.mobile.model.Registration;
import com.cobiscorp.mobile.model.OtpResponse;
import com.cobiscorp.mobile.model.ParameterRequest;
import com.cobiscorp.mobile.model.Password;
import com.cobiscorp.mobile.model.Phone;
import com.cobiscorp.mobile.model.RegistryCode;
import com.cobiscorp.mobile.model.ResetPasswordRequest;
import com.cobiscorp.mobile.model.SecurityImageRequest;

/**
 * Crédito en Línea
 *
 * <p>
 * Servicios para aplicación de crédito en
 *
 */
public interface IRestSecurityService {

	public Response passwordPost(@Valid Password password, @Context HttpServletRequest httpRequest);

	public Response passwordPut(@Valid ChangePasswordRequest password, @Context HttpServletRequest httpRequest);

	public Response challengeGet(@Valid Client cliente, @Context HttpServletRequest httpRequest);

	public Response challengePut(@Valid Answers answers, @Context HttpServletRequest httpRequest);

	public Response blockPhonePut(HttpServletRequest httpRequest);

	public Response changePhonePost(@Valid OtpResponse otpResponse, @Context HttpServletRequest httpRequest);

	public Response changePhonePut(@Valid Phone telefono, @Context HttpServletRequest httpRequest);

	public Response parametersGet(@Valid ParameterRequest parameterRequest, @Context HttpServletRequest httpRequest);

	public Response getGeneralParameters(@Context HttpServletRequest httpRequest);
	
	public Response loginPost(@Valid Credentials credentials, @Context HttpServletRequest httpRequest);

	public Response onboardRegistryCodeGet(@Valid RegistryCode registryCode, @Context HttpServletRequest httpRequest);

	public Response resetPasswordPut(ResetPasswordRequest resetPasswordRequest, HttpServletRequest httpRequest);

	public Response logoutPost(@Context HttpServletRequest httpRequest);

	public Response getRandomImages(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest);

	public Response insertLoginImage(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest);

	public Response getImageLogin(@Valid SecurityImageRequest request, @Context HttpServletRequest httpRequest);

	public Response validateMail(@Valid Registration request, @Context HttpServletRequest httpRequest);
		
}
