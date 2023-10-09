package com.cobiscorp.ecobis.cloud.service;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cloud.service.dto.security.AcceptanceDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.security.CodeOtp;
import com.cobiscorp.ecobis.cloud.service.dto.security.LoginRequest;

/**
 * Created by farid on 7/25/2017.
 */
public interface SecurityService {
	Response login(LoginRequest loginRequest, @Context HttpServletRequest httpRequest);

	Response sendCode(@Valid CodeOtp codeOtp, @Context HttpServletRequest httpRequest);

	Response validationCode(@Valid CodeOtp codeOtp, @Context HttpServletRequest httpRequest);

	Response saveAcceptance(AcceptanceDataRequest acceptanceDataRequest, @Context HttpServletRequest httpRequest);

}
