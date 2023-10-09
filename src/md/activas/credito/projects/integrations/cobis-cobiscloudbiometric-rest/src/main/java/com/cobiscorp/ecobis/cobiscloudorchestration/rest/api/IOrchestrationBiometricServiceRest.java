package com.cobiscorp.ecobis.cobiscloudorchestration.rest.api;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientRequest;

public interface IOrchestrationBiometricServiceRest {

	ServiceResponse accessToken() throws IOException;

	ServiceResponse opaqueToken(ClientInformation clientInformation, @Context HttpServletRequest request);

	ServiceResponse renapoQueryByDetail(RenapoClientRequest renapoClientRequest);
}
