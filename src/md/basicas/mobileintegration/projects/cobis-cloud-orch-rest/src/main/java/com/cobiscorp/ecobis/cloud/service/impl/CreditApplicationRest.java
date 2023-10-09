package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.cloud.service.CreditApplicationService;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditAmountResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplication;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIncompleteResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.InstanceProcessData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.MaxAmount;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.MemberRequest;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupValidation;
import com.cobiscorp.ecobis.cloud.service.integration.ApplicationService;
import com.cobiscorp.ecobis.cloud.service.integration.GroupIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.QueryBureauService;
import com.cobiscorp.ecobis.cloud.service.integration.QueryRulesService;
import com.cobiscorp.ecobis.cloud.service.integration.QuerySantanderService;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationNewRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.loangroup.dto.ApplicationGroupResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

/**
 * Created by ntrujillo on 14/07/2017.
 */

@Path("/cobis-cloud/mobile/creditapplication")
@Component
@Service({ CreditApplicationRest.class })
public class CreditApplicationRest implements CreditApplicationService {

	private final ILogger logger = LogFactory.getLogger(CreditApplicationRest.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
	private ICobisParameter parameterService;

	private WorkflowService workflowService;
	private ApplicationService applicationService;
	private OfficerIntegrationService officerIntegrationService;
	private GroupIntegrationService integrationService;
	private QueryBureauService queryBureauService;
	private QuerySantanderService querySantanderService;
	private QueryRulesService queryRulesService;

	/**
	 * Crea la instancia de proceso Crea el trámite Consulta los valores de montos
	 * para devolver (montos de la solicitud anterior si fue rechazada, incremento
	 * grupal, monto grupal) No actualiza montos No Evalúa políticas No Rutea
	 * 
	 * Mandan la misma información que cuando crean una completa , excepto la lista
	 * de MemberRequest
	 */

	// si la movil no puede distinguir, el rest hace una consulta extra para
	// saber que devolver

	@Path("/createIncomplete") // asumiendo que el móbil puede discriminar si
								// puede crear o no
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createCreditApplicationIncomplete(CreditApplicationRequest request) {
		try {
			logger.logInfo("/cobis-cloud/mobile/creditapplication/createIncomplete Request>>" + objectToJson(request));

			int officerId = 0;
			StringBuilder processName = new StringBuilder();
			if (officerIntegrationService != null) {
				OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
				officerId = officerResponse.getOfficerId();
			}

			if (SessionUtil.getOffice() == 0) {
				request.setOffice(1101);
			} else {
				request.setOffice(SessionUtil.getOffice());
			}

			request.setOfficer(officerId);

			if (Constants.TYPE_REQUEST_RENOVATION.equals(request.getRequestType())) {
				String processNamePart1 = parameterService.getParameter(null, "CRE", "WSCRN1", String.class);
				String processNamePart2 = parameterService.getParameter(null, "CRE", "WSCRN2", String.class);
				processName.append(processNamePart1);
				processName.append(processNamePart2);
			} else {
				String processNamePart1 = parameterService.getParameter(null, "CRE", "WSCGR1", String.class);
				String processNamePart2 = parameterService.getParameter(null, "CRE", "WSCGR2", String.class);
				processName.append(processNamePart1);
				processName.append(processNamePart2);
			}

			logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete office >>" + request.getOffice());
			logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete officer >>" + request.getOfficer());

			CreditApplicationIncompleteResponse creditApplicationResponse = new CreditApplicationIncompleteResponse();
			InstanceProcessData instanceProcessData;
			ServiceResponse instanceProcessResponse;
			TaskDTO taskDTO;
			int processInstance = request.getProcessInstance();

			String processNameIngreso = parameterService.getParameter(null, "CRE", "ETINGR", String.class);

			if (processInstance <= 0) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete 1 - Create process Instance");

				instanceProcessResponse = workflowService.createProcessIntance(processName.toString(), request.getGroupNumber(), 0, null, "GRUPAL", "S", request.getOffice(), 12);
				creditApplicationResponse.setProcessInstance(instanceProcessResponse);

				if (!instanceProcessResponse.isResult()) {
					return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/createIncomplete");
				} else {
					instanceProcessData = (InstanceProcessData) instanceProcessResponse.getData();
					processInstance = instanceProcessData.getProcessInstance();
				}
			}

			logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete Retrieving current task por instance --> " + processInstance);
			ServiceResponse currentTaskResponse = workflowService.getCurrentTask(processInstance);
			if (!currentTaskResponse.isResult()) {
				creditApplicationResponse.setProcessInstance(currentTaskResponse);
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/createIncomplete");
			}
			taskDTO = (TaskDTO) currentTaskResponse.getData();

			logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete  taskDTO.getTaskSubject():  " + taskDTO.getTaskSubject() + "--");

			ServiceResponse instanceProcessInstance = new ServiceResponse();
			InstanceProcessData data = new InstanceProcessData();
			data.setProcessInstance(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
			data.setAlternateCode(taskDTO.getAlternateCode());
			instanceProcessInstance.setResult(true);
			instanceProcessInstance.setData(data);
			creditApplicationResponse.setProcessInstance(instanceProcessInstance);

			if (!processNameIngreso.equals(taskDTO.getTaskSubject())) {
				logger.logError("Etapa diferente a INGRESO SOLICITUD");
				ServiceResponse response = new ServiceResponse();
				response.setData(null);
				List<Message> messages = new ArrayList<Message>();
				Message message = new Message();
				message.setCode("500");
				message.setMessage("La solicitud se encuentra en la etapa de " + taskDTO.getTaskSubject() + ". No se puede modificar.");
				messages.add(message);
				response.setMessages(messages);
				creditApplicationResponse.setCreditApplication(response);
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/createIncomplete");
			}

			logger.logDebug("/cobis-cloud/mobile/creditapplication/createIncomplete officer Save Application");
			ServiceResponse applicationResponse;

			applicationResponse = createApplication(request, Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));

			creditApplicationResponse.setCreditApplication(applicationResponse);
			if (!applicationResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/createIncomplete");
			}

			CreditApplicationData creditApplicationData = (CreditApplicationData) applicationResponse.getData();

			List<MaxAmount> amounts = integrationService.searchMaxAmounts(request.getGroupNumber(), creditApplicationData.getApplicationCode(), request.getRequestType());
			ServiceResponse amountsResponse = new ServiceResponse();
			amountsResponse.setData(amounts);
			amountsResponse.setResult(true);

			creditApplicationResponse.setAmounts(amountsResponse);

			return successResponse(creditApplicationResponse, true, "/cobis-cloud/mobile/creditapplication/createIncomplete");
		} catch (IntegrationException ie) {
			logger.logError("Error al crear solicitud /cobis-cloud/mobile/creditapplication/createIncomplete ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear solicitud /cobis-cloud/mobile/creditapplication/createIncomplete ", e);
			return errorResponse("Error al crear solicitud");
		}
	}

	@Path("/updatePromotion")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updatePromotion(CreditApplicationRequest request) {
		try {
			logger.logInfo("/cobis-cloud/mobile/creditapplication/updatePromotion Request>>" + objectToJson(request));

			String processNameIngreso = parameterService.getParameter(null, "CRE", "ETINGR", String.class);
			int officerId = 0;
			if (officerIntegrationService != null) {
				OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
				officerId = officerResponse.getOfficerId();
			}

			if (SessionUtil.getOffice() == 0) {
				request.setOffice(1101);
			} else {
				request.setOffice(SessionUtil.getOffice());
			}

			request.setOfficer(officerId);

			logger.logDebug("/cobis-cloud/mobile/creditapplication/updatePromotion officeId >>" + request.getOffice());
			logger.logDebug("/cobis-cloud/mobile/creditapplication/updatePromotion officerId >>" + request.getOfficer());

			CreditApplicationIncompleteResponse creditApplicationResponse = new CreditApplicationIncompleteResponse();
			InstanceProcessData instanceProcessData;
			ServiceResponse instanceProcessResponse = new ServiceResponse();
			ServiceResponse currentTaskResponse = workflowService.getCurrentTask(request.getProcessInstance());

			TaskDTO taskDTO;
			if (currentTaskResponse.isResult()) {
				taskDTO = (TaskDTO) currentTaskResponse.getData();
				instanceProcessData = new InstanceProcessData();
				instanceProcessData.setProcessInstance(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
				instanceProcessData.setAlternateCode(taskDTO.getAlternateCode());
				instanceProcessResponse.setResult(true);
				instanceProcessResponse.setData(instanceProcessData);
			} else {
				return successResponse(currentTaskResponse, false, "/cobis-cloud/mobile/creditapplication/updatePromotion");
			}
			logger.logDebug("/cobis-cloud/mobile/creditapplication/updatePromotion taskDTO.getTaskSubject() >>" + taskDTO.getTaskSubject());

			creditApplicationResponse.setProcessInstance(instanceProcessResponse);

			if (!processNameIngreso.equals(taskDTO.getTaskSubject())) {
				logger.logError("/cobis-cloud/mobile/creditapplication/updatePromotion Etapa diferente a INGRESO SOLICITUD");
				ServiceResponse response = new ServiceResponse();
				response.setData(null);
				List<Message> messages = new ArrayList<Message>();
				Message message = new Message();
				message.setCode("500");
				message.setMessage("La solicitud se encuentra en la etapa de " + taskDTO.getTaskSubject() + ". No se puede modificar.");
				messages.add(message);
				response.setMessages(messages);
				creditApplicationResponse.setCreditApplication(response);
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/updatePromotion");
			}

			ServiceResponse applicationResponse = updateApplication(request, taskDTO.getOwnerIdentifier());

			creditApplicationResponse.setCreditApplication(applicationResponse);
			if (!applicationResponse.isResult()) {
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/updatePromotion");
			}

			CreditApplicationData creditApplicationData = (CreditApplicationData) applicationResponse.getData();

			creditApplicationData.setApplicationDate(request.getApplicationDate());
			creditApplicationData.setGroupCycle(request.getGroupCycle());
			logger.logDebug("creditApplicationData.getInterestRate():" + creditApplicationData.getInterestRate());
			try {

				if (creditApplicationData.getInterestRate() == 0) {
					String rate = request.getRate();
					if (request.getRate() != null) {
						rate = rate.replace(",", ".");
						creditApplicationData.setInterestRate(Float.parseFloat(rate));
					}
				}

			} catch (Exception e) {
				logger.logError("Error al convertir la tasa");
			}

			List<MaxAmount> amounts = integrationService.searchMaxAmounts(request.getGroupNumber(), creditApplicationData.getApplicationCode(), request.getRequestType());
			ServiceResponse amountsResponse = new ServiceResponse();
			amountsResponse.setData(amounts);
			amountsResponse.setResult(true);
			creditApplicationResponse.setAmounts(amountsResponse);

			return successResponse(creditApplicationResponse, true, "/cobis-cloud/mobile/creditapplication/createIncomplete");
		} catch (IntegrationException ie) {
			logger.logError("Error al crear solicitud /cobis-cloud/mobile/creditapplication/createIncomplete ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al crear solicitud /cobis-cloud/mobile/creditapplication/createIncomplete ", e);
			return errorResponse("Error al crear solicitud");
		}
	}

	@Path("/{id}/readCreditApplication")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readCreditApplication(@PathParam("id") int processInstance) {
		try {
			logger.logInfo("/cobis-cloud/mobile/creditapplication/readCreditApplication processInstance>>" + processInstance);

			TaskDTO taskDTO;
			ServiceResponse currentTaskResponse = workflowService.getCurrentTask(processInstance);
			CreditApplicationResponse creditApplicationResponse = new CreditApplicationResponse();
			if (!currentTaskResponse.isResult()) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/readCreditApplication currentTaskResponse.isResult() es false ");
				creditApplicationResponse.setProcessInstance(currentTaskResponse);
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/readCreditApplication");
			}
			taskDTO = (TaskDTO) currentTaskResponse.getData();
			int applicationId = 0;
			if (taskDTO != null) {
				applicationId = taskDTO.getOwnerIdentifier();
				logger.logDebug("/cobis-cloud/mobile/creditapplication/readCreditApplication taskDTO no es null. applicationId>> " + applicationId);
			}
			ApplicationGroupResponse getApplication = integrationService.readGroupApplication(applicationId);
			CreditApplication creditApplication = CreditApplication.fromResponse(applicationId, getApplication, applicationService);
			if (creditApplication == null)
				return errorResponse(Response.Status.NOT_FOUND);
			return successResponse(creditApplication, "/cobis-cloud/mobile/creditapplication/readCreditApplication");
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar solicitud /cobis-cloud/mobile/creditapplication/readCreditApplication ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al consultar solicitud /cobis-cloud/mobile/creditapplication/readCreditApplication ", e);
			return errorResponse("Error al consultar solicitud");
		}
	}

	@Path("/{id}")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateCreditApplication(@PathParam("id") int processInstance, CreditApplicationRequest request, @Context HttpServletRequest httpRequest) {
		// Encontrado desde: Ingreso de Montos
		try {
			String wlog = "/cobis-cloud/mobile/creditapplication/updateCreditApplication Request>>";
			logger.logInfo(wlog + objectToJson(request));
			
			Integer channel = Integer.parseInt(httpRequest.getHeader(Constants.CHANNEL));
			
			CreditApplicationResponse creditApplicationResponse = new CreditApplicationResponse();
			StringBuilder errors = new StringBuilder();
			String processNameIngreso = parameterService.getParameter(null, "CRE", "ETINGR", String.class);
			String renapo = parameterService.getParameter(null, "CLI", "RENAPO", String.class);
			int officerId = 0;
			if (officerIntegrationService != null) {
				OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
				officerId = officerResponse.getOfficerId();
			}

			if (SessionUtil.getOffice() == 0) {
				request.setOffice(1101);
			} else {
				request.setOffice(SessionUtil.getOffice());
			}

			request.setOfficer(officerId);

			logger.logDebug(wlog + " officeId >>" + request.getOffice());
			logger.logDebug(wlog + " officerId >>" + request.getOfficer());
			logger.logDebug(wlog + " Channel >> " + channel);
			
			logger.logError("Inicia consultar BURO");

			List<CustomerDto> clients = new ArrayList<CustomerDto>();
			for (MemberRequest member : request.getMembers()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("ClienteBURO: " + member.getCode() + " isParticipant:" + member.isParticipant());
				}
				if (member.isParticipant()) {
					clients.add(new CustomerDto(member.getCode(), member.getName(), member.getCheckRenapo()));
				}
			}
	
			BuroClientGroupRequest buroClientGroupRequest = new BuroClientGroupRequest();
			buroClientGroupRequest.setGroupId(request.getGroupNumber());
			buroClientGroupRequest.setChannel(channel);
			
			logger.logDebug(wlog + ">>ACH-BORRAR R1: buroClientGroupRequest: " + buroClientGroupRequest.getChannel());

			ServiceResponse bureauResponse = queryBureauService.excuteQueryBureauForGroup(clients, renapo, buroClientGroupRequest);

			creditApplicationResponse.setCreditApplication(bureauResponse);
			if (!bureauResponse.isResult()) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication bureauResponse.isResult() es false");
				return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			// se comenta Altair en actualizacion de credito.
			// querySantanderService.executeQuerySantanderForGroup(request.getGroupNumber(),
			// clientIds);
			queryRulesService.executeQueryRules(request.getGroupNumber(), clients);

			logger.logError("Termina consultar BURO");

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
				return successResponse(currentTaskResponse, false, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}
			logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication taskDTO.getTaskSubject() >>" + taskDTO.getTaskSubject());

			creditApplicationResponse.setProcessInstance(instanceProcessResponse);

			if (!processNameIngreso.equals(taskDTO.getTaskSubject())) {
				logger.logError("/cobis-cloud/mobile/creditapplication/updateCreditApplication Etapa diferente a INGRESO SOLICITUD");
				ServiceResponse response = new ServiceResponse();
				response.setData(null);
				List<Message> messages = new ArrayList<Message>();
				Message message = new Message();
				message.setCode("500");
				message.setMessage("La solicitud se encuentra en la etapa de " + taskDTO.getTaskSubject() + ". No se puede modificar.");
				messages.add(message);
				response.setMessages(messages);
				creditApplicationResponse.setCreditApplication(response);
				return successResponse(creditApplicationResponse, false, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			ServiceResponse applicationResponse = updateApplication(request, taskDTO.getOwnerIdentifier());

			creditApplicationResponse.setCreditApplication(applicationResponse);
			if (!applicationResponse.isResult()) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication applicationResponse.isResult() es false");
				return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			CreditApplicationData creditApplicationData = (CreditApplicationData) applicationResponse.getData();

			creditApplicationData.setApplicationDate(request.getApplicationDate());
			creditApplicationData.setGroupCycle(request.getGroupCycle());

			logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication 3 - Update Amounts");
			CreditAmountResponse creditAmountResponse = new CreditAmountResponse();
			creditAmountResponse = updateAmounts(creditApplicationData.getApplicationCode(), request.getGroupNumber(), request.getMembers());
			ServiceResponse updateAmountResponse = creditAmountResponse.getServiceResponse();
			try {
				if (creditAmountResponse.getTasa() == null) {
					String rate = request.getRate();
					if (request.getRate() != null) {
						rate = rate.replace(",", ".");
						creditApplicationData.setInterestRate(Float.parseFloat(rate));
					}
				} else {
					creditApplicationData.setInterestRate(Float.parseFloat(creditAmountResponse.getTasa()));
				}
			} catch (Exception e) {
				logger.logError("Error al convertir la tasa");
			}

			ServiceResponse response = new ServiceResponse();
			response.setResult(true);
			response.setData(creditApplicationData);
			creditApplicationResponse.setCreditApplication(response);

			creditApplicationResponse.setUpdateAmounts(updateAmountResponse);
			if (!updateAmountResponse.isResult()) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication updateAmountResponse.isResult() es false");
				return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			} else {
				if (request.isConfirmation() == true) {
					updateAmountResponse.setData(null);
					creditApplicationResponse.setUpdateAmounts(updateAmountResponse);
					logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication isConfirmation es true");

				}
				if (!request.isConfirmation() && updateAmountResponse.getMessages().size() != 0) {
					logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication mensajes>>" + String.valueOf(updateAmountResponse.getMessages().size()));
					if (updateAmountResponse.getData() != null) {
						logger.logDebug(" [CreditApplicationRest - creditApplicationResponse] 3.3");
						return successResponse(creditApplicationResponse, true, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
					}
				}
			}

			boolean passPolitics = true;
			logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication 4 - Evaluate Politics");
			ServiceResponse evaluatePoliticsResponse = workflowService.evaluatePolicies(taskDTO);
			creditApplicationResponse.setEvaluatePolitics(evaluatePoliticsResponse);
			if (!evaluatePoliticsResponse.isResult()) {
				passPolitics = false;
				// return successResponse(creditApplicationResponse,
				// "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication 5 - WorkflowObservations");
			ServiceResponse observations = workflowService.getWorkflowLines(taskDTO);
			creditApplicationResponse.setObservations(observations);
			if (!observations.isResult() || passPolitics == false) {
				return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			logger.logDebug("/cobis-cloud/mobile/creditapplication/updateCreditApplication 6 - Complete Task");
			ServiceResponse completeTaskResponse = workflowService.completeWorkflowTask(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()),
					Integer.valueOf(taskDTO.getTaskInstanceIdentifier()), taskDTO.getCobisAssignAct(), taskDTO.getCobisStepId());
			creditApplicationResponse.setCompleteTask(completeTaskResponse);
			if (!completeTaskResponse.isResult()) {
				return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");
			}

			return successResponse(creditApplicationResponse, "/cobis-cloud/mobile/creditapplication/updateCreditApplication");

		} catch (IntegrationException ie) {
			logger.logError("Error al actualizar solicitud /cobis-cloud/mobile/creditapplication/updateCreditApplication ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error al actualizar solicitud /cobis-cloud/mobile/creditapplication/updateCreditApplication ", e);
			return errorResponse("Error al actualizar solicitud");
		}

	}

	@Path("/validateGroups")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public Response validateGroups(List<GroupValidation> groups) {
		ServiceResponse serviceResponse = null;
		try {
			logger.logInfo("/cobis-cloud/mobile/creditapplication/validateGroups Request>>" + objectToJson(groups));
			for (GroupValidation groupValidation : groups) {
				logger.logDebug("/cobis-cloud/mobile/creditapplication/validateGroups validating>>" + groupValidation.getGroupId());
				try {
					serviceResponse = applicationService.validateGroup(groupValidation.getGroupId(), groupValidation.getRequestType());
					if (serviceResponse.isResult()) {
						groupValidation.setAvailableForCredit(true);
					} else {
						groupValidation.setAvailableForCredit(false);
					}
				} catch (Exception ex) {
					logger.logError("/cobis-cloud/mobile/creditapplication/validateGroups " + groupValidation.getGroupId(), ex);
					groupValidation.setAvailableForCredit(false);
				}
			}
		} catch (IntegrationException ie) {
			logger.logError("Error al validar grupos /cobis-cloud/mobile/creditapplication/validateGroups ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("Error validar grupos /cobis-cloud/mobile/creditapplication/validateGroups ", e);
			return errorResponse("Error validar grupos");
		}
		return successResponse(groups, "/cobis-cloud/mobile/creditapplication/validateGroups");
	}

	private ServiceResponse createApplication(CreditApplicationRequest request, int procesInstance) {

		ServiceResponse serviceResponse;
		ServiceResponse response;
		CreditApplicationData creditApplicationData;
		CreditApplicationData creditApplicationDataCredit;
		response = new ServiceResponse();
		try {
			logger.logDebug("/cobis-cloud/mobile/creditapplication/ Starting createApplication");
			serviceResponse = applicationService.createGrpApplication(request, procesInstance);
			if (serviceResponse.isResult()) {
				creditApplicationData = (CreditApplicationData) serviceResponse.getData();
				workflowService.updateInstanceProcess(procesInstance, creditApplicationData.getApplicationCode());
				/* Inicio se anade campo 5 */
				logger.logDebug("/cobis-cloud/mobile/creditapplication/ Inicia metodo pdateFieldFive desde la movil:" + procesInstance);
				ApplicationRequest applicationRequest = new ApplicationRequest();
				applicationRequest.setInstProcess(procesInstance);
				ServiceResponse serviceResponseCredit = workflowService.updateFieldFive(applicationRequest);

				creditApplicationDataCredit = (CreditApplicationData) serviceResponseCredit.getData();
				logger.logDebug("/cobis-cloud/mobile/creditapplication/ Fin metodo updateFieldFive desde la movil");
				/* Fin se anade campo 5 */
				response.setResult(true);
				// creditApplicationData.setInterestRate(creditApplicationDataCredit.getInterestRate());

				response.setData(creditApplicationData);
			} else {
				response.setResult(false);
				response.setData(null);
				response.setMessages(serviceResponse.getMessages());
			}
		} catch (IntegrationException e) {
			response = e.getResponse();
			response.setData(null);
		}

		return response;
	}

	private ServiceResponse updateApplication(CreditApplicationRequest request, int applicationNumber) {
		logger.logDebug("/cobis-cloud/mobile/creditapplication/ Starting updateApplication");
		ServiceResponse serviceResponse;
		ServiceResponse response = new ServiceResponse();
		ApplicationResponse applicationResponse = applicationService.getApplication(applicationNumber);
		ApplicationNewRequest applicationNewRequest = new ApplicationNewRequest();
		applicationNewRequest.setIdRequested(applicationNumber);
		applicationNewRequest.setBank(applicationResponse.getOperationNumberBank());

		applicationNewRequest.setOffice(request.getOffice());
		applicationNewRequest.setOfficer(request.getOfficer());
		applicationNewRequest.setClient(applicationResponse.getClient());
		// applicationNewRequest.setCity(applicationResponse.getCity()); el sp
		// retorna null
		applicationNewRequest.setPromotion(request.isPromotion() ? 'S' : 'N');
		applicationNewRequest.setGroup("S");
		applicationNewRequest.setOpertationType("GRUPAL");
		applicationNewRequest.setAmount(request.getGroupAmount());
		applicationNewRequest.setApprovedAmount(request.getGroupAmount());
		applicationNewRequest.setType(Constants.TYPE_REQUEST_RENOVATION.equals(request.getRequestType()) ? "R" : "O");
		logger.logDebug("/cobis-cloud/mobile/creditapplication/ Settings paramaters on update grupal application");
		applicationNewRequest.setPeriodCap(1);
		applicationNewRequest.setPeriodInt(1);
		// SRO. #140073
		applicationNewRequest.setTerm(request.getTerm() == null ? null : Integer.valueOf(request.getTerm()));
		applicationNewRequest.setDisplacement(request.getDisplacement() == null ? null : Integer.valueOf(request.getDisplacement()));

		logger.logDebug("/cobis-cloud/mobile/creditapplication/ getPeriodCap " + applicationNewRequest.getPeriodCap());
		logger.logDebug("/cobis-cloud/mobile/creditapplication/ getPeriodInt " + applicationNewRequest.getPeriodInt());
		applicationNewRequest.setGroupAgreesToRenew(request.isGroupAgreeRenew() ? 'S' : 'N');
		if (request.isGroupAgreeRenew()) {
			request.setReasonNotAccepting(request.getReasonNotAccepting());
		}
		try {
			serviceResponse = applicationService.updateApplication(applicationNewRequest);
			CreditApplicationData creditApplicationData;
			if (serviceResponse.isResult()) {
				float tasa_grupal_f = 0.0f;
				creditApplicationData = new CreditApplicationData();
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (outputs != null) {
					String tasa_grupal = outputs.get("@o_tasa_grp");
					logger.logDebug("obtiene la tasa grupal " + tasa_grupal);
					try {
						tasa_grupal_f = Float.parseFloat(tasa_grupal);
					} catch (Exception ex) {
						logger.logDebug("Error al convertir a float la tasa " + tasa_grupal);
						tasa_grupal_f = 0.0f;
					}
				}
				creditApplicationData.setInterestRate(tasa_grupal_f);
				creditApplicationData.setApplicationCode(applicationNumber);
				response.setResult(true);
				response.setData(creditApplicationData);

			} else {
				response.setResult(false);
				response.setData(null);
				response.setMessages(serviceResponse.getMessages());
			}
		} catch (IntegrationException e) {
			response = e.getResponse();
			response.setData(null);
		}
		return response;
	}

	private CreditAmountResponse updateAmounts(int applicationNumber, int groupNumber, List<MemberRequest> members) {
		logger.logDebug("/cobis-cloud/mobile/creditapplication/ Starting updateAmounts");
		CreditAmountResponse creditAmountResponse = new CreditAmountResponse();
		ServiceResponse updateAmountResponse;

		try {
			logger.logDebug(" /cobis-cloud/mobile/creditapplication/ parameterService --> " + parameterService);
			Long minimumSavings = parameterService.getParameter(null, "CRE", "VAHVO", Long.class);
			logger.logDebug(" /cobis-cloud/mobile/creditapplication/ minimumSavings  --> " + minimumSavings);

			if (minimumSavings == null) {
				updateAmountResponse = new ServiceResponse();
				updateAmountResponse.addMessage("", "Parameter Minimum Savings VAHVO not found ");
				creditAmountResponse.setServiceResponse(updateAmountResponse);
			} else {
				creditAmountResponse = applicationService.updateAmount(applicationNumber, groupNumber, members, minimumSavings);
				if (creditAmountResponse.getServiceResponse().isResult()) {
					logger.logDebug("/cobis-cloud/mobile/creditapplication/ Update Amounts delete messages and data when is successfull");
					logger.logDebug("/cobis-cloud/mobile/creditapplication/ updateAmountResponse.....--" + creditAmountResponse.getServiceResponse().getMessages() + "*--");
					logger.logDebug("/cobis-cloud/mobile/creditapplication/ updateAmountResponse.getData().....--"
							+ creditAmountResponse.getServiceResponse().getMessages().toString() + "*--");
				}
			}
		} catch (IntegrationException e) {
			logger.logError("/cobis-cloud/mobile/creditapplication/ Error al actualizar montos.....", e);
			updateAmountResponse = e.getResponse();
			updateAmountResponse.setData(null);
			creditAmountResponse.setServiceResponse(updateAmountResponse);
		}
		return creditAmountResponse;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		this.workflowService = new WorkflowService(serviceIntegration);
		this.applicationService = new ApplicationService(serviceIntegration);
		this.officerIntegrationService = new OfficerIntegrationService(serviceIntegration);
		this.integrationService = new GroupIntegrationService(serviceIntegration);
		this.queryBureauService = new QueryBureauService(serviceIntegration);
		// se comenta de Altair
		// this.querySantanderService = new
		// QuerySantanderService(serviceIntegration);
		this.queryRulesService = new QueryRulesService(serviceIntegration);

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
}