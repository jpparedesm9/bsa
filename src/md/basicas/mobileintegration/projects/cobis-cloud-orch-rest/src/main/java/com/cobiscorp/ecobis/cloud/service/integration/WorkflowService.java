package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ClaimInfo;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.htm.api.dto.TaskListRequest;
import cobiscorp.ecobis.htm.api.dto.UserDTO;
import cobiscorp.ecobis.inbox.commons.dto.Comment;
import cobiscorp.ecobis.inbox.commons.dto.CommentsRequest;
import cobiscorp.ecobis.inbox.commons.dto.Line;
import cobiscorp.ecobis.workflow.dto.AssignActivity;
import cobiscorp.ecobis.workflow.dto.InstanceProcess;
import cobiscorp.ecobis.workflow.dto.RuleProcessHistory;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CommentData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.InstanceProcessData;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

/**
 * Created by ntrujillo on 17/07/2017.
 */
public class WorkflowService extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(WorkflowService.class);

	private final String className = "[WorkflowService]";

	public WorkflowService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public ServiceResponse createProcessIntance(String processName, int intOne, int intTwo, String strOne, String strTwo, String strSeven, int officeId, int channel) {
		logger.logInfo(className + " start createProcessIntance " + processName);
		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		ProcessDTO process = new ProcessDTO();
		process.setRoutingType("M");
		process.setCobisUserName(SessionUtil.getUser());
		process.setFilial(1);
		process.setProcessId(null);
		process.setTemplateName(processName);
		process.setBussinessInformationIntOne(intOne);
		process.setBussinessInformationIntTwo(intTwo);
		process.setBussinessInformationIntThree(0);
		process.setBussinessInformationStringOne(strOne);
		process.setBussinessInformationStringTwo(strTwo);
		process.setBussinessInformationDoubleSix(0.00);
		process.setBussinessInformationStringSeven(strSeven);
		process.setOfficeId(officeId);
		process.setChannel(channel);
		logger.logInfo(className + " start createProcessIntance officeId " + officeId);
		serviceRequest.addValue("inProcessDTO", process);

		InstanceProcessData instanceProcess = new InstanceProcessData();

		try {
			ServiceResponse serviceResponse;
			serviceRequest.setServiceId("HTM.API.HumanTask.CreateProcessInstance");
			serviceResponse = executeNormal("HTM.API.HumanTask.CreateProcessInstance", serviceRequest);

			if (serviceResponse.isResult()) {

				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

				logger.logDebug("Service response serviceResponseTO " + serviceResponseTO);
				Map processesResponse = (Map) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");

				logger.logDebug(" Map processesResponse  " + processesResponse);
				for (Iterator i$ = serviceResponseTO.getData().keySet().iterator(); i$.hasNext();) {
					Object iterador = i$.next();
					logger.logInfo(new StringBuilder().append("objetos : ").append(iterador).toString());
				}

				logger.logDebug("processesResponse workflow " + processesResponse);
				if ((processesResponse != null) && (serviceResponse.getData() != null) && (processesResponse.get("@o_siguiente") != null)) {
					Object value = serviceResponseTO.getData().values().iterator().next();

					logger.logDebug(new StringBuilder().append("objeto encontrado : ").append(value).toString());

					String processId = "", alternateCode = "";

					processId = ((String) processesResponse.get("@o_siguiente")).toString();
					alternateCode = ((String) processesResponse.get("@o_siguiente_alterno")).toString();

					instanceProcess.setProcessInstance(Integer.parseInt(processId));
					instanceProcess.setAlternateCode(alternateCode);
					serviceResponse.setData(instanceProcess);
					return serviceResponse;

				} else {
					serviceResponse = new ServiceResponse();
					serviceResponse.setResult(false);
					serviceResponse.setData(null);
					return serviceResponse;
				}

			} else {
				// serviceResponse = new ServiceResponse();
				// serviceResponse.setResult(false);
				// serviceResponse.setData(null);
				return serviceResponse;
			}
		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

	public ServiceResponse evaluatePolicies(TaskDTO taskDTO) {
		logger.logDebug("start Evaluate Politics ");
		logger.logDebug("AssingedActivity " + taskDTO.getCobisAssignAct());
		logger.logDebug("instanceActivity " + taskDTO.getTaskInstanceIdentifier());
		logger.logDebug("ProcessIdentifier " + taskDTO.getProcessInstanceIdentifier());
		logger.logDebug("stepId " + taskDTO.getCobisStepId());

		ServiceResponse evaluatePoliciesResponse;

		if (!evaluatePolicies(taskDTO.getCobisAssignAct(), Integer.parseInt(taskDTO.getTaskInstanceIdentifier()), Integer.parseInt(taskDTO.getProcessInstanceIdentifier()), 1,
				taskDTO.getCobisStepId())) {
			logger.logDebug(" 4 - Not pass Politics retrieving politics detail list");
			evaluatePoliciesResponse = new ServiceResponse();
			evaluatePoliciesResponse.setResult(false);

			List<RuleProcessHistory> politics = retrievePoliticsList(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));

			List<Message> messages = queryRulesHistory(politics, Integer.parseInt(taskDTO.getProcessInstanceIdentifier()), taskDTO.getCobisAssignAct());

			Message errorMessage = new Message();
			errorMessage.setCode("ERR_POL");
			StringBuffer messageBuffer = new StringBuffer("NO CUMPLE POLITICAS: ");
			for (Message tmp : messages) {
				messageBuffer.append(" *").append(tmp.getMessage()).append(". ");

			}
			errorMessage.setMessage(messageBuffer.toString());
			messages = new ArrayList<Message>();
			messages.add(errorMessage);

			evaluatePoliciesResponse.setMessages(messages);

		} else {
			evaluatePoliciesResponse = new ServiceResponse();
			evaluatePoliciesResponse.setResult(true);

		}

		return evaluatePoliciesResponse;
	}

	private boolean evaluatePolicies(int assignedActivityId, int instanceActivityId, int instanceProcessId, int resultId, int stepId) {
		logger.logInfo(className + " start evaluatePolicies  for instance  " + instanceProcessId);

		logger.logDebug("1)--------------------->Declaro los servicios");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		boolean passPolicies = false;
		logger.logDebug("2)--------------------->Formo el objeto a ser enviado");
		AssignActivity assignActivity = new AssignActivity();
		assignActivity.setIdAssignActivity(assignedActivityId);
		assignActivity.setIdInstanceActivity(instanceActivityId);
		assignActivity.setIdInstanceProcess(instanceProcessId);
		assignActivity.setIdResult(resultId);
		assignActivity.setIdStep(stepId);

		logger.logDebug("3)--------------------->Ejecuto el servicio Workflow.Admin.WorkflowAdmin.EvaluatePolicy");
		serviceRequestTO.addValue("inAssignActivity", assignActivity);
		ServiceResponse serviceResponse = execute("Workflow.Admin.WorkflowAdmin.EvaluatePolicy", serviceRequestTO);
		logger.logDebug("4)---------------------> Result ejecucion politics" + serviceResponse.isResult());
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug("5)---------------------> service Response execution politics" + serviceResponseTO.isSuccess());
			if (serviceResponseTO.isSuccess()) {
				Map processesResponse = (Map) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug(processesResponse.get("@o_error_politica"));
				passPolicies = !processesResponse.get("@o_error_politica").equals("S");
				logger.logDebug("6)--------------------->  pass Policies" + passPolicies);
			}
		}

		return passPolicies;
	}

	public ServiceResponse getCurrentTask(int processInstance) {

		logger.logInfo(className + " start getCurrentTask  for instance  " + processInstance);
		ServiceResponse response;
		try {
			TaskListRequest taskListRequest = new TaskListRequest();
			taskListRequest.setInstProcess(processInstance);
			taskListRequest.setGroupFilter("S");
			taskListRequest.setLastRecordId("0");
			ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
			serviceRequestApplicationTO.addValue("inTaskListRequest", taskListRequest);

			logger.logDebug("Retrieve information for instance " + processInstance);
			ServiceResponse serviceResponse = execute("HTM.API.HumanTask.GetTaskListCriteria", serviceRequestApplicationTO);

			TaskDTO[] taskDTOR = {};
			response = new ServiceResponse();
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			taskDTOR = (TaskDTO[]) serviceResponseTO.getValue("returnTaskDTO");

			if (taskDTOR.length > 0) {
				logger.logError("Si existe la tarea>> " + processInstance);
				response.setResult(true);
				response.setData(taskDTOR[0]);
			} else {
				logger.logError("No existe la tarea>> " + processInstance);
				response.setResult(false);
				response.setData(null);
			}

			return response;

		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

	public ServiceResponse completeWorkflowTask(int processInstance, int taskInstanceId, int assignAct, int stepId) {
		logger.logInfo("completeWorkflowTask  " + processInstance + " " + taskInstanceId + " " + assignAct + " " + stepId);
		try {

			ClaimInfo claimInfo = new ClaimInfo();
			UserDTO user = new UserDTO();
			claimInfo.setProcessInstanceId(String.valueOf(processInstance));
			claimInfo.setTaskInstanceId(String.valueOf(taskInstanceId));
			claimInfo.setCobisAssignAct(assignAct);
			claimInfo.setCobisStepId(stepId);
			claimInfo.setDecision("1");
			claimInfo.setFilial(1);

			ServiceRequestTO requestTO3 = new ServiceRequestTO();
			requestTO3.addValue("inClaimInfo", claimInfo);
			requestTO3.addValue("inUserDTO", user);

			return execute("HTM.API.HumanTask.CompleteTask", requestTO3);
		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

	public ServiceResponse completeWorkflowTask(int processInstance, String decision) {
		if (logger.isDebugEnabled())
			logger.logInfo("completeWorkflowTask  processInstance:" + processInstance + ", decision" + decision);
		ServiceResponse serviceResponse;
		serviceResponse = this.getCurrentTask(processInstance);

		if (serviceResponse.isResult()) {
			TaskDTO taskDTO = (TaskDTO) serviceResponse.getData();
			try {

				ClaimInfo claimInfo = new ClaimInfo();
				UserDTO user = new UserDTO();
				claimInfo.setProcessInstanceId(String.valueOf(processInstance));
				claimInfo.setTaskInstanceId(String.valueOf(taskDTO.getTaskInstanceIdentifier()));
				claimInfo.setCobisAssignAct(taskDTO.getCobisAssignAct());
				claimInfo.setCobisStepId(taskDTO.getCobisStepId());
				claimInfo.setDecision(decision);
				claimInfo.setFilial(1);

				ServiceRequestTO requestTO3 = new ServiceRequestTO();
				requestTO3.addValue("inClaimInfo", claimInfo);
				requestTO3.addValue("inUserDTO", user);

				return execute("HTM.API.HumanTask.CompleteTask", requestTO3);
			} catch (IntegrationException e) {
				return errorResponse(e);
			}
		}

		return serviceResponse;
	}

	public ServiceResponse completeWorkflowTask(int processInstance) {
		logger.logInfo("completeWorkflowTask  " + processInstance);
		ServiceResponse serviceResponse;
		serviceResponse = this.getCurrentTask(processInstance);

		if (serviceResponse.isResult()) {
			TaskDTO taskDTO = (TaskDTO) serviceResponse.getData();
			serviceResponse = this.completeWorkflowTask(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()), Integer.valueOf(taskDTO.getTaskInstanceIdentifier()),
					taskDTO.getCobisAssignAct(), taskDTO.getCobisStepId());
		}

		return serviceResponse;
	}

	public List<RuleProcessHistory> retrievePoliticsList(int aProcessInstance) {

		logger.logInfo(className + " start retrievePoliticsList  for instance  " + aProcessInstance);
		List<RuleProcessHistory> ruleProcessHistoryList;

		ruleProcessHistoryList = new ArrayList<RuleProcessHistory>();

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		RuleProcessHistory ruleProcess = new RuleProcessHistory();
		ruleProcess.setInstProcessId(aProcessInstance);
		ruleProcess.setType("P");
		serviceRequestTO.addValue("inRuleProcessHistory", ruleProcess);

		ServiceResponse serviceResponse = execute("Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess", serviceRequestTO);

		if ((serviceResponse != null) && (serviceResponse.isResult())) {
			logger.logDebug(className + "Ejecución del servicio satisfactoria");

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RuleProcessHistory[] ruleProcessHistory = (RuleProcessHistory[]) serviceResponseTO.getValue("returnRuleProcessHistory");
			if (ruleProcessHistoryList != null) {
				for (RuleProcessHistory r : ruleProcessHistory) {

					ruleProcessHistoryList.add(r);
				}
			}
			return ruleProcessHistoryList;

		} else {
			logger.logError(className + "No existe Información asociada a la instancia de proceso");
			return new ArrayList<RuleProcessHistory>();
		}
	}

	public List<Message> queryRulesHistory(List<RuleProcessHistory> rules, int processInstance, int asigActivity) {

		List<Message> messages = new ArrayList<Message>();
		List<Message> resultados;
		for (RuleProcessHistory r : rules) {
			resultados = queryRuleHistory(r.getRuleId(), processInstance, asigActivity);
			messages.addAll(resultados);
		}

		return messages;
	}

	public List<Message> queryRuleHistory(int ruleId, int processInstace, int asigActivityId) {
		logger.logInfo(className + " start queryRuleHistory  for ruleId " + ruleId + " process instance  " + processInstace);

		List<Message> messages = new ArrayList<Message>();
		ServiceResponse serviceResponse = new ServiceResponse();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		RuleProcessHistory ruleProcess = new RuleProcessHistory();
		ruleProcess.setInstProcessId(processInstace);
		ruleProcess.setRuleId(ruleId);
		ruleProcess.setType("P");
		ruleProcess.setAsigActivityId(asigActivityId);
		serviceRequestTO.addValue("inRuleProcessHistory", ruleProcess);

		serviceResponse = execute("Workflow.Admin.WorkflowAdmin.QueryRuleHistory", serviceRequestTO);
		boolean comply = true;
		if ((serviceResponse != null) && (serviceResponse.isResult())) {

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RuleProcessHistory[] ruleProcessHistoryList = (RuleProcessHistory[]) serviceResponseTO.getValue("returnRuleProcessHistory");
			Message message;
			if (ruleProcessHistoryList != null) {
				for (RuleProcessHistory r : ruleProcessHistoryList) {
					logger.logInfo(className + " start value policies " + r.getValue());
					if (r.getValue() != null && r.getValue().toLowerCase().trim().equals("no cumple")) {
						logger.logInfo(className + " not comply " + r.getValue().toLowerCase().trim());
						comply = false;

						message = new Message();
						message.setCode(r.getAcronym());
						message.setMessage(r.getRuleName());

						messages.add(message);

					}
				}
			}

		}

		return (comply ? new ArrayList<Message>() : messages);
	}

	public ServiceResponse updateInstanceProcess(int aInstanceProcess, int numeroTramite) {
		logger.logInfo(className + " start updateInstanceProcess  for instance  " + aInstanceProcess);

		ServiceResponse serviceResponse;

		try {
			InstanceProcess processeInsnumber = new InstanceProcess();
			processeInsnumber.setIdInstProc(aInstanceProcess);
			processeInsnumber.setCampo3(numeroTramite);
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue("inInstanceProcess", processeInsnumber);
			serviceResponse = this.execute("Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess", serviceRequestTO);
			return serviceResponse;
		} catch (IntegrationException e) {
			serviceResponse = new ServiceResponse();
			serviceResponse.setMessages(e.getResponse().getMessages());
			serviceResponse.setResult(false);
			serviceResponse.setData(null);
			return serviceResponse;
		}

	}

	public ServiceResponse updateFieldFive(ApplicationRequest applicationRequest) {
		logger.logInfo("Incia servicio updateFieldFive desde el movil para el proceso: " + applicationRequest.getInstProcess());
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inApplicationRequest", applicationRequest);
		ServiceResponse serviceResponse = execute("Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive", serviceRequestTO);
		ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
		CreditApplicationData creditApplicationData = new CreditApplicationData();
		float interestRate = 0;
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				Map<String, Object> applicationResponse = (Map) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				interestRate = Float.parseFloat((applicationResponse.get("@o_porcentaje").toString()));

				if (interestRate != 0) {
					creditApplicationData.setInterestRate(interestRate);
					serviceResponse.setData(creditApplicationData);
					serviceResponse.setMessages(new ArrayList<Message>());
				} else {
					serviceResponse.setResult(false);
					serviceResponse.setData(null);
				}
			}
		}
		logger.logInfo("Fin servicio updateFieldFive desde el movil para el proceso: " + applicationRequest.getInstProcess() + "resultado:" + serviceResponse.getData());
		return serviceResponse;
	}

	private ServiceResponse errorResponse(IntegrationException e) {
		ServiceResponse serviceResponse = new ServiceResponse();
		serviceResponse.setData(null);
		serviceResponse.setResult(false);
		serviceResponse.setMessages(e.getResponse().getMessages());
		return serviceResponse;
	}

	public ServiceResponse getWorkflowComments(TaskDTO taskDTO) {
		logger.logInfo("getWorkflowComments  " + taskDTO.getProcessInstanceIdentifier() + " " + taskDTO.getActivityIdentifier());
		try {

			CommentsRequest comentsRequest = new CommentsRequest();
			comentsRequest.setAsigAct(taskDTO.getActivityIdentifier());
			comentsRequest.setInstProccess(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()));
			comentsRequest.setOperation('S');
			comentsRequest.setSubOperation('I');

			ServiceRequestTO requestTO = new ServiceRequestTO();
			requestTO.addValue("inCommentsRequest", comentsRequest);

			return execute("Inbox.CommentsManager.GetComments", requestTO);
		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

	public ServiceResponse getWorkflowLines(TaskDTO taskDTO) {
		logger.logInfo("getWorkflowLines  " + taskDTO.getProcessInstanceIdentifier() + " " + taskDTO.getActivityIdentifier());
		try {
			ServiceResponse observation = new ServiceResponse();
			CommentData commentData = new CommentData();
			observation.setResult(false);

			ServiceResponse getCommentsResponse = getWorkflowComments(taskDTO);
			logger.logDebug("Data obtenida de getWorkflowComments: " + getCommentsResponse.getData());
			ServiceResponseTO commentsTOResponse = (ServiceResponseTO) getCommentsResponse.getData();

			if (commentsTOResponse != null) {
				Comment[] observationsDetail = (Comment[]) commentsTOResponse.getValue("returnComment");
				int lenComments = observationsDetail.length;
				this.logger.logDebug("Cantidad de observaciones: " + lenComments);
				if (lenComments == 0) {
					observation.setResult(true);
					observation.setData(null);
				} else {
					Comment comment = observationsDetail[lenComments - 1];

					CommentsRequest comentsRequest = new CommentsRequest();
					comentsRequest.setAsigAct(comment.getActivity());
					comentsRequest.setLine(0);
					comentsRequest.setNumber(comment.getNumber());
					comentsRequest.setOperation('S');
					comentsRequest.setSubOperation('L');

					ServiceRequestTO requestTO = new ServiceRequestTO();
					requestTO.addValue("inCommentsRequest", comentsRequest);
					ServiceResponse getLinesResponse = execute("Inbox.CommentsManager.GetLines", requestTO);

					ServiceResponseTO serviceTOResponseLine = (ServiceResponseTO) getLinesResponse.getData();
					Line[] lineDetail = (Line[]) serviceTOResponseLine.getValue("returnLine");
					StringBuffer description = new StringBuffer();

					for (Line lineResponse : lineDetail) {
						description.append(lineResponse.getText() == null ? "" : lineResponse.getText());
						logger.logInfo("lineResponses: " + lineResponse.getText());
					}
					if (description.length() != 0) {
						commentData.setActionType("Observaciones");
						commentData.setDescription(description.toString());

						observation.setResult(true);
						observation.setData(commentData);
					}
				}
			}
			return observation;
		} catch (IntegrationException e) {
			return errorResponse(e);
		}

	}

}
