package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
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
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Address;
import com.cobiscorp.mobile.model.AddressResponse;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Customer;
import com.cobiscorp.mobile.rest.interfaces.IRestCustomerService;
import com.cobiscorp.mobile.service.interfaces.ICustomerService;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestCustomerService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class CustomerApiRestImpl extends RestServiceBase implements IRestCustomerService {

	@Reference(bind = "setCustomerService", unbind = "unsetCustomerService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICustomerService customerService;

	@PUT
	@Path("/prospect")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response updateProspect(@Valid Customer prospect, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("/channels/mobilebanking/prospect ==> PUT");
				logger.logDebug("prospect>>" + prospect);
			}
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			Integer customerId = Integer.parseInt(cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY));
			prospect.setId(customerId);
			customerService.updateProspect(prospect, cobisSessionId);
			return Response.ok().header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
		} catch (MobileServiceException e) {
			logger.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al obtener información de préstamos");
		}
	}

	@POST
	@Path("/address")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response createAddress(@Valid Address address, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("/channels/mobilebanking/address ==> POST");
				logger.logDebug("address>>" + address);
			}
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			Integer customerId = Integer.parseInt(cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY));
			address.setType(Constants.HOME_ADDRESS_TYPE);
			address.setCustomerId(customerId);
			AddressResponse addressResponse = customerService.createAddress(address, cobisSessionId);
			return successResponse(addressResponse, cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al crear la dirección");
		}
	}

	@PUT
	@Path("/address")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response updateAddress(@Valid Address addressRequest, @Context HttpServletRequest httpRequest) {
		return null;
	}

	@POST
	@Path("/email")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response createEmail(@Valid Address address, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("/channels/mobilebanking/email ==> POST");
				logger.logDebug("address>>" + address);
			}
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			Integer customerId = Integer.parseInt(cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY));
			address.setType(Constants.EMAIL_ADDRESS_TYPE);
			address.setCustomerId(customerId);
			AddressResponse addressResponse = customerService.createAddress(address, cobisSessionId);
			return successResponse(addressResponse, cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError(e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al crear la dirección");
		}
	}

	public void setCustomerService(ICustomerService customerService) {
		this.customerService = customerService;
	}

	public void unsetCustomerService(ICustomerService customerService) {
		this.customerService = null;
	}
}
