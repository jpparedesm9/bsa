/**
 * Archivo: OrchestrationClientValidationServiceRestImpl.java
 * Autor..: Team Evac
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

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.BiometricManager;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.CustomerEvaluationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.util.Constants;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.ProspectReportResponse;

//incluir en code order con la clave:cobiscloudorchestration.OrchestrationClientValidationServiceRestImpl.imports

@Path("/cobis/web/OrchestrationClientValidationServiceRest")
@Component
@org.apache.felix.scr.annotations.Service({ com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationClientValidationServiceRest.class })
public class OrchestrationClientValidationServiceRestImpl extends ServiceBase
		implements com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationClientValidationServiceRest {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisParameter", unbind = "unsetCobisParameter", cardinality = ReferenceCardinality.MANDATORY_UNARY, policy = ReferencePolicy.DYNAMIC)
	private ICobisParameter cobisParameter;

	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationClientValidationServiceRestImpl.class);
	private static final String BURO_DE_CREDITO_HISTORICO = "BuroCreditoHistorico";
	private static final String BURO_DE_CREDITO_INTERNO_EXTERNO = "BuroCreditoInternoExterno";
	private final static String RENAPO_VALIDATED = "S";

	private final static String RENAPO_PENDING = "N";
	private final static String RENAPO_ACTIVE = "S";
	private final static String RENAPO_INACTIVE = "N";

	public final static String CHANNEL = "channel";

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Path("/validate")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse validate(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validate");
		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validate", new Object[] { aValidationRequestServiceRequest });

	}

	@Path("/validateBuroClientGroupRule")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse validateBuroClientGroupRule(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aBuroClientRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule");
		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule", new Object[] { aBuroClientRequest });
	}

	@Path("/validateBuroClientGroup")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse validateBuroClientGroup(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup");
		// deprecated: incluir en code order con la
		// clave:OrchestrationClientValidationServiceRestImpl.validateBuroClientGroup

		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup",
				new Object[] { aValidationBuroClientGroupServiceRequest });
	}

	@Path("/validateBuroClientIndividualRule")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse validateBuroClientIndividualRule(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aValidationProspectServiceRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule");
		// deprecated: incluir en code order con la
		// clave:OrchestrationClientValidationServiceRestImpl.validateBuroClientIndividualRule

		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule",
				new Object[] { aValidationProspectServiceRequest });
	}

	@Path("/validateBuro")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse validateBuro(ValidationProspectServiceRequest aValidationRequestServiceRequest, @Context HttpServletRequest httpRequest) {
		ServiceResponse responseValidateBuro = new ServiceResponse();

		String wlog = ".......---------/cobis/web/OrchestrationClientValidationServiceRest/validateBuro/ ";

		try {
			LOGGER.logDebug("----Inicio try-catch");
			LOGGER.logDebug("----Obtener idCliente");
			Integer personCode = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
			LOGGER.logDebug(wlog + "----idCliente: " + personCode);
			LOGGER.logDebug("----Obtener parametro RENAPO");
			String renapo = cobisParameter.getParameter(null, "CLI", "RENAPO", String.class);
			renapo = renapo == null ? "N" : renapo;
			LOGGER.logDebug(wlog + "----parametro RENAPO: " + renapo);

			Integer channel = Integer.parseInt(httpRequest.getHeader(CHANNEL));
			aValidationRequestServiceRequest.getInValidationProspectRequest().setChannel(channel);

			LOGGER.logDebug(wlog + "aValidationRequestServiceRequest: " + aValidationRequestServiceRequest.toString());

			CustomerResponse customerResponse = searchCustomer(personCode);
			LOGGER.logDebug(wlog + "respuesta getCustomerName: " + customerResponse.getCustomerName());

			if (customerResponse != null && customerResponse.getCustomerName() != null) {
				LOGGER.logDebug("respuesta getCheckRenapo: " + customerResponse.getCheckRenapo());
				if (RENAPO_ACTIVE.equals(renapo) && !RENAPO_VALIDATED.equals(customerResponse.getCheckRenapo())) {

					LOGGER.logDebug(wlog + "customerResponse getCustomerName(): " + customerResponse.getCustomerName());
					LOGGER.logDebug(wlog + "customerResponse getGender(): " + customerResponse.getGender());
					LOGGER.logDebug(wlog + "customerResponse getCustomerBirthdate(): " + customerResponse.getCustomerBirthdate());
					BiometricManager biometricManager = new BiometricManager(this.serviceIntegration);
					StringBuilder name = new StringBuilder();
					name.append(customerResponse.getCustomerName());
					name.append(customerResponse.getCustomerSecondName() == null || customerResponse.getCustomerSecondName().trim().equals("") ? ""
							: " " + customerResponse.getCustomerSecondName());

					RenapoRequest renapoRequest = new RenapoRequest();
					renapoRequest.setName(name.toString());
					String convertDate = (null != customerResponse.getCustomerBirthdate() && "" != customerResponse.getCustomerBirthdate())
							? convertDate(customerResponse.getCustomerBirthdate())
							: null;
					renapoRequest.setBirthDate(convertDate);
					renapoRequest.setBirthPlace(String.valueOf(customerResponse.getCountyOfBirth()));
					renapoRequest.setLastName(customerResponse.getCustomerLastName());
					renapoRequest.setSecondLastName(customerResponse.getCustomerSecondLastName());
					renapoRequest.setGender(customerResponse.getGenderCode());

					RenapoResponse renapoResponse = biometricManager.queryCurpFromRenapo(renapoRequest);
					LOGGER.logDebug(wlog + "El CURP para el cliente " + personCode + " es " + renapo);
					if (renapoResponse != null) {

						String curp = renapoResponse.getCurp() == null ? customerResponse.getCustomerIdentificaction() : renapoResponse.getCurp();
						String status = renapoResponse.getStatus() == null ? RENAPO_PENDING : renapoResponse.getStatus();

						CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
						customerTotalRequest.setMode(1);
						customerTotalRequest.setCodePerson(personCode);
						customerTotalRequest.setIdentification(curp);
						customerTotalRequest.setCheckRenapo(status);
						updateCustomerRenapo(customerTotalRequest);
						if (RENAPO_VALIDATED.equals(status)) {
							LOGGER.logDebug(wlog + "----Valida RENAPO_VALIDATED");
							responseValidateBuro = callValidateBuro(aValidationRequestServiceRequest);
							OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) responseValidateBuro.getData();
							orchestrationClientValidationResponse.setCheckRenapo(status);
							orchestrationClientValidationResponse.setCurp(curp);
						} else {
							LOGGER.logDebug("----Valida RENAPO_ERROR_AT_GETTING_DATA");
							responseValidateBuro.setResult(false);
							LOGGER.logDebug(wlog + "renapoResponse.getMessages()>>" + renapoResponse.getMessages());
							for (RenapoMessage message : renapoResponse.getMessages()) {
								LOGGER.logDebug(wlog + "message>>>" + message);
								LOGGER.logDebug(wlog + "code:" + message.getCode());
								LOGGER.logDebug(wlog + "message:" + message.getMessage());
								responseValidateBuro.addMessage("500", message.getMessage());
							}
							responseValidateBuro.addMessage("500", "ERROR: No se pudo consultar el buro del cliente porque no ha sido validado en RENAPO.");

						}
					} else {
						LOGGER.logDebug(wlog + "renapoResponse--- null");
					}
				} else if (RENAPO_INACTIVE.equals(renapo) || (RENAPO_ACTIVE.equals(renapo) && RENAPO_VALIDATED.equals(customerResponse.getCheckRenapo()))) {
					LOGGER.logDebug(wlog + "----Ingresa ELSE RENAPO_INACTIVE");
					responseValidateBuro = callValidateBuro(aValidationRequestServiceRequest);
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) responseValidateBuro.getData();
					orchestrationClientValidationResponse.setCheckRenapo(customerResponse.getCheckRenapo() == null ? RENAPO_PENDING : customerResponse.getCheckRenapo());
					orchestrationClientValidationResponse.setCurp(customerResponse.getCustomerIdentificaction());
				}

			} else {
				LOGGER.logDebug(wlog + "----Error al consultar datos clientes");
				responseValidateBuro.setResult(false);
				responseValidateBuro.addMessage("500", "Error al consultar datos del cliente.");
			}

		} catch (IOException e) {
			LOGGER.logDebug(".......---------ERROR OrchestrationClientValidationServiceSERVImpl.validateBuro Finaliza llamado URL");
			LOGGER.logError("Mensaje 0", e);
			responseValidateBuro.addMessage("500", "Error de Conexión.");
		} catch (Exception e) {
			LOGGER.logDebug(".......ERROR Consulta Buró........");
			LOGGER.logError("Mensaje", e);
			responseValidateBuro.addMessage("500", "Error al Consultar Buró.");

		} finally {
			LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateBuro antes del Final");
		}
		return responseValidateBuro;/*
									 * execute(this.serviceIntegration, logger,
									 * "OrchestrationClientValidationServiceSERVImpl.validateBuro", new Object[]{
									 * aValidationRequestServiceRequest });
									 */
	}

	// caso #193221 B2B Grupal Digital
	@Path("/clientEvaluation")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Override
	public ServiceResponse clientEvaluation(ValidationProspectServiceRequest aValidationRequestServiceRequest, @Context HttpServletRequest httpRequest) {
		String wlog = ".......---------/cobis/web/OrchestrationClientValidationServiceRest/clientEvaluation/ ";
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceRestImpl.clientEvaluation");
		ServiceResponse responseValidateClient = new ServiceResponse();

		try {
			LOGGER.logDebug(wlog + "----Inicio try-catch");
			Integer channel = Integer.parseInt(httpRequest.getHeader(CHANNEL));
			aValidationRequestServiceRequest.getInValidationProspectRequest().setChannel(channel);
			LOGGER.logDebug(wlog + "aValidationRequestServiceRequest: " + aValidationRequestServiceRequest.toString());

			LOGGER.logDebug(wlog + "----Obtener idCliente");
			Integer personCode = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
			LOGGER.logDebug(wlog + "----idCliente: " + personCode);

			LOGGER.logDebug(wlog + "----Llamada validacion cliente");
			responseValidateClient = callClientEvaluation(aValidationRequestServiceRequest);

		} catch (Exception e) {
			LOGGER.logDebug(wlog + ".......ERROR Error al ejecutar la Evaluación del Cliente........");
			LOGGER.logError("Mensaje", e);
			responseValidateClient.addMessage("500", "Error al ejecutar la Evaluación del Cliente");
		} finally {
			LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.clientEvaluation antes del Final");
		}
		return responseValidateClient;
	}

	@Path("/validateSantander")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse validateSantander(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateSantander");

		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateSantander", new Object[] { aValidationRequestServiceRequest });
	}

	@Path("/validateSantanderWithoutValidation")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse validateSantanderWithoutValidation(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateSantanderWithoutValidation");

		return this.execute(serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateSantanderWithoutValidation",
				new Object[] { aValidationRequestServiceRequest });
	}
	// for the body include in code order with the key:
	// cobiscloudorchestration.OrchestrationClientValidationService.body

	private ProspectReportResponse executeReadCustomerService(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		ServiceRequestTO requestTo = new ServiceRequestTO();

		String wlog = "OrchestrationClientValidationServiceRestImpl - executeReadCustomerService - Inicia Reporte queryReportBureau";

		NaturalProspectRequest prospectRequest = new NaturalProspectRequest();
		prospectRequest.setProspectId(aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId());
		prospectRequest.setValidityDaysBureau(aValidationRequestServiceRequest.getInValidationProspectRequest().getDaysValidityBureau());

		requestTo.addValue("inNaturalProspectRequest", prospectRequest);
		ServiceResponse response = super.execute(serviceIntegration, LOGGER, "CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau", requestTo);

		LOGGER.logDebug(wlog + "Fin Reporte queryReportBureau");

		return extractValue(response, "returnProspectReportResponse", ProspectReportResponse.class);
	}

	public CustomerResponse searchCustomer(int customerId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerRequest request = new CustomerRequest();
		request.setCustomerId(customerId);
		request.setFormatDate(101);
		request.setModo(0);
		requestTo.addValue("inCustomerRequest", request);
		ServiceResponse response = super.execute(serviceIntegration, LOGGER, "CustomerDataManagementService.CustomerManagement.ReadDataCustomer", requestTo);
		return extractValue(response, "returnCustomerResponse", CustomerResponse.class);

	}

	public boolean updateCustomerRenapo(CustomerTotalRequest customerTotalRequest) {
		LOGGER.logDebug("----START updateCustomerRenapo");
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inCustomerTotalRequest", customerTotalRequest);
		ServiceResponse response = super.execute(serviceIntegration, LOGGER, "CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO", requestTo);
		if (response != null && response.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) response.getData();
			if (serviceResponseTo.isSuccess()) {

				LOGGER.logDebug("updateCustomerRenapo serviceResponseTo success");
				return true;
			} else {
				LOGGER.logDebug("updateCustomerRenapo serviceResponseTo doesn't success");
				return false;
			}
		} else {
			LOGGER.logDebug("response updateCustomerRenapo null");
		}
		LOGGER.logDebug("----FINISH updateCustomerRenapo");
		return false;

	}

	public ServiceResponse callValidateBuro(ValidationProspectServiceRequest aValidationRequestServiceRequest) throws Exception {
		String wlog = "....----OrchestrationClientValidationServiceRestImpl - callValidateBuro ";
		OrchestrationClientValidationResponse orchestrationClientValidationResponse = null;
		ServiceResponse response = new ServiceResponse();

		// Listas negras y negative file
		boolean next = true;
		ServiceResponse responseValidateBuro = execute(this.serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.blackListValidation",
				new Object[] { aValidationRequestServiceRequest });

		LOGGER.logDebug(wlog + "aValidationRequestServiceRequest:" + aValidationRequestServiceRequest.toString());

		if (responseValidateBuro.isResult()) {
			orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) responseValidateBuro.getData();
			BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();

			LOGGER.logDebug(wlog + "serviceResponseBlackList.isResult():" + responseValidateBuro.isResult());
			LOGGER.logDebug(wlog + "serviceResponseBlackList.getData():" + responseValidateBuro.getData());

			if (buroExecutionResponse == null) {
				LOGGER.logDebug(wlog + "Error al Consultar Listas Negras o Negative File");
				next = false;
			}

			if (buroExecutionResponse != null && buroExecutionResponse.getListBlackCustomer() != null && buroExecutionResponse.getListBlackCustomer() == 3) {
				next = false;

				LOGGER.logDebug(wlog + " El cliente " + aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId()
						+ " se encuentra en listas Negras o negative File, no continua");
			}
		} else {
			next = false;
		}

		LOGGER.logDebug(wlog + "next:" + next);

		if (next) {
			responseValidateBuro = execute(this.serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuro",
					new Object[] { aValidationRequestServiceRequest });
			if (responseValidateBuro.isResult()) {
				orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) responseValidateBuro.getData();
				BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();

				LOGGER.logDebug(wlog + "responseValidateBuro.isResult():" + responseValidateBuro.isResult());
				LOGGER.logDebug(wlog + "responseValidateBuro.getData():" + responseValidateBuro.getData());

				if (buroExecutionResponse != null) {
					if (buroExecutionResponse.getProblemConsultingBuro() != null) {
						LOGGER.logDebug(wlog + "Movil-buroExecutionResponse.getProblemConsultingBuro():" + buroExecutionResponse.getProblemConsultingBuro());
						if (buroExecutionResponse.getProblemConsultingBuro()) {

							response.setResult(false);
							return response;
						}
					}
				}
			}

			String paramUrl = cobisParameter.getParameter(null, "CRE", "URLREP", String.class).trim();

			if ("".contentEquals(paramUrl)) {
				if (LOGGER.isErrorEnabled()) {
					LOGGER.logError(wlog + "No se puede recuperar la URL");
				}
				response.setResult(false);
				return response;
			}

			String paramUrl2 = cobisParameter.getParameter(null, "CRE", "DIRREP", String.class);

			if ("".contentEquals(paramUrl2)) {
				if (LOGGER.isErrorEnabled()) {
					LOGGER.logError(wlog + "No se puede recuperar el path");
				}
				response.setResult(false);
				return response;
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wlog + "URL: " + paramUrl + paramUrl2);
			}

			int customerCode = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
			LOGGER.logDebug(wlog + "BuroCreditoHistorico Inicia llamado URL " + customerCode);

			String url = paramUrl + paramUrl2 + "reports/" + BURO_DE_CREDITO_HISTORICO + "?report.module=customer&report.name=" + BURO_DE_CREDITO_HISTORICO + "&idCustomer="
					+ customerCode;
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			con.setRequestMethod("POST");
			int responseCode = con.getResponseCode();
			executeReadCustomerService(aValidationRequestServiceRequest);

			LOGGER.logDebug(wlog + "Finaliza llamado URL " + responseCode);
			responseValidateBuro.setData(orchestrationClientValidationResponse);
		}

		return responseValidateBuro;
	}

	public ServiceResponse callClientEvaluation(ValidationProspectServiceRequest aValidationRequestServiceRequest) throws Exception {

		CustomerEvaluationResponse customerEvaluationResponse = new CustomerEvaluationResponse();
		boolean evaluationOKB = false;
		ServiceResponse serviceResponse = null;

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][callClientEvaluation] ";
		try {

			LOGGER.logDebug(wInfo + "Datos customerRequest: " + aValidationRequestServiceRequest);

			serviceResponse = execute(this.serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.clientEvaluation",
					new Object[] { aValidationRequestServiceRequest });

			LOGGER.logDebug(wInfo + "Datos serviceResponse: " + serviceResponse.getData());

			if (serviceResponse.isResult()) {

				OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();

				LOGGER.logDebug(wInfo + "Datos orchestrationClientValidationResponse: " + orchestrationClientValidationResponse);
				if (orchestrationClientValidationResponse.getEvaluation() == null) {
					LOGGER.logDebug(wInfo + "Error al ejecutar la Evaluación del Cliente");
				}

				String evaluationOK = orchestrationClientValidationResponse.getEvaluation();

				if (evaluationOK.equals("SI")) {
					evaluationOKB = true;
				}

				customerEvaluationResponse.setCustomerId(aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId());
				customerEvaluationResponse.setProblemBuro(orchestrationClientValidationResponse.getProblemBuro());
				customerEvaluationResponse.setQualification(orchestrationClientValidationResponse.getQualification());
				customerEvaluationResponse.setBlackList(orchestrationClientValidationResponse.getBlackList());
				customerEvaluationResponse.setRiskLevel(orchestrationClientValidationResponse.getRiskLevel());
				customerEvaluationResponse.setAmountApproved(orchestrationClientValidationResponse.getAmountApproved());
				customerEvaluationResponse.setEvaluation(evaluationOKB);

				// Mensaje para el color de la evaluacion del cliente
				if (Constants.Value.ROJO.equals(orchestrationClientValidationResponse.getRiskLevel())) {
					customerEvaluationResponse.setColorMessage(Constants.Message.RED_MESSAGE);
				} else if (Constants.Value.AMARILLO.equals(orchestrationClientValidationResponse.getRiskLevel())) {
					customerEvaluationResponse.setColorMessage(Constants.Message.YELLOW_MESSAGE);
				} else if (Constants.Value.VERDE.equals(orchestrationClientValidationResponse.getRiskLevel())) {
					customerEvaluationResponse.setColorMessage(Constants.Message.GREEN_MESSAGE);
				}

				if (!orchestrationClientValidationResponse.getProblemBuro()) {
					aValidationRequestServiceRequest.getInValidationProspectRequest().setDaysValidityBureau(orchestrationClientValidationResponse.getValidDays());
					ServiceResponse serviceResponseReport = new ServiceResponse();
					serviceResponseReport = callExternalCreditReport(aValidationRequestServiceRequest);
					LOGGER.logDebug(wInfo + "Problema en generacion reporte credito externo: " + serviceResponseReport.getData());
				}

				LOGGER.logDebug(wInfo + "Datos Salida customerEvaluationResponse: " + customerEvaluationResponse);
				serviceResponse.setData(customerEvaluationResponse);
			}

		} catch (Exception e) {
			LOGGER.logError(wInfo + "Error al ejecutar el metodo callClientEvaluation: " + customerEvaluationResponse);
		}

		return serviceResponse;
	}

	public ServiceResponse callExternalCreditReport(ValidationProspectServiceRequest aValidationRequestServiceRequest) throws Exception {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][callExternalCreditReport] ";

		ServiceResponse response = new ServiceResponse();

		try {
			LOGGER.logDebug(wInfo + "Datos customerRequest: " + aValidationRequestServiceRequest);

			String paramUrl = cobisParameter.getParameter(null, "CRE", "URLREP", String.class).trim();

			if ("".contentEquals(paramUrl)) {
				if (LOGGER.isErrorEnabled()) {
					LOGGER.logError("No se puede recuperar la URL");
				}
				response.setResult(false);
				return response;
			}

			String paramUrl2 = cobisParameter.getParameter(null, "CRE", "DIRREP", String.class);

			if ("".contentEquals(paramUrl2)) {
				if (LOGGER.isErrorEnabled()) {
					LOGGER.logError("No se puede recuperar el path");
				}
				response.setResult(false);
				return response;
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("URL: " + paramUrl + paramUrl2);
			}

			int customerCode = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
			LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.BuroCreditoHistorico Inicia llamado URL " + customerCode);
			LOGGER.logDebug("aValidationRequestServiceRequest" + aValidationRequestServiceRequest.toString());

			String url = paramUrl + paramUrl2 + "reports/" + BURO_DE_CREDITO_HISTORICO + "?report.module=customer&report.name=" + BURO_DE_CREDITO_HISTORICO + "&idCustomer="
					+ customerCode;
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			con.setRequestMethod("POST");
			int responseCode = con.getResponseCode();
			executeReadCustomerService(aValidationRequestServiceRequest);

			LOGGER.logDebug(".......---------OrchestrationClientValidationServiceSERVImpl.validateBuro Finaliza llamado URL " + url + " responseCode: " + responseCode);

		} catch (Exception e) {
			LOGGER.logError(wInfo + "Error al ejecutar el metodo callExternalCreditReport: " + response);
		}

		return response;
	}

	private static <T> T extractValue(ServiceResponse response, String value, Class<T> clazz) {
		if (response.isResult() && response.getData() != null) {
			ServiceResponseTO dataResponse = (ServiceResponseTO) response.getData();
			return clazz.cast(dataResponse.getData().get(value));
		}
		return null;
	}

	public String convertDate(String date) {
		String resultDate = null;
		SimpleDateFormat oldDateFormat = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat newDateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date fechaDate = null;
		if (null != date && "" != date) {
			try {
				fechaDate = oldDateFormat.parse(date);
				LOGGER.logDebug("fechaDate: " + fechaDate);
				LOGGER.logDebug("resultDate: " + newDateFormat.format(fechaDate));
				resultDate = newDateFormat.format(fechaDate);
			} catch (ParseException e) {
				LOGGER.logError("Error al realizar conversion de fecha: " + date);
			}
		}
		return resultDate;

	}

	public void setCobisParameter(ICobisParameter cobisParameter) {
		this.cobisParameter = cobisParameter;
	}

	public void unsetCobisParameter(ICobisParameter cobisParameter) {
		this.cobisParameter = null;
	}
}
