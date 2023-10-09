package com.cobiscorp.ecobis.cobiscloudorchestration.rest.api;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation;

public interface IOrchestrationBioOnboardingServiceRest {

	ServiceResponse execBioOnboarding(ClientInformation clientInformation, @Context HttpServletRequest request);
	
	ServiceResponse generateAccessToken() throws IOException;

	ServiceResponse opaqueToken(ClientInformation clientInformation, @Context HttpServletRequest request);

	ServiceResponse validateOpaqueToken(ClientInformation clientInformation, @Context HttpServletRequest request);

}
