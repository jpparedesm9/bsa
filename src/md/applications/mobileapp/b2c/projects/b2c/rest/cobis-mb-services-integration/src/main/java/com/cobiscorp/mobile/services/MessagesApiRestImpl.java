package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
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
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.ExecuteMessageRequest;
import com.cobiscorp.mobile.model.TransactionInfo;
import com.cobiscorp.mobile.rest.interfaces.IRestMessagesService;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestMessagesService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class MessagesApiRestImpl extends RestServiceBase implements IRestMessagesService {

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	@PUT
	@Path("/messages/execute")
	public Response executeMessage(@Valid ExecuteMessageRequest executeMessageRequest, @Context HttpServletRequest httpRequest) {
		try {
			CobisJwt jwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			executeMessageRequest.setClientId(jwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY));
			executeMessageRequest.setCustomerId(Integer.valueOf(jwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY)));
			executeMessageRequest.setLogin(jwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY));

			String cobisSessionId = jwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);

			TransactionInfo transactionInfo = configurationService.executeNotification(cobisSessionId, executeMessageRequest);

			logger.logDebug("Respuesta executeMessage "+transactionInfo);
			//return Response.ok().header(JWT_TOKEN_ID, jwt.generateJws()).build();
			return successResponse(transactionInfo, jwt);
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
			return errorResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
			return errorResponse(e.getMessage());
		} catch (MobileServiceException e) {
			if (logger.isDebugEnabled()) {
    			logger.logDebug(e.getMessage());
    		}
        	logger.logInfo(e);
			return errorResponse(e);
		}
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}
}
