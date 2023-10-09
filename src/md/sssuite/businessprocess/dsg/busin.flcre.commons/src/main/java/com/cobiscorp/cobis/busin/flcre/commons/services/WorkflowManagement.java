package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProcessRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProcessResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ClaimInfo;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.htm.api.dto.Requirement;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.htm.api.dto.UserDTO;
import cobiscorp.ecobis.workflow.dto.HierarchyRole;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;

public class WorkflowManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(WorkflowManagement.class);
	private int processID;

	MessageManagement messageManagement = new MessageManagement();

	public int getProcessID() {
		return processID;
	}

	public WorkflowManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public HierarchyRole[] getProcessInstance(HierarchyRole hierarchyRoleRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INHIERARCHYROLE, hierarchyRoleRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERYHIERARCHY, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ProcessInstance para ProcessId:" + hierarchyRoleRequest.getProcessId());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (HierarchyRole[]) serviceItemsResponseTO.getValue(ReturnName.RETURNHIERARCHYROLE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean startProcessInstance(ProcessDTO processDTO2, ICommonEventArgs arg1, BehaviorOption options) {
		this.processID = 0;
		String createProcessInstance = "HTM.API.HumanTask.CreateProcessInstance";// cob_workflow..sp_inicia_proceso_wf 73506,
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inProcessDTO", processDTO2);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, createProcessInstance, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ProcessInstance Creada Para ProcessId:" + processDTO2.getBussinessInformationStringTwo());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			@SuppressWarnings("unchecked")
			Map<String, String> processesResponse = (Map<String, String>) serviceItemsResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			this.processID = Integer.parseInt(processesResponse.get("@o_siguiente").toString());
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public Requirement[] getRequirements(int idTask, ICommonEventArgs arg1, BehaviorOption options) {

		TaskDTO taskDTO = new TaskDTO();
		UserDTO userDTO = new UserDTO();
		ClaimInfo claimInfo = new ClaimInfo();
		userDTO.setUserName("");
		taskDTO.setTaskInstanceIdentifier(String.valueOf(idTask)); // Instancia del proceso com tipo de dato String
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inTaskDTO", taskDTO);
		serviceRequestTO.getData().put("inUserDTO", userDTO);
		serviceRequestTO.getData().put("outClaimInfo", claimInfo);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "HTM.API.HumanTask.ClaimTask", serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Requirements para ProcessId:" + idTask);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (Requirement[]) serviceItemsResponseTO.getValue("returnRequirement");
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	/***
	 * Method for execute Rule
	 * 
	 * @param ruleAcronym
	 *            Rule's Acronym
	 * @param variables
	 *            Map with variable name and value
	 * @param arg1
	 *            ICommonEventArgs
	 * @param options
	 *            Behavior
	 * @return List of RuleProcess rule's result
	 * @throws Exception
	 */
	public List<RuleProcess> executeRule(String ruleAcronym, Map<String, Object> variables, ICommonEventArgs arg1, BehaviorOption options) throws Exception {
		if (logger.isDebugEnabled())
			logger.logDebug("Start executeRule in " + this.getClass().toString());

		RuleVersion ruleVersion = null;
		ServiceResponse serviceResponse = null;
		List<RuleVersion> ruleList = null;
		List<VariableProcess> listVariableProcess = null;
		HashMap<RuleVersion, List<VariableProcess>> values = null;
		Variable variable = null;
		VariableProcess variableProcess = null;
		@SuppressWarnings("rawtypes")
		Iterator iterator = null;
		@SuppressWarnings("rawtypes")
		Map.Entry element = null;

		if (logger.isDebugEnabled())
			logger.logDebug("Retrieving rule version with acronym " + ruleAcronym);

		serviceResponse = this.execute(getServiceIntegration(), logger, "Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym", new Object[] { ruleAcronym });

		if (serviceResponse != null && serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Retrieving rule version sucessfull");
			ruleList = (List<RuleVersion>) serviceResponse.getData();
			if (ruleList != null && !ruleList.isEmpty()) {
				if (logger.isDebugEnabled())
					logger.logDebug("Rule version " + ruleList.get(0));
				ruleVersion = ruleList.get(0);
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}

		if (ruleVersion != null) {
			// Creación de mapa con la regla y la lista de variables proceso
			values = new HashMap<RuleVersion, List<VariableProcess>>();
			listVariableProcess = new ArrayList<VariableProcess>();
			iterator = variables.entrySet().iterator();

			while (iterator.hasNext()) {
				element = (Map.Entry) iterator.next();
				variableProcess = new VariableProcess();
				variable = new Variable();
				// seteo nombre de la Variable
				variable.setNombreVariable((String) element.getKey());

				// seteo valor de la variable en la Variable Process
				variableProcess.setValue(String.valueOf(element.getValue()));
				// seteo variable en la Variable Process
				variableProcess.setVariable(variable);
				// agrego variable process a la lista de Variables Process
				listVariableProcess.add(variableProcess);

				if (logger.isDebugEnabled())
					logger.logDebug("Variable Process added: " + element.getKey() + " " + element.getValue());

			}

			values.put(ruleVersion, listVariableProcess);
			// Ejecucion del servicio
			// ServiceResponse serviceResponse = null;
			serviceResponse = this.execute(getServiceIntegration(), logger, "Bpl.Rules.Engine.RuleManager.Generate", new Object[] { values, 0, "", Integer.valueOf(SessionUtil.getRol()) });

			/*
			 * Donde: values: es le mapa creado 0: es el id del cliente cuando existen excepciones "": es el numero de la tarjeta de crédito cuando existen excepciones 3 : es el id del role que se logueo el usuario.
			 */

			if (serviceResponse != null && serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("Retrieving rule response with acronym " + ruleAcronym);
				return (List<RuleProcess>) serviceResponse.getData();
			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}
		}

		if (logger.isDebugEnabled())
			logger.logDebug("Retrieving rule response empty with acronym " + ruleAcronym);
		return new ArrayList<RuleProcess>();
	}

	public ProcessResponse getProcessLap(ProcessRequest processRequest, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("Inicio Servicio -> WorkflowManagement -> " + ServiceId.READPROCESSLAP);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INPROCESSREQUEST, processRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.READPROCESSLAP, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceValidateResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ProcessResponse) serviceValidateResponseTO.getValue(ReturnName.RETURNPROCESSRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			if (logger.isDebugEnabled())
				logger.logDebug("Error Servicio -> WorkflowManagement -> " + ServiceId.READPROCESSLAP);
		}
		return null;
	}

	public Variable getVariableByName(String name, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, "Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll", new Object[] {});
		if (serviceResponse != null && serviceResponse.isResult()) {
			List<Variable> variableList = (List<Variable>) serviceResponse.getData();
			if (variableList != null && !variableList.isEmpty()) {
				for (Variable variable : variableList) {
					if (variable.getNombreVariable().equals(name)) {
						return variable;
					}
				}
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean UpdateFieldFive(ApplicationRequest applicationRequest, IExecuteCommandEventArgs args) throws BusinessException {
		logger.logDebug("---Inicio servcio UpdateFieldFive");

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INAPPLICATIONREQUEST, applicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATE_FIEL_FIVE, serviceRequestTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));

		}
	}

}
