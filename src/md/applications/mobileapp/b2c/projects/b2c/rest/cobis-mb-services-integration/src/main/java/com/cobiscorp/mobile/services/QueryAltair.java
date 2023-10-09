package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
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
import com.cobiscorp.mobile.request.CustomerRequest;
import com.cobiscorp.mobile.rest.interfaces.IRestQueryAltair;
import com.cobiscorp.mobile.service.interfaces.IQueryAltair;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestQueryAltair.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class QueryAltair extends RestServiceBase implements IRestQueryAltair {

	private final ILogger logger = LogFactory.getLogger(QueryAltair.class);

	// Referencias
	@Reference(bind = "setQueryAltair", unbind = "unsetQueryAltair", cardinality = ReferenceCardinality.MANDATORY_UNARY)

	private IQueryAltair queryAltair;

	// deberia ser get y enviar los paramtros en la url
	@POST
	@Path("/customer/altair")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response queryAltair(@Valid CustomerRequest altairRequest, @Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/queryAltair >> ");

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/queryAltair >> CobisJwt " + cobisJwt);

			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/queryAltair >> cobisSessionId " + cobisSessionId);

			return successResponse(queryAltair.queryAltairImp(altairRequest,cobisSessionId), cobisJwt);

		} catch (TokenExpiredException e) {
			logger.logError("Error en queryAltair TokenExpiredException  ",e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error en queryAltair InvalidTokenException  ",e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("Error en queryAltair MobileServiceException  ",e);
			return errorResponse(e);
		}catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al ejecutar servicio de  Altair");
		}
	}

	protected void setQueryAltair(IQueryAltair queryAltair) {
		this.queryAltair = queryAltair;
	}

	protected void unsetQueryAltair(IQueryAltair queryAltair) {
		this.queryAltair = null;
	}

}
