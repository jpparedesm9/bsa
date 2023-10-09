
/**
 * Archivo: WorkflowService.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.cts.services.session.SessionCrypt;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.context.Context;
//include imports with key: WorkflowService.imports
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Session;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.htm.api.dto.TaskListRequest;

public class WorkflowServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IWorkflowService {
	private static ILogger logger = LogFactory.getLogger(WorkflowServiceSERVImpl.class);

	// include body with key: WorkflowService.body
	private static final String SERVICE_PARAMETERS = "SERVICE_PARAMETERS";
	private static final String SERVICE_RESPONSE = "SERVICE_RESPONSE";
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return this.serviceIntegration;
	}

	private ServiceResponseTO executeServiceInCTS(String serviceId, Map<String, Object> serviceRequestParameters, String serviceResponseParameterName) {

		Context wContext = ContextManager.getContext();
		Session wSession = wContext.getSession();

		logger.logError("sessionManager using sessionID:" + wSession.getSessionId());

		String sessionCrytp = SessionCrypt.encriptSessionID(wSession.getSessionId(), "address", "hostname");
		logger.logError("sessionCrytp:" + sessionCrytp);
		ServiceRequest header = new ServiceRequest();
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionCrytp);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		serviceRequest.setSessionId(sessionCrytp);
		ServiceResponseTO serviceResponse;
		serviceRequest.setServiceId(serviceId);
		for (Map.Entry<String, Object> entry : serviceRequestParameters.entrySet()) {
			serviceRequest.addValue(entry.getKey(), entry.getValue());
		}

		// TODO verify what happen with cobis context because it is null after cts
		// service execution

		serviceResponse = getServiceIntegration().getResponseFromCTS(serviceRequest);

		ContextRepository.setContext(wContext);
		if (serviceResponse.isSuccess()) {
			return serviceResponse;
		} else {
			MessageTO messageTO = (MessageTO) serviceResponse.getMessages().get(0);
			throw new COBISInfrastructureRuntimeException(messageTO.getMessage());
		}

	}

	private RuleVersion findRuleByAcronym(String acronymRule) {
		String serviceId = "Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym";
		Object arrInData[] = new Object[] { acronymRule };
		Map<String, Object> serviceParameters = new HashMap<String, Object>(1);
		serviceParameters.put(SERVICE_PARAMETERS, arrInData);
		ServiceResponseTO serviceExecutionResponse = executeServiceInCTS(serviceId, serviceParameters, SERVICE_RESPONSE);
		List<RuleVersion> ruleList = null;
		if (serviceExecutionResponse != null) {
			ruleList = (List<RuleVersion>) serviceExecutionResponse.getValue(SERVICE_RESPONSE);
		}
		if (ruleList.isEmpty()) {
			throw new COBISInfrastructureRuntimeException("Rule not found by acronym:" + acronymRule);
		}
		RuleVersion ruleVersion = ruleList.get(0);
		return ruleVersion;
	}

	private Map<String, String> applyRule(String acronymRule, Map<String, String> variablesProcess) {
		List<VariableProcess> listVariablesProcess = new ArrayList<VariableProcess>();

		for (Map.Entry<String, String> entry : variablesProcess.entrySet()) {
			VariableProcess variableProcess = new VariableProcess();
			Variable variable = new Variable();
			variable.setNombreVariable(entry.getKey());
			variableProcess.setValue(entry.getValue());
			variableProcess.setVariable(variable);
			listVariablesProcess.add(variableProcess);

		}

		RuleVersion ruleVersion = findRuleByAcronym(acronymRule);

		Map<String, String> results = new HashMap<String, String>();

		HashMap<RuleVersion, List<VariableProcess>> values = new HashMap<RuleVersion, List<VariableProcess>>();
		values.put(ruleVersion, listVariablesProcess);

		String serviceId = "Bpl.Rules.Engine.RuleManager.Generate";
		Object arrInData[] = new Object[] { values, 0, "", 3 };

		Map<String, Object> serviceParameters = new HashMap<String, Object>(1);
		serviceParameters.put(SERVICE_PARAMETERS, arrInData);

		ServiceResponseTO serviceExecutionResponse = executeServiceInCTS(serviceId, serviceParameters, SERVICE_RESPONSE);
		List<RuleProcess> resultados = null;
		if (serviceExecutionResponse != null) {
			resultados = (List<RuleProcess>) serviceExecutionResponse.getValue(SERVICE_RESPONSE);
		}

		logger.logError("Resutados:" + resultados);
		logger.logError("Resutados size:" + resultados.size());
		for (RuleProcess iterador : resultados) {
			logger.logError("Proceso->" + iterador.getId());
			for (VariableProcess iterador2 : iterador.getVariableProcesses()) {
				results.put(iterador2.getVariable().getNombreVariable(), iterador2.getValue());
				logger.logError("ResultadoVariable------>" + iterador2.getVariable().getNombreVariable());
				logger.logError("ResultadoValor---------> " + iterador2.getValue());

			}

		}

		return results;
	}

	@Override
	public TaskDTO getCurrentTask(String processInstanceId) throws COBISInfrastructureRuntimeException {
		if (logger.isDebugEnabled())
			logger.logInfo("Start getCurrentTask  for instance  " + processInstanceId);

		String serviceId = "HTM.API.HumanTask.GetTaskListCriteria";

		TaskListRequest taskListRequest = new TaskListRequest();
		taskListRequest.setInstProcess(Integer.valueOf(processInstanceId));
		taskListRequest.setGroupFilter("S");
		taskListRequest.setLastRecordId("0");

		Map<String, Object> serviceParameters = new HashMap<String, Object>(1);
		serviceParameters.put("inTaskListRequest", taskListRequest);

		ServiceResponseTO serviceResponseTO = executeServiceInCTS(serviceId, serviceParameters, SERVICE_RESPONSE);
		if (serviceResponseTO == null) {
			throw new COBISInfrastructureRuntimeException("Error al obtener la información de la Instancia de Proceso");
		} else {
			if (serviceResponseTO.isSuccess()) {
				TaskDTO[] taskDTO = (TaskDTO[]) serviceResponseTO.getValue("returnTaskDTO");
				return taskDTO[0];
			} else {
				MessageTO messageTO = (MessageTO) serviceResponseTO.getMessages().get(0);
				throw new COBISInfrastructureRuntimeException(messageTO.getMessage());
			}
		}

	}

	public java.util.Map executeRule(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.RuleExecution aRuleExecution) {

		// to include in code order use key:
		// cobiscloudorchestration.WorkflowServiceImpl.executeRule
		Map<String, String> variablesProcess = (Map<String, String>) aRuleExecution.getVariablesProcess();
		return applyRule(aRuleExecution.getAcronymRule(), variablesProcess);

	}

	@Override
	public Object executeCTSService(String serviceId, Map<String, Object> serviceRequestParameters, String serviceResponseParameterName) {
		return executeServiceInCTS(serviceId, serviceRequestParameters, serviceResponseParameterName);
	}

}
