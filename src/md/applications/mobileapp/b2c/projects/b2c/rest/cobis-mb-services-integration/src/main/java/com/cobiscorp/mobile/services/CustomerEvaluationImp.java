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
import com.cobiscorp.mobile.rest.interfaces.IRestCustomerEvaluation;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.ICustomerEvaluation;
import com.cobiscorp.mobile.util.BankGeolocationUtil;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestCustomerEvaluation.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class CustomerEvaluationImp extends RestServiceBase implements IRestCustomerEvaluation {

	private final ILogger logger = LogFactory.getLogger(CustomerEvaluationImp.class);

	// Referencias
	@Reference(bind = "setCustomerEvaluation", unbind = "unsetCustomerEvaluation", cardinality = ReferenceCardinality.MANDATORY_UNARY)

	private ICustomerEvaluation customerEvaluation;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	// deberia ser get y enviar los paramtros en la url
	@POST
	@Path("/customer/evaluation")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response customerEvaluation(@Valid com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest customerEvaluationRequest,
			@Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/customerEvaluation >> ");
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			logger.logDebug("/channels/mobilebanking/customerEvaluation >> CobisJwt " + cobisJwt);

			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/customerEvaluation >> cobisSessionId " + cobisSessionId);

			BankGeolocation aBankGeoloc = BankGeolocationUtil.getBankGeolocDto(cobisJwt, "AUTBU", BankGeolocationUtil.POST_TYPE, clientId);
			serviceResponse = this.configurationService.registerBankGeolocation(aBankGeoloc);
			if (serviceResponse.isSuccess()) {
			return successResponse(customerEvaluation.customerEvaluationImpl(customerEvaluationRequest, cobisSessionId), cobisJwt);
			} else {
				logger.logError("Error Geolocalization: " + serviceResponse.getMessages());
				return errorResponse("" + serviceResponse.getMessages());
			}

		} catch (TokenExpiredException e) {
			logger.logError("Error en customerEvaluation TokenExpiredException  ", e);
			return unauthorizedResponse(e.getMessage());

		} catch (InvalidTokenException e) {
			logger.logError("Error en customerEvaluation TokenExpiredException  ", e);
			return unauthorizedResponse(e.getMessage());

		} catch (MobileServiceException e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al ejecutar la Evaluación del Cliente");

		}

	}

	protected void setCustomerEvaluation(ICustomerEvaluation customerEvaluation) {
		this.customerEvaluation = customerEvaluation;
	}

	protected void unsetCustomerEvaluation(ICustomerEvaluation customerEvaluation) {
		this.customerEvaluation = null;
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

}
