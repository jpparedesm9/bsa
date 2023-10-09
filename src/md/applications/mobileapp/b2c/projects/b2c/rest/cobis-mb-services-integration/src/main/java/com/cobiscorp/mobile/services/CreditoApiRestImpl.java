package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

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
import com.cobiscorp.mobile.model.ClientInformation;
import com.cobiscorp.mobile.model.ConfirmDisbursementRequest;
import com.cobiscorp.mobile.model.DisbursementRequest;
import com.cobiscorp.mobile.model.ElavonRequest;
import com.cobiscorp.mobile.model.ElavonResponse;
import com.cobiscorp.mobile.model.KYCFormRequestLocal;
import com.cobiscorp.mobile.model.LoanInfoRequest;
import com.cobiscorp.mobile.model.LoanRequest;
import com.cobiscorp.mobile.model.OperationCreateRequest;
import com.cobiscorp.mobile.model.ShapeOfPayment;
import com.cobiscorp.mobile.model.SimulationRequest;
import com.cobiscorp.mobile.model.TransactionInfo;
import com.cobiscorp.mobile.rest.interfaces.IRestCreditService;
import com.cobiscorp.mobile.service.interfaces.ILoanService;

/**
 * Credito en Línea
 *
 * <p>
 * Servicios para aplicación de crédito en
 *
 */
@Path("/channels/mobilebanking")
@Component
@Service({ IRestCreditService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class CreditoApiRestImpl extends RestServiceBase implements IRestCreditService {

	@Reference(bind = "setLoanService", unbind = "unsetLoanService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ILoanService loanService;
	private final ILogger logger = LogFactory.getLogger(CreditoApiRestImpl.class);
	private static String MESSAGGEERROR = "El monto a pagar debe ser un valor entre los límites máximo y mínimo de pago";

	@POST
	@Path("/loan/info")
	public Response channelsMobilebankingLoanInfoPost(@Valid LoanInfoRequest loanInfoRequest,
			@Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/loan/info >> " + loanInfoRequest);

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/info >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			// CreditlineInfo info = loanService.getCreditInfo(loanInfoRequest.getLoanId(),
			// cobisSessionId); antes
			logger.logDebug("/channels/mobilebanking/loan/info >> cobisSessionId " + cobisSessionId);
			ClientInformation info = loanService.getLoansInfo(loanInfoRequest, cobisSessionId); // nuevo

			cobisJwt.addAttribute(JWT_TOKEN_CUSTOMER_ID_KEY, loanInfoRequest.getCustomerId().toString());
			logger.logDebug("/channels/mobilebanking/loan/info >> Response :" + info);
			return successResponse(info, cobisJwt);
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
	@Path("/loan")
	public Response channelsMobilebankingLoanPost(@Valid LoanRequest loanRequest,
			@Context HttpServletRequest httpRequest) {
		logger.logDebug("POST /channels/mobilebanking/loan>> " + loanRequest);
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String customerId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			String phone = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			this.loanService.storeDisburse(loanRequest.getLoanId(), loanRequest.getAmount(),
					loanRequest.getVatPercentage(), loanRequest.getCommision(), loanRequest.getAmountCapital(),
					customerId, phone);
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
			return errorResponse("Error al aplicar desembolso");
		}
	}

	@PUT
	@Path("/loan")
	public Response channelsMobilebankingLoanPut(ConfirmDisbursementRequest confirmation,
			@Context HttpServletRequest httpRequest) {
		logger.logDebug("PUT /channels/mobilebanking/loan>> " + confirmation);
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CLIENT_ID_KEY);
			String login = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
			TransactionInfo transactionInfo;

			if (confirmation.getIsBusinessPartner() == null) {
				logger.logDebug("Valor nulo para identificar si es socio comercial");
				logger.logDebug("Ingreso a seteo por defecto no es Socio Comercial variable en N");
				confirmation.setIsBusinessPartner("N");
			}

			if ("N".equals(confirmation.getIsBusinessPartner())) {
				logger.logDebug("El cliente ingreso a solicitar una dispersión");
				transactionInfo = this.loanService.applyDisburse(confirmation.getLoanId(), clientId, login,
						confirmation.getOtp(), cobisSessionId);
			} else {
				logger.logDebug("El cliente ingreso a solicitar una referencia socio comercial");
				transactionInfo = this.loanService.applyGenerateReference(confirmation.getLoanId(), clientId, login,
						confirmation.getOtp(), cobisSessionId);
			}

			logger.logDebug("Respuesta applyDisburse " + transactionInfo);
			// return Response.ok().header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
			logger.logDebug("PUT /channels/mobilebanking/loan>> finish method");
			return successResponse(transactionInfo, cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError("Error al registrar desembolso", e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error al registrar desembolso", e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error al registrar desembolso", e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al registrar desembolso");
		}
	}

	@POST
	@Path("/loan/payments")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response channelsMobilebakingPayment(@Valid ShapeOfPayment shapeOfPayment,
			@Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/loan/payments >> " + shapeOfPayment);
		CobisJwt cobisJwt;
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/payments >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			if (logger.isDebugEnabled()) {
				logger.logDebug("token no es null");
				logger.logDebug("AUTHORIZATION......" + httpRequest.getHeader(AUTHORIZATION));
				logger.logDebug("cobisJwt......" + cobisJwt);
				logger.logDebug("cobisJwt......" + cobisSessionId);
			}

			if (shapeOfPayment.getValuePayment() >= shapeOfPayment.getMinimumPayment()
					&& shapeOfPayment.getValuePayment() <= shapeOfPayment.getMaximumPayment()) {
				logger.logDebug("Pago existoso......");
				logger.logDebug("shapeOfPayment" + shapeOfPayment.toString());
				logger.logDebug("shapeOfPayment getDeadlinePayment" + shapeOfPayment.getDeadlinePayment());
				logger.logDebug("shapeOfPayment getEmailClient    " + shapeOfPayment.getEmailClient());
				logger.logDebug("shapeOfPayment getReferencePayment" + shapeOfPayment.getReferencePayment());
				logger.logDebug("shapeOfPayment getMaximumPayment " + shapeOfPayment.getMaximumPayment());
				logger.logDebug("shapeOfPayment getMinimumPayment" + shapeOfPayment.getMinimumPayment());
				logger.logDebug("shapeOfPayment getValuePayment" + shapeOfPayment.getValuePayment());
				// successResponse(info, cobisJwt);
				if (cobisJwt.generateJws() != null) {
					logger.logDebug("Generando token");
				}
				return Response.status(Response.Status.OK).header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();
			} else {
				logger.logDebug("Pago  supera monto existoso......");
				// errorResponse(MESSAGGEERROR)
				return Response.status(Response.Status.OK).header(JWT_TOKEN_ID, cobisJwt.generateJws())
						.entity("{\"ERROR\":\"" + MESSAGGEERROR + "\"}").build();
			}
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logDebug("error de InvalidTokenException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		}
	}

	@POST
	@Path("/loan/elavonPayments")
	public Response elavonPayment(@Valid ElavonRequest elavonRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/loan/elavonPayments >> " + elavonRequest);
		CobisJwt cobisJwt;
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/payments >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			if (logger.isDebugEnabled()) {
				logger.logDebug("token no es null");
				logger.logDebug("AUTHORIZATION......" + httpRequest.getHeader(AUTHORIZATION));
				logger.logDebug("cobisJwt......" + cobisJwt);
				logger.logDebug("cobisJwt......" + cobisSessionId);
			}

			ElavonResponse payLeague = this.loanService.getPayLeague(elavonRequest, cobisSessionId);
			logger.logDebug("Informacion Obtenida: " + payLeague);

			return successResponse(payLeague, cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError("Error al registrar pago: ", e);
			if (e.getMessage() == null) {
				return errorResponse("Error al registrar pago.");
			}
			return errorResponse("Error al registrar pago: " + e.getMessage());
		} catch (InvalidTokenException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logDebug("error de InvalidTokenException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al realizar el pago");
		}
		
	}

	@POST
	@Path("/loan/endPointElavon")
	public Status endPointElavon(@FormParam("strResponse") String endPointRequest) {
		logger.logDebug("/channels/mobilebanking/loan/endPointElavon >> " + endPointRequest);

		try {
			if (endPointRequest != null && !"".equals(endPointRequest)) {
				String info = loanService.getEndPointElavon(endPointRequest);
				if (logger.isDebugEnabled()) {
					logger.logDebug("Lo que devuelve es: " + info);
				}
			} else {
				logger.logDebug("La Cadena llega vacia o nula al servicio endPointElavon.");
				return Response.Status.INTERNAL_SERVER_ERROR;
			}
		} catch (MobileServiceException e) {
			logger.logError("Error al consultar Endpoint Elavon: ", e);
			return Response.Status.INTERNAL_SERVER_ERROR;
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return Response.Status.INTERNAL_SERVER_ERROR;
		}
		return Response.Status.OK;
	}

	@POST
	@Path("/loan/simulation")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response channelsMobilebankingSimulation(@Valid SimulationRequest simulationRequest,
			@Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/loan/simulation >> " + simulationRequest.toString());

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/simulation >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/loan/simulation >> cobisSessionId " + cobisSessionId);

			return successResponse(loanService.simulate(simulationRequest, cobisSessionId), cobisJwt);

		} catch (TokenExpiredException e) {
			logger.logError("--->>>Error TokenExpiredException channelsMobilebankingSimulation: ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("--->>>Error InvalidTokenException channelsMobilebankingSimulation: ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("--->>>Error MobileServiceException channelsMobilebankingSimulation: ", e);
			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("--->>>Error Throwable channelsMobilebankingSimulation: ", e);
			return errorResponse("Error en ejecutar la Simulación");
		}
	}

	@POST
	@Path("/loan/createOperation")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response channelsMobilebankingCreateOperation(@Valid OperationCreateRequest operationCreateRequest,
			@Context HttpServletRequest httpRequest) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("/channels/mobilebanking/loan/createOperation >> " + operationCreateRequest.toString());
		}
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/createOperation >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/loan/createOperation >> cobisSessionId " + cobisSessionId);

			return successResponse(loanService.createOperation(operationCreateRequest, cobisSessionId), cobisJwt);

		} catch (TokenExpiredException e) {
			logger.logError("--->>>Error TokenExpiredException channelsMobilebankingCreateOperation: ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("--->>>Error InvalidTokenException channelsMobilebankingCreateOperation: ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("--->>>Error MobileServiceException channelsMobilebankingCreateOperation: ", e);
			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("--->>>Error Throwable channelsMobilebankingCreateOperation: ", e);
			return errorResponse("Error al Crear la Operación");
		}
	}

	@POST
	@Path("/loan/disbursement")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response channelsMobilebankingDisbursement(@Valid DisbursementRequest disbursementRequest,
			@Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/loan/disbursement >> " + disbursementRequest.toString());

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/loan/disbursement >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/loan/disbursement >> cobisSessionId " + cobisSessionId);
			return Response.ok(loanService.generateDisbursement(disbursementRequest, cobisSessionId))
					.header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();

		} catch (TokenExpiredException e) {
			logger.logError("Errror TokenExpiredException en channelsMobilebankingDisbursement : ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Errror InvalidTokenException en channelsMobilebankingDisbursement : ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("Errror MobileServiceException en channelsMobilebankingDisbursement : ", e);
			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable en channelsMobilebankingDisbursement: ", e);
			return errorResponse("Error al Desembolsar la Operación");
		}

	}

	@POST
	@Path("/customer/kycForm")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response channelsMobilebankingKYCForm(@Valid KYCFormRequestLocal kycFormRequestLocal,
			@Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/customer/kycForm >> " + kycFormRequestLocal.toString());

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/customer/kycForm >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/customer/kycForm >> cobisSessionId " + cobisSessionId);
			return Response.ok(loanService.saveKYCForm(kycFormRequestLocal, cobisSessionId))
					.header(JWT_TOKEN_ID, cobisJwt.generateJws()).build();

		} catch (TokenExpiredException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(e.getMessage());
			}
			logger.logError("error de TokenExpiredException channelsMobilebankingKYCForm", e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error de InvalidTokenException channelsMobilebankingKYCForm: ", e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("Error Throwable channelsMobilebankingKYCForm: ", e);
			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable channelsMobilebankingKYCForm: ", e);
			return errorResponse("Error en guardado de información Formulario KyC");
		}
	}

	public void setLoanService(ILoanService loanService) {
		this.loanService = loanService;
	}

	public void unsetLoanService(ILoanService loanService) {
		this.loanService = null;
	}

}
