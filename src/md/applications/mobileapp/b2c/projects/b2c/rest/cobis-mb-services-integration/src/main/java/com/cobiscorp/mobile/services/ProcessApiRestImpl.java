package com.cobiscorp.mobile.services;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
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
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Task;
import com.cobiscorp.mobile.rest.interfaces.IRestProcessService;
import com.cobiscorp.mobile.service.interfaces.IParameterService;
import com.cobiscorp.mobile.service.interfaces.IProcessService;
import com.cobiscorp.mobile.service.interfaces.ICustomerService;

/**
 * Procesos en Línea
 *
 * <p>
 * Servicios para aplicación de procesos en línea
 *
 */
@Path("/channels/mobilebanking")
@Component
@Service({ IRestProcessService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class ProcessApiRestImpl extends RestServiceBase implements IRestProcessService {

	@Reference(bind = "setProcessService", unbind = "unsetProcessService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IProcessService processService;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IParameterService parameterService;

	@Reference(bind = "setCustomerService", unbind = "unsetCustomerService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICustomerService customerService;

	private final ILogger LOGGER = LogFactory.getLogger(ProcessApiRestImpl.class);

	@GET
	@Path("/process")
	public Response getTaskList(@Context HttpServletRequest httpRequest) {
		LOGGER.logDebug("/channels/mobilebanking/process");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			String customerId = cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY);
			String identification = customerService.getCurpByCustomerId(Integer.parseInt(customerId), cobisSessionId);
			LOGGER.logDebug("/channels/mobilebanking/process >> cobisSessionId " + cobisSessionId);
			List<Task> tasks = processService.getTaskList(identification, cobisSessionId);
			LOGGER.logDebug("/channels/mobilebanking/process >> Response :" + tasks);
			return successResponse(tasks, cobisJwt);
		} catch (MobileServiceException e) {
			LOGGER.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			LOGGER.logError("Error Throwable: ", e);
			return errorResponse("Error al obtener de los procesos");
		}
	}

	@POST
	@Path("/startProcess")
	public Response startProcess(@Context HttpServletRequest httpRequest) {
		LOGGER.logDebug("POST /channels/mobilebanking/startProcess>> ");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			Integer customerId = Integer.parseInt(cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY));
			String identification = customerService.getCurpByCustomerId(customerId, cobisSessionId);
			String processName = parameterService.searchParameter("WSOBOA", "CRE", cobisSessionId).getCharValue();
			LOGGER.logDebug("/channels/mobilebanking/startProcess >> cobisSessionId " + cobisSessionId);
			processService.startProcess(processName, identification, customerId, cobisSessionId);
			return Response.ok().header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
		} catch (MobileServiceException e) {
			LOGGER.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			LOGGER.logError("Error Throwable: ", e);
			return errorResponse("Error al aplicar el inicio del proceso");
		}
	}

	@POST
	@Path("/nextActivity")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response nextActivity(@Valid Task task, @Context HttpServletRequest httpRequest) {
		LOGGER.logDebug("POST /channels/mobilebanking/nextActivity>> " + task);
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			LOGGER.logDebug("/channels/mobilebanking/startProcess >> cobisSessionId " + cobisSessionId);
			processService.nextActivity(task, cobisSessionId);
			return Response.ok().header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
		} catch (MobileServiceException e) {
			LOGGER.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			LOGGER.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			LOGGER.logError("Error Throwable: ", e);
			return errorResponse("Error al aplicar el paso de la siguiente actividad");
		}
	}

	public void unsetProcessService(IProcessService processService) {
		this.processService = null;
	}

	public void setProcessService(IProcessService processService) {
		this.processService = processService;
	}

	public void unsetParameterService(IParameterService parameterService) {
		this.parameterService = null;
	}

	public void setParameterService(IParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetCustomerService(ICustomerService customerService) {
		this.customerService = null;
	}

	public void setCustomerService(ICustomerService customerService) {
		this.customerService = customerService;
	}

}
