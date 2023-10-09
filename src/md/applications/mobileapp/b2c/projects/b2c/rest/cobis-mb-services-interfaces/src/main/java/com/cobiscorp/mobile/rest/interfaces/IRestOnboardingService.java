package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.OnboardingRequest;

public interface IRestOnboardingService {
	public Response register(@Valid OnboardingRequest onboardingRequest, @Context HttpServletRequest httpRequest);

}
