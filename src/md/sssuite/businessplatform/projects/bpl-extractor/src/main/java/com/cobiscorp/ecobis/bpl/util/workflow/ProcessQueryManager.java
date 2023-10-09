package com.cobiscorp.ecobis.bpl.util.workflow;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.extractor.repository.ProgramaRepository;
import com.cobiscorp.ecobis.bpl.extractor.repository.RuleRepository;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.rules.TaskViewService;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityObservationService;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityRequirementService;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.AddresseeService;
import com.cobiscorp.ecobis.bpl.service.workflow.ApprovalExceptionService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyItemService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyTypeTplService;
import com.cobiscorp.ecobis.bpl.service.workflow.InformationStepService;
import com.cobiscorp.ecobis.bpl.service.workflow.LinkConditionService;
import com.cobiscorp.ecobis.bpl.service.workflow.LinkService;
import com.cobiscorp.ecobis.bpl.service.workflow.MappingVariableProcessService;
import com.cobiscorp.ecobis.bpl.service.workflow.PolicyStepService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessActivityService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessTypeService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVersionService;
import com.cobiscorp.ecobis.bpl.service.workflow.ReceptorService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleService;
import com.cobiscorp.ecobis.bpl.service.workflow.StepService;
import com.cobiscorp.ecobis.bpl.service.workflow.UserService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.RuleQueryManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public class ProcessQueryManager {

	static Logger log = Logger.getLogger(ProcessQueryManager.class);

	public static List<ProcessVersion> prepareListToXml(List<ProcessVersion> processVersionList, ApplicationContext context) {

		// Recupero los servicios que se va a utilizar
		LinkService linkService = context.getBean(LinkService.class);
		ProcessVariableService processVariableService = context.getBean(ProcessVariableService.class);
		MappingVariableProcessService mappingVariableProcessService = context.getBean(MappingVariableProcessService.class);
		HierarchyService hierarchyService = context.getBean(HierarchyService.class);
		StepService stepService = context.getBean(StepService.class);
		PolicyStepService policyStepService = context.getBean(PolicyStepService.class);
		TaskViewService taskViewService = context.getBean(TaskViewService.class);
		ProcessActivityService processActivityService = context.getBean(ProcessActivityService.class);
		ActivityRequirementService activityRequirementService = context.getBean(ActivityRequirementService.class);
		ActivityResultService activityResultService = context.getBean(ActivityResultService.class);
		ActivityObservationService activityObservationService = context.getBean(ActivityObservationService.class);
		ReceptorService receptorService = context.getBean(ReceptorService.class);
		AddresseeService addresseeService = context.getBean(AddresseeService.class);
		HierarchyItemService hierarchyItemService = context.getBean(HierarchyItemService.class);
		RoleService roleService = context.getBean(RoleService.class);
		UserService userService = context.getBean(UserService.class);
		LinkConditionService linkConditionService = context.getBean(LinkConditionService.class);
		ProcessTypeService processTypeService = context.getBean(ProcessTypeService.class);
		InformationStepService informationStepService = context.getBean(InformationStepService.class);
		HierarchyTypeTplService hierarchyTypeTplService = context.getBean(HierarchyTypeTplService.class);
		ApprovalExceptionService approvalExceptionService = context.getBean(ApprovalExceptionService.class);

		ProgramaRepository programaRepository = context.getBean(ProgramaRepository.class);
		RuleRepository ruleRepository = context.getBean(RuleRepository.class);

		for (ProcessVersion processVersion : processVersionList) {

			String addressType = "";

			processVersion.setAddresseeList(new ArrayList<Addressee>());
			processVersion.setStepList(new ArrayList<Step>());

			log.debug("0)---------------------------->ProcessType");
			List<ProcessType> processTypeList = processTypeService.findByProcess(processVersion.getProcess().getIdProcess());
			processVersion.getProcess().setProcessTypeList(processTypeList);

			log.debug("1)---------------------------->Link");
			List<Link> linkList = linkService.findLinkByProcessVersion(processVersion.getIdProcessVersion().getIdProcess(), processVersion
					.getIdProcessVersion().getVersionProcess());
			for (Link link : linkList) {
				List<LinkCondition> linkConditionList = linkConditionService.findByLink(link.getIdLink());
				link.setLinkConditionList(linkConditionList);
			}
			processVersion.setLinkList(linkList);

			log.debug("2)---------------------------->ProcessVariable");
			List<ProcessVariable> processVariableList = processVariableService.findProcessVariableByProcessVersion(processVersion.getIdProcessVersion()
					.getIdProcess(), processVersion.getIdProcessVersion().getVersionProcess());
			processVersion.setProcessVariableList(processVariableList);

			log.debug("3)---------------------------->MappingVariableProcess");
			List<MappingVariableProcess> mappingVariableProcessList = mappingVariableProcessService.findMappingVariableProcessByProcessVersion(processVersion
					.getIdProcessVersion().getIdProcess(), processVersion.getIdProcessVersion().getVersionProcess());
			processVersion.setMappingVariableProcessList(mappingVariableProcessList);

			log.debug("5)-------------------------->ProcessActivity");
			List<ProcessActivity> processActivityList = processActivityService.findProcessActivityByProcessVersion(processVersion.getIdProcessVersion()
					.getIdProcess(), processVersion.getVersionProcess());
			processVersion.setProcessActivityList(processActivityList);

			log.debug("6)-------------------------->TaskView");
			List<TaskView> taskViewList = taskViewService.findTaskViewByProcessVersion(processVersion.getIdProcessVersion().getIdProcess(), processVersion
					.getIdProcessVersion().getVersionProcess());
			for (TaskView taskView : taskViewList) {
				log.debug("6.1------------------------------------------------->" + taskView.getComponent());
				log.debug("6.2------------------------------------------------->" + taskView.getIdTaskView());
			}
			processVersion.setTaskViewList(taskViewList);

			log.debug("7)-------------------------->Addressee");
			List<Addressee> addresseeList = addresseeService.findAddresseeByProcessVersion(processVersion.getIdProcessVersion().getIdProcess(), processVersion
					.getIdProcessVersion().getVersionProcess());

			log.debug("7.1)-------------------------->" + addresseeList.size());
			for (Addressee addressee : addresseeList) {

				log.debug("getTypeAddressee)-------------------------->" + addressee.getType());

				if (addressee.getType().equals("PRO")) {

					Programa programa = programaRepository.findOne(addressee.getIdAddressees().shortValue());
					addressee.setPrograma(programa);

				} else if (addressee.getType().equals("ROL")) {

					Role role = roleService.findById(addressee.getIdAddressees());
					addressee.setRole(role);

				} else if (addressee.getType().equals("JEU")) {
					HierarchyTypeTpl hierarchyTypeTpl = hierarchyTypeTplService.findById(addressee.getIdAddressees());
					addressee.setHierarchyTypeTpl(hierarchyTypeTpl);

				} else if (addressee.getType().equals("USR")) {

					User user = userService.findById(addressee.getIdAddressees());
					addressee.setUser(user);

				} else if (addressee.getType().equals("JER")) {
					addressType = "JER";
					Hierarchy hierarchy = hierarchyService.findById(addressee.getIdAddressees());
					hierarchy.setHierarchyRolList(null);
					hierarchy.setLinkRoleList(null);
					addressee.setHierarchy(hierarchy);

				} else if (addressee.getType().equals("COM")) {

					Role comite = roleService.findById(addressee.getIdAddressees());
					addressee.setComite(comite);

				} else if (addressee.getType().equals("POL")) {

					if (addressee.getIdAddressees() != 0) {
						Rule rule = ruleRepository.findOne(addressee.getIdAddressees());
						rule = RuleQueryManager.prepareRuleToXml(rule.getAcronym(), null, "P", context);
						addressee.setRule(rule);
					}

				}
				processVersion.getAddresseeList().add(addressee);
			}

			// Exporta la jerarquia de roles si tiene al menos un destinatario
			// con JER
			if (addressType.equals("JER")) {

				log.debug("4)---------------------------->Hierarchy" + processVersion.getIdProcessVersion().getIdProcess() + "-"
						+ processVersion.getIdProcessVersion().getVersionProcess());
				List<Hierarchy> hierarchyList = hierarchyService.findHierarchyByProcessVersion(processVersion.getIdProcessVersion().getIdProcess(),
						processVersion.getIdProcessVersion().getVersionProcess());
				processVersion.setHierarchyList(new ArrayList<Hierarchy>());

				for (Hierarchy hierarchy : hierarchyList) {
					Hierarchy newHierarchy = new Hierarchy();
					newHierarchy.setIdHierarchy(hierarchy.getIdHierarchy());
					newHierarchy.setIdProcess(hierarchy.getIdProcess());
					newHierarchy.setName(hierarchy.getName());
					newHierarchy.setVersion(hierarchy.getVersion());
					newHierarchy.setHierarchyRolList(new ArrayList<HierarchyRol>());
					newHierarchy.setLinkRoleList(new ArrayList<LinkRole>());
					newHierarchy.setHierarchyRolList(new ArrayList<HierarchyRol>());

					List<HierarchyRol> hierarchyRolList = hierarchy.getHierarchyRolList();
					for (HierarchyRol hierarchyRol : hierarchyRolList) {
						HierarchyRol newHierarchyRol = new HierarchyRol();
						newHierarchyRol.setIdHierarchyRol(hierarchyRol.getIdHierarchyRol());
						newHierarchyRol.setIdProcess(hierarchyRol.getIdProcess());
						newHierarchyRol.setManualAssigned(hierarchyRol.getManualAssigned());
						newHierarchyRol.setPositionX(hierarchyRol.getPositionX());
						newHierarchyRol.setPositionY(hierarchyRol.getPositionY());
						Role role = roleService.findById(hierarchyRol.getIdHierarchyRol().getIdRole());
						newHierarchyRol.setRole(role);
						newHierarchy.getHierarchyRolList().add(newHierarchyRol);
					}

					List<LinkRole> linkRoleList = hierarchy.getLinkRoleList();

					for (LinkRole linkRole : linkRoleList) {
						if (linkRole.getInitialRol() != null) {

							for (RoleType roleType : linkRole.getInitialRol().getRoleTypeList()) {
								roleType.setRole(null);
							}
							for (RoleUser roleUser : linkRole.getInitialRol().getRoleUserList()) {
								roleUser.setRole(null);
							}
						}
						if (linkRole.getFinalRol() != null) {
							for (RoleType roleType : linkRole.getFinalRol().getRoleTypeList()) {
								roleType.setRole(null);
							}
							for (RoleUser roleUser : linkRole.getFinalRol().getRoleUserList()) {
								roleUser.setRole(null);
							}
						}
						LinkRole newLinkRole = new LinkRole();
						newLinkRole.setCondition(replaceExpression(linkRole.getCondition(), context));
						newLinkRole.setFinalRol(linkRole.getFinalRol());
						newLinkRole.setInitialRol(linkRole.getInitialRol());
						newLinkRole.setIdFinalRol(linkRole.getIdFinalRol());
						newLinkRole.setIdInitialRol(linkRole.getIdInitialRol());
						newLinkRole.setInstException(linkRole.getInstException());
						newLinkRole.setLinkPoints(linkRole.getLinkPoints());
						newLinkRole.setName(linkRole.getName());
						newLinkRole.setPriority(linkRole.getPriority());
						newLinkRole.setVersionProcess(linkRole.getVersionProcess());
						newHierarchy.getLinkRoleList().add(newLinkRole);
					}
					processVersion.getHierarchyList().add(newHierarchy);

				}

			}

			log.debug("8)---------------------------->Step" + processVersion.getIdProcessVersion().getVersionProcess());
			List<Step> stepList = stepService.findStepByProcessVersion(processVersion.getIdProcessVersion().getIdProcess(), (short) processVersion
					.getIdProcessVersion().getVersionProcess());

			for (Step step : stepList) {

				log.debug("8.1)-------------------------->InformationStep");
				List<InformationStep> informationStepList = informationStepService.findByLink(step.getIdStep());
				step.setInformationStepList(informationStepList);

				log.debug("8.2)-------------------------->PolicyStep");
				List<PolicyStep> policyStepList = policyStepService.findPolicyStepByStep(step.getIdStep());
				List<PolicyStep> newPolicyStepList = new ArrayList<PolicyStep>();
				for (PolicyStep policyStep : policyStepList) {

					if (policyStep.getRule() != null) {
						PolicyStep newPolicyStep = new PolicyStep();
						Rule newRule = RuleQueryManager.prepareRuleToXml(policyStep.getRule().getAcronym(), null, "P", context);
						newPolicyStep.setRule(newRule);
						newPolicyStepList.add(newPolicyStep);
					}

				}
				step.setPolicyStepList(newPolicyStepList);

				log.debug("8.3)-------------------------->ActivityRequirement");
				List<ActivityRequirement> activityRequirementList = activityRequirementService.findActivityRequirementByStep(step.getIdStep());

				for (ActivityRequirement activityRequirement : activityRequirementList) {

					if (activityRequirement.getRule() != null) {
						Rule newRule = RuleQueryManager.prepareRuleToXml(null, activityRequirement.getIdRule(), "R", context);
						if (newRule == null) {
							activityRequirement.setIdRule(newRule.getId());
						} else {
							activityRequirement.setIdRule(0);
						}
						activityRequirement.setRule(newRule);
						log.debug("getRuleDescription-------------------->" + activityRequirement.getRule().getName());
					}

				}
				step.setActivityRequirementList(activityRequirementList);

				log.debug("8.3.1)-------------------------->ApprovalException");
				List<ApprovalException> approvalExceptions = new ArrayList<ApprovalException>();
				approvalExceptions = approvalExceptionService.findByStep(step.getIdStep());

				if (approvalExceptions != null && approvalExceptions.size() > 0) {
					for (ApprovalException approvalException : approvalExceptions) {

						log.debug("8.3.1)-------------------------->ApprovalException-->" + approvalException.getExceptionType());
						
						if (approvalException.getExceptionType().trim().equalsIgnoreCase("P")) {

							Rule rule = RuleQueryManager.prepareRuleToXml(null, approvalException.getIdPolicyOrDocument(), "R", context);
							approvalException.setRule(rule);
							
							log.debug("8.3.1)Rule-------------------------->" + rule.getAcronym());
							
						} else if (approvalException.getExceptionType().trim().equalsIgnoreCase("D")) {

							DocumentType docType = approvalExceptionService.findDocumentTypeById(approvalException.getIdPolicyOrDocument());
							approvalException.setDocType(docType);
							
							log.debug("8.3.1)docType-------------------------->" + docType.getDocumentType() + "-" + docType.getDocumentTypeName());

						}
					}
					step.setApprovalException(approvalExceptions);
				}

				log.debug("8.4)-------------------------->ActivityResult");
				List<ActivityResult> activityResultList = activityResultService.findActivityResultByIdStep(step.getIdStep());
				step.setActivityResultList(activityResultList);

				log.debug("8.5)-------------------------->ActivityObservation");
				List<ActivityObservation> activityObservationList = activityObservationService.findActivityObservationByStep(step.getIdStep());
				step.setActivityObservationList(activityObservationList);

				log.debug("8.6)-------------------------->Receptor");
				List<Receptor> receptorList = receptorService.findReceptorByStep(step.getIdStep());
				step.setReceptorList(receptorList);

				log.debug("8.9)-------------------------->Hierarchy");
				List<HierarchyItem> hierarchyItemList = hierarchyItemService.findByHierarchyItemStep(step.getIdStep());
				step.setHierarchyItemList(hierarchyItemList);

				log.debug("8.10------------------------->" + processVersion.getAddresseeList().size());

				processVersion.getStepList().add(step);
			}

		}

		return processVersionList;

	}

	public static void saveListToBdd(List<ProcessVersion> processVersionList, ApplicationContext context, DriverManagerDataSource dataSource) throws Exception {

		try {

			ProcessService processService = context.getBean(ProcessService.class);
			LinkService linkService = context.getBean(LinkService.class);
			AddresseeService addresseeService = context.getBean(AddresseeService.class);
			ProcessVersionService processVersionService = context.getBean(ProcessVersionService.class);

			for (ProcessVersion processVersion : processVersionList) {
				Process process = processService.findAndSave(processVersion, context, dataSource);
				ProcessVersion searchedProcessVersion = processVersionService.findLastVesionProcess(process.getIdProcess());
				linkService.saveLink(process, processVersion, searchedProcessVersion, dataSource);
				addresseeService.updateAddress(process, processVersion, searchedProcessVersion);
			}

		} catch (Exception e) {
			log.error("Error al ejecutar el metodo saveListToBdd", e);
			throw new Exception(e);
		}

	}

	public static void deleteProcessVersion(List<ProcessVersion> processVersionList, ApplicationContext context, DriverManagerDataSource dataSource) {

		// Declaro los servicios
		ProcessService processService = context.getBean(ProcessService.class);
		ProcessVersionService processVersionService = context.getBean(ProcessVersionService.class);

		// Recorro la lista de process version
		for (ProcessVersion processVersion : processVersionList) {

			// Busco el process en base al nombre
			Process process = processService.findByName(processVersion.getProcess().getName());

			// Si es diferente de nulo
			if (process != null) {

				// Busco la ultima version y si esta enconstruccion la elimina
				ProcessVersion findProcessVersion = processVersionService.findLastVesionProcess(process.getIdProcess());
				if (findProcessVersion != null && findProcessVersion.getStatus().equals("CON")) {
					ProcessVersionProcedureManager processVersionProcedureManager = new ProcessVersionProcedureManager(dataSource);
					processVersionProcedureManager.execute(findProcessVersion.getProcess().getIdProcess(), findProcessVersion.getVersionProcess(), 'D');
				}
			}
		}
	}

	@SuppressWarnings("unused")
	private static String replaceExpression(String expression, ApplicationContext context) {

		VariableService variableService = context.getBean(VariableService.class);
		ResultService resultService = context.getBean(ResultService.class);

		log.debug("Expression a ser modificada----->" + expression);

		// Declaro variables a utilizar
		String expressionModified = "";
		String expressionTemp = "";
		String expressionEvaluated = new String(expression);
		String beforeValue = "";

		for (int i = 0; i < expressionEvaluated.length(); i++) {
			String valueExpression = "";
			String caracter = String.valueOf(expressionEvaluated.charAt(i)).trim();

			if (caracter.equals("#")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("#"));
				i = expressionTemp.indexOf("#") + i + 1;

				log.debug("valueExpression----->" + valueExpression);

				Variable variable = variableService.findById(new Short("" + valueExpression));
				if (variable != null) {
					expressionModified = expressionModified + "#" + variable.getAbreviaturaVariable().trim() + "#";
				}

			} else if (caracter.equals("%")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("%"));
				i = expressionTemp.indexOf("%") + i + 1;

				log.debug("valueExpression----->" + valueExpression);
				Result result = resultService.findById(Integer.valueOf(valueExpression));
				if (result != null) {
					expressionModified = expressionModified + "%" + result.getName().trim() + "%";
				}

			} else {

				expressionModified = expressionModified + caracter;

				log.debug("expressionModified---------------->" + expressionModified);

			}
			beforeValue = caracter;
		}

		return expressionModified;
	}

}
