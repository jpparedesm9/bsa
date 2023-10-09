package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.util.HashMap;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationNewRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.CreditApplicationIndService;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.ApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIndRequest;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.InstanceProcessData;
import com.cobiscorp.ecobis.cloud.service.integration.ApplicationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.RuleExecutionService;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

@Path("/cobis-cloud/mobile/creditapplication/individual")
@Component
@Service({ CreditApplicationIndRest.class })
public class CreditApplicationIndRest implements CreditApplicationIndService {

	private final ILogger logger = LogFactory.getLogger(CreditApplicationIndRest.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
	private ICobisParameter parameterService;

	private WorkflowService workflowService;
	private ApplicationService applicationService;
	private OfficerIntegrationService officerIntegrationService;
	private RuleExecutionService ruleExeptionService;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		this.workflowService = new WorkflowService(serviceIntegration);
		this.applicationService = new ApplicationService(serviceIntegration);
		this.officerIntegrationService = new OfficerIntegrationService(serviceIntegration);
		this.ruleExeptionService = new RuleExecutionService(serviceIntegration);
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createApplication(CreditApplicationIndRequest request) {
		logger.logDebug("execute createCreditApplication");
		logger.logInfo("/mobile/creditapplication/individual/createApplication Request>> " + objectToJson(request));

		try {

			int officerId = 0;
			if (officerIntegrationService != null) {
				OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
				logger.logDebug("officer >>" + officerResponse);
				logger.logDebug("officer id >>" + officerResponse.getOfficerId());
				officerId = officerResponse.getOfficerId();
			}
			logger.logDebug("officeId >>" + SessionUtil.getOffice());
			if (SessionUtil.getOffice() == 0) {
				request.getCustomerData().setOffice(1101);
			} else {
				request.getCustomerData().setOffice(SessionUtil.getOffice());
			}

			request.getCustomerData().setOfficer(officerId);
			request.getCustomerData().setOffice(applicationService.getOfficeOfficer(SessionUtil.getUser()));

			CreditApplicationResponse creditApplicationResponse = new CreditApplicationResponse();
			InstanceProcessData instanceProcessData;
			ServiceResponse instanceProcessResponse;
			TaskDTO taskDTO;
			int processInstance = 0;
			String processNamePart1 = "";

			processNamePart1 = parameterService.getParameter(null, "CRE", "WSCIN1", String.class);
			logger.logDebug("parameterService1" + processNamePart1);

			String processNamePart2 = parameterService.getParameter(null, "CRE", "WSCIN2", String.class);
			logger.logDebug("parameterService2" + processNamePart2);
			String procesName = processNamePart1.concat(processNamePart2);

			logger.logDebug("process Name" + procesName);
			logger.logDebug("1 - Create process Instance");
			instanceProcessResponse = workflowService.createProcessIntance(procesName, request.getCustomerData().getCode(), 0, null, "INDIVIDUAL", "P",
					request.getCustomerData().getOffice(), 12);
			if (!instanceProcessResponse.isResult()) {
				creditApplicationResponse.setProcessInstance(instanceProcessResponse);
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			} else {
				instanceProcessData = (InstanceProcessData) instanceProcessResponse.getData();
				processInstance = instanceProcessData.getProcessInstance();
			}

			logger.logDebug("Retrieving current task por instance --> " + processInstance);
			ServiceResponse currentTaskResponse = workflowService.getCurrentTask(processInstance);
			if (!currentTaskResponse.isResult()) {
				creditApplicationResponse.setProcessInstance(currentTaskResponse);
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}
			taskDTO = (TaskDTO) currentTaskResponse.getData();
			ServiceResponse instanceProcessInstance = new ServiceResponse();
			InstanceProcessData data = new InstanceProcessData();
			data.setProcessInstance(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
			data.setAlternateCode(taskDTO.getAlternateCode());
			instanceProcessInstance.setResult(true);
			instanceProcessInstance.setData(data);
			creditApplicationResponse.setProcessInstance(instanceProcessInstance);

			logger.logDebug(" 2 - Save Application");
			ServiceResponse applicationResponse;
			if (taskDTO.getOwnerIdentifier() == 0) {
				applicationResponse = createApplication(request, Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
				logger.logDebug("----->>instancia de proceso.." + Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
			} else {
				applicationResponse = updateApplication(request, taskDTO.getOwnerIdentifier());
				logger.logDebug("----->>instancia de proceso1.." + taskDTO.getOwnerIdentifier());
			}
			creditApplicationResponse.setCreditApplication(applicationResponse);
			if (!applicationResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}
			logger.logDebug(" 2.0 - reglas Individuales");
			CreditApplicationData creditApplicationData;
			creditApplicationData = (CreditApplicationData) applicationResponse.getData();

			int tramite = 0;
			tramite = creditApplicationData.getApplicationCode();

			logger.logDebug("----->>tramite" + tramite);

			if (tramite > 0) {
				ServiceResponse evalueruleMonto = ruleExeptionService.readRuleAmountMax(tramite, "MONTO_IND");
				creditApplicationResponse.setUpdateAmounts(evalueruleMonto);
				if (!evalueruleMonto.isResult()) {

					return successResponse(creditApplicationResponse, false, "creditoIndividual");
				}
				ServiceResponse evaluerule = ruleExeptionService.readRuleAmountMax(tramite, "VAL_TRAMITE");
				creditApplicationResponse.setUpdateAmounts(evaluerule);
				if (!evaluerule.isResult()) {

					return successResponse(creditApplicationResponse, false, "creditoIndividual");
				} else {

					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) evaluerule.getData();
					HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
					if (outputs != null) {
						String mensaje = outputs.get("@o_msg1").trim();
						logger.logDebug("----->>mensaje.." + mensaje + "---");

						if (mensaje.equals("")) {
							logger.logDebug("----->>mensaje..vacio ");
							evaluerule.setData(null);
							creditApplicationResponse.setUpdateAmounts(evaluerule);
						} else {
							if (request.isConfirmation() == true) {
								evaluerule.setData(null);
								creditApplicationResponse.setUpdateAmounts(evaluerule);
							}
							if (!request.isConfirmation()) {
								evaluerule.setData(mensaje);
								creditApplicationResponse.setUpdateAmounts(evaluerule);
								return successResponse(creditApplicationResponse, true, "creditoIndividual");

							}
						}
					}

				}
			}

			logger.logDebug(" 3 - Evaluate Politics");
			ServiceResponse evaluatePoliticsResponse = workflowService.evaluatePolicies(taskDTO);
			creditApplicationResponse.setEvaluatePolitics(evaluatePoliticsResponse);
			if (!evaluatePoliticsResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}

			logger.logDebug(" 4 - Complete Task");
			ServiceResponse completeTaskResponse = workflowService.completeWorkflowTask(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()),
					Integer.valueOf(taskDTO.getTaskInstanceIdentifier()), taskDTO.getCobisAssignAct(), taskDTO.getCobisStepId());
			creditApplicationResponse.setCompleteTask(completeTaskResponse);
			if (!completeTaskResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}

			logger.logInfo("/mobile/creditapplication/individual/createApplication Response>> " + objectToJson(creditApplicationResponse));
			return successResponse(creditApplicationResponse, true, "creditoIndividual");
		} catch (IntegrationException e) {
			logger.logError("IntegrationException ", e);
			return errorResponse(e);
		}
	}

	@Path("/{id}")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateCreditApplication(@PathParam("id") int processInstance, CreditApplicationIndRequest request) {
		logger.logDebug("execute updateCreditApplication processInstance:" + processInstance);
		logger.logInfo("/mobile/creditapplication/individual/updateCreditApplication Request>> " + objectToJson(request));

		try {

			int officerId = 0;
			if (officerIntegrationService != null) {
				OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
				logger.logDebug("officer >>" + officerResponse);
				logger.logDebug("officer id >>" + officerResponse.getOfficerId());
				officerId = officerResponse.getOfficerId();
			}
			logger.logDebug("officeId >>" + SessionUtil.getOffice());
			if (SessionUtil.getOffice() == 0) {
				request.getCustomerData().setOffice(1101);
			} else {
				request.getCustomerData().setOffice(SessionUtil.getOffice());
			}

			request.getCustomerData().setOfficer(officerId);

			CreditApplicationResponse creditApplicationResponse = new CreditApplicationResponse();
			InstanceProcessData instanceProcessData;
			ServiceResponse instanceProcessResponse = new ServiceResponse();
			ServiceResponse currentTaskResponse = workflowService.getCurrentTask(processInstance);

			TaskDTO taskDTO;
			if (currentTaskResponse.isResult()) {
				taskDTO = (TaskDTO) currentTaskResponse.getData();
				instanceProcessData = new InstanceProcessData();
				instanceProcessData.setProcessInstance(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
				instanceProcessData.setAlternateCode(taskDTO.getAlternateCode());
				instanceProcessResponse.setResult(true);
				instanceProcessResponse.setData(instanceProcessData);
			} else {
				return successResponse(currentTaskResponse, false, "creditoIndividual");
			}

			creditApplicationResponse.setProcessInstance(instanceProcessResponse);

			ServiceResponse applicationResponse;

			if (taskDTO.getOwnerIdentifier() == 0) {
				applicationResponse = createApplication(request, Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
				logger.logDebug("----->>instancia de proceso.." + Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
			} else {
				applicationResponse = updateApplication(request, taskDTO.getOwnerIdentifier());
				logger.logDebug("----->>instancia de proceso1.." + taskDTO.getOwnerIdentifier());
			}

			creditApplicationResponse.setCreditApplication(applicationResponse);
			if (!applicationResponse.isResult()) {
				logger.logDebug("----->>Falla applicationResponse ..");
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}

			logger.logDebug(" 2.0 - reglas Individuales");
			//
			CreditApplicationData creditApplicationData;
			creditApplicationData = (CreditApplicationData) applicationResponse.getData();
			int tramite = 0;
			tramite = creditApplicationData.getApplicationCode();

			logger.logDebug("----->>tramite" + tramite);

			if (tramite > 0) {

				ServiceResponse evalueruleMonto = ruleExeptionService.readRuleAmountMax(tramite, "MONTO_IND");
				creditApplicationResponse.setUpdateAmounts(evalueruleMonto);
				if (!evalueruleMonto.isResult()) {
					return successResponse(creditApplicationResponse, false, "creditoIndividual");
				}
				ServiceResponse evaluerule = ruleExeptionService.readRuleAmountMax(tramite, "VAL_TRAMITE");
				creditApplicationResponse.setUpdateAmounts(evaluerule);
				if (!evaluerule.isResult()) {
					return successResponse(creditApplicationResponse, false, "creditoIndividual");
				} else {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) evaluerule.getData();
					HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
					if (outputs != null) {
						String mensaje = outputs.get("@o_msg1").trim();
						logger.logDebug("----->>mensaje.." + mensaje + "----");

						if (mensaje.equals("")) {
							logger.logDebug("----->>mensaje..vacio ");
							evaluerule.setData(null);
							creditApplicationResponse.setUpdateAmounts(evaluerule);
						} else {
							if (request.isConfirmation() == true) {
								evaluerule.setData(null);
								creditApplicationResponse.setUpdateAmounts(evaluerule);
							}
							if (!request.isConfirmation()) {
								evaluerule.setData(mensaje);
								creditApplicationResponse.setUpdateAmounts(evaluerule);
								return successResponse(creditApplicationResponse, true, "creditoIndividual");

							}
						}
					}

				}
			}

			logger.logDebug(" 2 - Evaluate Politics");
			ServiceResponse evaluatePoliticsResponse = workflowService.evaluatePolicies(taskDTO);
			creditApplicationResponse.setEvaluatePolitics(evaluatePoliticsResponse);
			if (!evaluatePoliticsResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}

			logger.logDebug(" 3 - Complete Task");
			ServiceResponse completeTaskResponse = workflowService.completeWorkflowTask(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()),
					Integer.valueOf(taskDTO.getTaskInstanceIdentifier()), taskDTO.getCobisAssignAct(), taskDTO.getCobisStepId());
			creditApplicationResponse.setCompleteTask(completeTaskResponse);
			if (!completeTaskResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "creditoIndividual");
			}

			logger.logInfo("/mobile/creditapplication/individual/updateCreditApplication Response>> " + objectToJson(creditApplicationResponse));
			return successResponse(creditApplicationResponse, true, "creditoIndividual");

		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

	private ServiceResponse createApplication(CreditApplicationIndRequest request, int procesInstance) {
		logger.logDebug("Creating Credit Application");
		ServiceResponse serviceResponse;
		ServiceResponse response;
		CreditApplicationData creditApplicationData;
		response = new ServiceResponse();

		try {

			serviceResponse = applicationService.createIndApplication(request);

			creditApplicationData = (CreditApplicationData) serviceResponse.getData();
			workflowService.updateInstanceProcess(procesInstance, creditApplicationData.getApplicationCode());
			response.setResult(true);
			response.setData(creditApplicationData);

		} catch (IntegrationException e) {
			response = e.getResponse();
			response.setData(null);
		}

		return response;
	}

	private ServiceResponse updateApplication(CreditApplicationIndRequest request, int applicationNumber) {
		// /
		logger.logDebug("Updating Credit Application");
		ServiceResponse serviceResponse;
		ServiceResponse response = new ServiceResponse();
		ApplicationResponse applicationResponse = applicationService.getApplication(applicationNumber);
		ApplicationNewRequest applicationNewRequest = new ApplicationNewRequest();
		// //////////

		CreditApplicationData creditApplicationData = new CreditApplicationData();
		ApplicationData applicationData = request.getApplicationData();
		CustomerData customerData = request.getCustomerData();
		applicationNewRequest.setOffice(request.getCustomerData().getOffice());
		applicationNewRequest.setOfficer(request.getCustomerData().getOfficer());
		applicationNewRequest.setMoney(0);// review no esta
		applicationNewRequest.setDestination(request.getApplicationData().getCreditDestination());// review
																									// no
																									// esta
		applicationNewRequest.setName(customerData.getName());
		// applicationNewRequest.setStartDate(CalendarUtil.from(getProcessDate(101)));
		applicationNewRequest.setOpertationType(applicationData.getApplicationType());
		applicationNewRequest.setBanking("1");// review no esta
		applicationNewRequest.setClient(customerData.getCode());
		// Campos Nuevos **
		applicationNewRequest.setPromotion(applicationData.isPromotion() ? 'S' : 'N');
		applicationNewRequest.setGroupAgreesToRenew(customerData.isAgreeRenew() ? 'S' : 'N');
		if (customerData.isAgreeRenew()) {
			applicationNewRequest.setReasonForNotRenewing(""); // review
		}
		applicationNewRequest.setEntrepreneurship('N'); // review no esta
		applicationNewRequest.setPercentageGuarantee(0.00);// review esta en la
															// pantalla
		applicationNewRequest.setComentary("Operation Created From Mobil App");
		applicationNewRequest.setNature("APP_MOVIL");
		applicationNewRequest.setCity(1);
		applicationNewRequest.setType("O");
		logger.logDebug("getTDividend " + applicationNewRequest.getTDividend());
		logger.logDebug("getTerm " + applicationNewRequest.getTerm());
		logger.logDebug("getTermType " + applicationNewRequest.getTermType());
		applicationNewRequest.setAlliance(customerData.getAvalCode());
		// ///////
		applicationNewRequest.setIdRequested(applicationNumber);
		applicationNewRequest.setBank(applicationResponse.getOperationNumberBank());

		applicationNewRequest.setAmount(request.getApplicationData().getAmountOriginalRequest());
		applicationNewRequest.setApprovedAmount(request.getApplicationData().getAuthorizedAmount());

		logger.logDebug("Settings paramaters on update individual application");
		applicationNewRequest.setPeriodCap(1);
		applicationNewRequest.setPeriodInt(1);
		logger.logDebug("getPeriodCap " + applicationNewRequest.getPeriodCap());
		logger.logDebug("getPeriodInt " + applicationNewRequest.getPeriodInt());
		applicationNewRequest.setTDividend(request.getApplicationData().getFrecuency());
		logger.logDebug("getTDividend " + applicationNewRequest.getTDividend());
		applicationNewRequest.setTerm(Integer.parseInt(request.getApplicationData().getTerm()));
		logger.logDebug("getTerm " + applicationNewRequest.getTerm());
		applicationNewRequest.setTermType("M");
		logger.logDebug("getTermType " + applicationNewRequest.getTermType());
		try {

			serviceResponse = applicationService.updateApplication(applicationNewRequest);
			if (serviceResponse.isResult()) {
				creditApplicationData = new CreditApplicationData();
				creditApplicationData.setApplicationCode(applicationNumber);
				response.setResult(true);
				response.setData(creditApplicationData);
			} else {
				response.setResult(false);
				response.setData(null);
				response.setMessages(serviceResponse.getMessages());
			}
			return response;
		} catch (IntegrationException e) {
			response = e.getResponse();
			response.setData(null);
		}

		return response;
	}

}
