/**
 
 * Autor..: Sonia Rojas
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudorchestration.rest.impl;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationBiometricServiceRest;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.service.BiocheckService;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Path("/cobis/web/OrchestrationBiometricServiceRest")
@Component
@org.apache.felix.scr.annotations.Service({ com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationBiometricServiceRest.class })
public class OrchestrationBiometricServiceRestImpl extends ServiceBase implements IOrchestrationBiometricServiceRest {
	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationBiometricServiceRestImpl.class);
	private static String pathNameService = "/cobis/web/OrchestrationBiometricServiceRest";

	BiocheckService biocheckService;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Path("/generateAccessToken")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@GET
	public ServiceResponse accessToken() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(".......---------OrchestrationBiometricServiceSERVImpl.accessToken");
		}
		ServiceResponse serviceResponse = this.execute(serviceIntegration, LOGGER, "OrchestrationBiometricServiceSERVImpl.accessTokenBC", new Object[] {});

		return serviceResponse;
	}

	@Path("/generateOpaqueToken")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	public ServiceResponse opaqueToken(ClientInformation clientInformation, @Context HttpServletRequest request) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Starts execution of the service " + pathNameService + "/generateOpaqueToken for biocheck");
		}
		if (null != clientInformation && null != clientInformation.getSesionSN()) {
			if (clientInformation.getSesionSN().toUpperCase().equals("PRE")) {
				clientInformation.setOfficeId(1234);
			} else {
				Integer officeId = biocheckService.getOfficeNumber(clientInformation.getSesionSN());
				clientInformation.setOfficeId(officeId);
			}

		}
		LOGGER.logDebug("ClientInformation: " + clientInformation);
		ServiceResponse serviceResponse = this.execute(serviceIntegration, LOGGER, "OrchestrationBiometricServiceSERVImpl.opaqueToken", new Object[] { clientInformation });
		return serviceResponse;
	}

	@Path("/renapoQueryByDetail")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	public ServiceResponse renapoQueryByDetail(RenapoClientRequest renapoClientRequest) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(".......---------OrchestationRenapoServiceSERVImpl.renapoQueryByDetail");
		}

		return this.execute(serviceIntegration, LOGGER, "OrchestationRenapoServiceSERVImpl.renapoQueryByDetail", new Object[] { renapoClientRequest });

	}

	private static final String HEADER_X_FORWARDED_FOR = "X-FORWARDED-FOR";
	private static final String WSRA = "$WSRA";

	public static String remoteAddr(HttpServletRequest request) {
		String remoteAddr = request.getRemoteAddr();
		String x;
		x = request.getHeader(WSRA) != null ? request.getHeader(WSRA) : request.getHeader(HEADER_X_FORWARDED_FOR) != null ? request.getHeader(HEADER_X_FORWARDED_FOR) : request.getRemoteAddr();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Header names: " + request.getHeaderNames());
			LOGGER.logDebug("IP value header: " + x);
		}

		if (x != null) {
			remoteAddr = x;
			int idx = remoteAddr.indexOf(',');
			if (idx > -1) {
				remoteAddr = remoteAddr.substring(0, idx);
			}
		}
		if (LOGGER.isTraceEnabled()) {
			LOGGER.logTrace("Remote Address: " + remoteAddr);
			logRequestInfo(request);
		}
		return remoteAddr;
	}

	private static void logRequestInfo(HttpServletRequest request) {
		Enumeration<String> headers = request.getHeaderNames(), attributes = request.getAttributeNames(), parameters = request.getParameterNames();

		LOGGER.logTrace("HEADERS INFO...");
		if (headers != null) {
			while (headers.hasMoreElements()) {
				String name = (String) headers.nextElement();
				LOGGER.logTrace("HEADER [" + name + "]: " + request.getHeader(name));
			}
		}

		LOGGER.logTrace("ATTRIBUTES INFO...");
		if (attributes != null) {
			while (attributes.hasMoreElements()) {
				String name = (String) attributes.nextElement();
				LOGGER.logTrace("ATTRIBUTE [" + name + "]: " + request.getAttribute(name));
			}
		}

		LOGGER.logTrace("PARAMETERS INFO...");
		if (parameters != null) {
			while (parameters.hasMoreElements()) {
				String name = (String) parameters.nextElement();
				LOGGER.logTrace("PARAMETER [" + name + "]: " + request.getParameter(name));
			}
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		this.biocheckService = new BiocheckService(serviceIntegration);
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
		this.biocheckService = new BiocheckService(null);
	}

}
