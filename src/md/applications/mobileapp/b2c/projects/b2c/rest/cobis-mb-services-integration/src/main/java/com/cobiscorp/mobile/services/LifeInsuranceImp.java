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
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.mobile.request.LifeInsuranceResquest;
import com.cobiscorp.mobile.rest.interfaces.IRestLifeInsurance;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.ILifeInsurance;
import com.cobiscorp.mobile.util.BankGeolocationUtil;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestLifeInsurance.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class LifeInsuranceImp extends RestServiceBase implements IRestLifeInsurance {

	private final ILogger logger = LogFactory.getLogger(LifeInsuranceImp.class);

	// Referencias
	@Reference(bind = "setLifeInsurance", unbind = "unsetLifeInsurance", cardinality = ReferenceCardinality.MANDATORY_UNARY)

	private ILifeInsurance lifeInsurance;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	// deberia ser get y enviar los paramtros en la url
	@POST
	@Path("/customer/saveLifeInsurance")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response saveLifeInsurance(@Valid LifeInsuranceResquest lifeInsuranceRequest, @Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/lifeInsurance >> ");
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			logger.logDebug("/channels/mobilebanking/saveLifeInsurance >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/saveLifeInsurance >> cobisSessionId " + cobisSessionId);

			BankGeolocation aBankGeoloc = BankGeolocationUtil.getBankGeolocDto(cobisJwt, "AUTSE", BankGeolocationUtil.POST_TYPE, clientId);
			serviceResponse = this.configurationService.registerBankGeolocation(aBankGeoloc);
			if (serviceResponse.isSuccess()) {
			return Response.ok(lifeInsurance.saveLifeInsuranceImp(lifeInsuranceRequest, cobisSessionId)).header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
			} else {
				logger.logError("Error Geolocalization: " + serviceResponse.getMessages());
				return errorResponse("" + serviceResponse.getMessages());
			}
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error de InvalidTokenException: " + e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("Error Throwable kycForm: ", e);
			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error en guardado de información Formulario KyC");
		}
	}

	protected void setLifeInsurance(ILifeInsurance lifeInsurance) {
		this.lifeInsurance = lifeInsurance;
	}

	protected void unsetLifeInsurance(ILifeInsurance lifeInsurance) {
		this.lifeInsurance = null;
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

}
