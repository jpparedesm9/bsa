package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Catalog;
import com.cobiscorp.ecobis.bpl.dao.cobis.CatalogDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityObservationDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityRequirementDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityResultDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ApprovalExceptionDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemTplDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.PolicyStepDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.RequirementDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ResultDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.StepDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.rules.RuleService;
import com.cobiscorp.ecobis.bpl.service.workflow.ApprovalExceptionService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.StepService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.RuleQueryManager;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalExceptionPK;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItemTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdActivityObservation;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdActivityRequirement;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdActivityResult;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdHierarchyItem;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdPolicyStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Requirement;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class StepServiceImpl implements StepService {

	static Logger log = Logger.getLogger(StepServiceImpl.class);

	private StepDao stepDao;
	private ResultDao resultDao;
	private RequirementDao requirementDao;
	private ActivityResultDao activityResultDao;
	private ActivityRequirementDao activityRequirementDao;
	private ActivityObservationDao activityObservationDao;
	private ActivityDao activityDao;
	private PolicyStepDao policyStepDao;
	private CatalogDao catalogDao;
	private HierarchyItemTplDao hierarchyItemTplDao;
	private RuleService ruleService;
	private VariableService variableService;
	private ResultService resultService;
	private ApprovalExceptionDao approvalExceptionDao;

	/**
	 * @return the stepDao
	 */
	public StepDao getStepDao() {
		return stepDao;
	}

	/**
	 * @param stepDao
	 *            the stepDao to set
	 */
	public void setStepDao(StepDao stepDao) {
		this.stepDao = stepDao;
	}

	public ResultDao getResultDao() {
		return resultDao;
	}

	public void setResultDao(ResultDao resultDao) {
		this.resultDao = resultDao;
	}

	public ActivityResultDao getActivityResultDao() {
		return activityResultDao;
	}

	public void setActivityResultDao(ActivityResultDao activityResultDao) {
		this.activityResultDao = activityResultDao;
	}

	public RequirementDao getRequirementDao() {
		return requirementDao;
	}

	public void setRequirementDao(RequirementDao requirementDao) {
		this.requirementDao = requirementDao;
	}

	public ActivityRequirementDao getActivityRequirementDao() {
		return activityRequirementDao;
	}

	public void setActivityRequirementDao(ActivityRequirementDao activityRequirementDao) {
		this.activityRequirementDao = activityRequirementDao;
	}

	public ActivityObservationDao getActivityObservationDao() {
		return activityObservationDao;
	}

	public void setActivityObservationDao(ActivityObservationDao activityObservationDao) {
		this.activityObservationDao = activityObservationDao;
	}

	public PolicyStepDao getPolicyStepDao() {
		return policyStepDao;
	}

	public void setPolicyStepDao(PolicyStepDao policyStepDao) {
		this.policyStepDao = policyStepDao;
	}

	public CatalogDao getCatalogDao() {
		return catalogDao;
	}

	public void setCatalogDao(CatalogDao catalogDao) {
		this.catalogDao = catalogDao;
	}

	/**
	 * @return the variableService
	 */
	public VariableService getVariableService() {
		return variableService;
	}

	/**
	 * @param variableService
	 *            the variableService to set
	 */
	public void setVariableService(VariableService variableService) {
		this.variableService = variableService;
	}

	/**
	 * @return the resultService
	 */
	public ResultService getResultService() {
		return resultService;
	}

	/**
	 * @param resultService
	 *            the resultService to set
	 */
	public void setResultService(ResultService resultService) {
		this.resultService = resultService;
	}

	/**
	 * @return the hierarchyItemTplDao
	 */
	public HierarchyItemTplDao getHierarchyItemTplDao() {
		return hierarchyItemTplDao;
	}

	/**
	 * @param hierarchyItemTplDao
	 *            the hierarchyItemTplDao to set
	 */
	public void setHierarchyItemTplDao(HierarchyItemTplDao hierarchyItemTplDao) {
		this.hierarchyItemTplDao = hierarchyItemTplDao;
	}

	/**
	 * @return the ruleService
	 */
	public RuleService getRuleService() {
		return ruleService;
	}

	/**
	 * @param ruleService
	 *            the ruleService to set
	 */
	public void setRuleService(RuleService ruleService) {
		this.ruleService = ruleService;
	}

	public List<Step> findStepByProcessVersion(Integer idProcess, Short version) {

		List<Step> stepList = new ArrayList<Step>();
		for (Step step : stepDao.findStepByProcessVersion(idProcess, version)) {

			log.debug("Step_1---------------------->" + step.getIdStep());

			Step stepNew = new Step();
			stepNew.setIdStep(step.getIdStep());
			stepNew.setActivity(step.getActivity());
			stepNew.setActivityObservationList(new ArrayList<ActivityObservation>());
			stepNew.setActivityRequirementList(new ArrayList<ActivityRequirement>());
			stepNew.setActivityResultList(new ArrayList<ActivityResult>());
			stepNew.setAutomatic(step.getAutomatic());
			stepNew.setHeight(step.getHeight());
			stepNew.setHierarchyItemList(new ArrayList<HierarchyItem>());
			stepNew.setIdProcess(step.getIdProcess());
			stepNew.setInformationStepList(new ArrayList<InformationStep>());
			stepNew.setPositionX(step.getPositionX());
			stepNew.setPositionY(step.getPositionY());
			stepNew.setProcessVersion(step.getProcessVersion());
			stepNew.setProgramStandarTime(step.getProgramStandarTime());
			stepNew.setReceptorList(new ArrayList<Receptor>());
			stepNew.setType(step.getType());
			stepNew.setVersion(step.getVersion());
			stepNew.setWidth(step.getWidth());
			stepNew.setPolicyStepList(new ArrayList<PolicyStep>());

			stepList.add(stepNew);

		}
		return stepList;
	}

	public void findStepByProcessVersionAndActivity() {
	}

	public Step saveStep(Step step, Step newStep, ProcessVersion processVersion, ApplicationContext context, DriverManagerDataSource dataSource)
			throws Exception {
		try {

			SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

			log.debug("ApprovalExceptionB--------------------------------------------> " + newStep.getIdStep());
			newStep.setIdStep(seqnos.execute("wf_paso"));

			Activity activity = step.getActivity();
			activity = activityDao.findAndSaveActivity(activity, dataSource);
			newStep.setActivity(null);
			newStep.setTrActivity(activity);
			newStep.setIdActivity(activity.getIdActivity());
			newStep.setAutomatic(step.getAutomatic());
			newStep.setHeight(step.getHeight());
			newStep.setPositionX(step.getPositionX());
			newStep.setPositionY(step.getPositionY());
			newStep.setProgramStandarTime(step.getProgramStandarTime());
			newStep.setType(step.getType());
			newStep.setWidth(step.getWidth());

			log.debug("ApprovalException--------------------------------------------> " + newStep.getIdStep() + "-AE-" + step.getApprovalException().size());

			List<ApprovalException> approvalExceptions = new ArrayList<ApprovalException>();

			for (ApprovalException approvalException : step.getApprovalException()) {

				if (!step.getType().equals("INI") && !step.getType().equals("FIN")) {
					ApprovalException appExec = new ApprovalException();
					log.debug("ApprovalException DENTRO--------------------------------------------> " + step.getType());
					appExec.setIdPolicyOrDocument(approvalException.getIdPolicyOrDocument());
					appExec.setIdStep(newStep.getIdStep());
					appExec.setExceptionType(approvalException.getExceptionType());

					// guardado de reglas
					if (approvalException.getExceptionType().trim().equalsIgnoreCase("P")) {

						log.debug("Exception Type -------------------------------------------->" + approvalException.getExceptionType());

						Rule rule = approvalException.getRule();
						if (rule != null) {
							log.debug("Guardado de rule-------------------------------------------->" + rule.getId());
							rule = RuleQueryManager.saveRuleBdd(rule, context, dataSource);
							log.debug("Guardado de rule A-------------------------------------------->" + rule.getId());
							appExec.setIdPolicyOrDocument(rule.getId());
						}
					} else if (approvalException.getExceptionType().trim().equalsIgnoreCase("D")) {

						log.debug("Exception Type -------------------------------------------->" + approvalException.getExceptionType());

						DocumentType docType = approvalException.getDocType();
						if (docType != null) {
							log.debug("Guardado de DocumentType-------------------------------------------->" + docType.getIdDocumentType());
							DocumentType tmpDocType = null;
							tmpDocType = approvalExceptionDao.findDocumentTypeByName(docType.getDocumentTypeName());

							if (tmpDocType == null) {
								log.debug("DocType ---------------------->" + docType.getDocCategory() + "-" + docType.getDocumentType() + "-"
										+ docType.getDocumentTypeName() + "-" + docType.getDocValidity() + "-" + docType.getIdDocumentType());
								docType.setIdDocumentType(seqnos.execute("wf_tipo_documento"));
								tmpDocType = approvalExceptionDao.saveDocumentType(docType);

								log.debug("Guardado de DocumentType A-------------------------------------------->" + tmpDocType.getIdDocumentType());
							}
							appExec.setIdPolicyOrDocument(tmpDocType.getIdDocumentType());
						}
					}

					appExec.setApprovalExceptionPK(new ApprovalExceptionPK(newStep.getIdStep(), appExec.getIdPolicyOrDocument(), approvalException
							.getExceptionType()));
					approvalExceptions.add(appExec);
				}
			}
			newStep.setApprovalException(approvalExceptions);

			// guardar las reglas

			log.debug("ActivityResult-------------------------------------------->");
			List<ActivityResult> activityResultList = step.getActivityResultList();
			List<ActivityResult> newActivityResultList = new ArrayList<ActivityResult>();
			for (ActivityResult activityResult : activityResultList) {
				log.debug("ActivityResult" + activityResult);
				Result result = activityResult.getResult();
				if (result != null) {
					result = resultDao.findAndSave(result, dataSource);
					log.debug("Result: " + result.getIdResult() + "-" + result.getName());
					ActivityResult newActivityResult = new ActivityResult();
					newActivityResult.setIdProcess(newStep.getProcessVersion().getProcess().getIdProcess());
					newActivityResult.setVersionProcess(newStep.getProcessVersion().getVersionProcess());
					newActivityResult.setResult(null);
					newActivityResult.setStep(null);
					newActivityResult.setIdActivityResult(new IdActivityResult(result.getIdResult(), newStep.getIdStep()));
					newActivityResultList.add(newActivityResult);
				}
			}
			newStep.setActivityResultList(newActivityResultList);

			log.debug("ActivityRequirement-------------------------------------------->");
			List<ActivityRequirement> activityRequirementList = step.getActivityRequirementList();
			List<ActivityRequirement> newActivityRequirementList = new ArrayList<ActivityRequirement>();
			for (ActivityRequirement activityRequirement : activityRequirementList) {
				log.debug("ActivityRequirement" + activityRequirement);
				Requirement requirement = activityRequirement.getRequirement();
				if (requirement != null) {
					requirement = requirementDao.findAndSave(requirement, dataSource);
					log.debug("Requirement: " + requirement.getIdRequirement() + "-" + requirement.getName());
					ActivityRequirement newActivityRequirement = new ActivityRequirement();
					newActivityRequirement.setRequirement(null);
					newActivityRequirement.setMandatory(activityRequirement.getMandatory());
					newActivityRequirement.setReference(activityRequirement.getReference());
					newActivityRequirement.setRuleDescription(activityRequirement.getRuleDescription());
					newActivityRequirement.setText(activityRequirement.getText());
					newActivityRequirement.setStep(null);
					newActivityRequirement.setExcepcionable(activityRequirement.getExcepcionable() == null ? 0 : activityRequirement.getExcepcionable());
					Rule rule = activityRequirement.getRule();

					if (rule == null) {
						newActivityRequirement.setIdRule(0);
					} else {
						rule = RuleQueryManager.saveRuleBdd(rule, context, dataSource);
						newActivityRequirement.setIdRule(rule.getId());
						log.debug("Rule: " + rule.getId() + "-" + rule.getAcronym());
					}

					newActivityRequirement.setRule(rule);
					newActivityRequirement.setIdRequirementActivity(new IdActivityRequirement(requirement.getIdRequirement(), newStep.getIdStep()));
					log.debug("ActivityRequirement:" + activityRequirement.getIdRequirementActivity());
					newActivityRequirementList.add(newActivityRequirement);

				}

			}
			newStep.setActivityRequirementList(newActivityRequirementList);

			log.debug("ActivityObservation-------------------------------------------->");
			List<ActivityObservation> activityObservationList = step.getActivityObservationList();
			List<ActivityObservation> newActivityObservationList = new ArrayList<ActivityObservation>();
			for (ActivityObservation activityObservation : activityObservationList) {
				Catalog catalog = activityObservation.getCatalog();

				if (catalog != null) {
					catalog = catalogDao.findAndSave(catalog);
					ActivityObservation newActivityObservation = new ActivityObservation();
					log.debug("Catalog: " + catalog.getCodigo() + "-" + catalog.getValue());
					newActivityObservation.setCatalog(null);
					newActivityObservation.setStep(null);
					newActivityObservation.setIdActivityObservation(new IdActivityObservation(newStep.getIdStep(), catalog.getCodigo()));
					newActivityObservationList.add(newActivityObservation);
				}

			}
			newStep.setActivityObservationList(newActivityObservationList);

			log.debug("PolicyStep-------------------------------------------->");
			List<PolicyStep> policyStepList = step.getPolicyStepList();
			List<PolicyStep> newPolicyStepList = new ArrayList<PolicyStep>();
			for (PolicyStep policyStep : policyStepList) {
				Rule policy = policyStep.getRule();
				if (policy != null) {
					log.debug("PolicyStep-------------------------------------------->1");
					policy = RuleQueryManager.saveRuleBdd(policy, context, dataSource);
					// policy = ruleService.findAndSave(policy, context,
					// dataSource);
					log.debug("PolicyStep-------------------------------------------->2");
					log.debug("Policy: " + policy.getId() + "-" + policy.getAcronym());
					PolicyStep newPolicyStep = new PolicyStep();
					newPolicyStep.setRule(null);
					newPolicyStep.setStep(null);
					newPolicyStep.setIdPolicyStep(new IdPolicyStep(policy.getId(), newStep.getIdStep()));
					newPolicyStepList.add(newPolicyStep);
					log.debug("PolicyStep-------------------------------------------->3");
				}
			}
			log.debug("PolicyStep-------------------------------------------->4");
			newStep.setPolicyStepList(newPolicyStepList);

			List<HierarchyItem> hierarchyItemList = step.getHierarchyItemList();
			List<HierarchyItem> newHierarchyItemList = new ArrayList<HierarchyItem>();
			if (hierarchyItemList != null) {
				for (HierarchyItem hierarchyItem : hierarchyItemList) {

					log.debug("hierarchyItem_1---------------------------------------->" + hierarchyItem.getHierarchyItemTpl().getHierarchyTypeTpl().getName());

					log.debug("hierarchyItem_2---------------------------------------->" + hierarchyItem.getHierarchyItemTpl().getDescription());

					HierarchyItemTpl hierarchyItemTpl = hierarchyItemTplDao.findByHierarchyTypeTplAndHierarchyItemTpl(hierarchyItem.getHierarchyItemTpl()
							.getHierarchyTypeTpl().getName(), hierarchyItem.getHierarchyItemTpl().getDescription());

					log.debug("hierarchyItem_3---------------------------------------->" + hierarchyItemTpl);

					if (hierarchyItemTpl != null) {
						HierarchyItem hierarchyItemNew = new HierarchyItem();
						hierarchyItemNew.setIdHierarchyItem(new IdHierarchyItem(hierarchyItemTpl.getIdHierarchyItemTpl(), newStep.getIdStep()));
						log.debug("hierarchyItem_5---------------------------------------->" + hierarchyItemNew.getIdHierarchyItem().getIdHierarchyItemTpl());
						hierarchyItemNew.setIjCondiciones(replaceExpression(hierarchyItem.getIjCondiciones()));
						hierarchyItemNew.setStep(newStep);
						hierarchyItemNew.setHierarchyItemTpl(hierarchyItemTpl);
						log.debug("hierarchyItem_7---------------------------------------->" + hierarchyItemNew.getIdHierarchyItem().getIdHierarchyItemTpl());
						newHierarchyItemList.add(hierarchyItemNew);
					}
				}
				log.debug("hierarchyItem_4---------------------------------------->");
				newStep.setHierarchyItemList(newHierarchyItemList);
			}

			log.debug("-------------------------------------------->5");
			// newStep = stepDao.saveStep(newStep);
			for (Link link : processVersion.getLinkList()) {
				if (link.getFinalStep().getIdStep().equals(step.getIdStep())) {
					log.debug("1_getFinalStep----------------------------->" + link.getFinalStep().getIdStep());
					link.setFinalStep(newStep);
					log.debug("2_getFinalStep----------------------------->" + link.getFinalStep().getIdStep());
				}
				if (link.getInitialStep().getIdStep().equals(step.getIdStep())) {
					link.setInitialStep(newStep);
				}
			}
			hmStepNew.put(newStep.getIdStep(), newStep);
			hmStep.put(newStep.getIdProcess() + "-" + newStep.getVersion() + "-" + newStep.getTrActivity().getName(), newStep);

		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo saveStep:", ex);
			throw ex;
		}
		return newStep;
	}

	public Step findByProcessVersionAndActivity(Integer idProcess, Short version, String activityName) throws Exception {
		return stepDao.findByProcessVersionAndActivity(idProcess, version, activityName);
	}

	public ActivityDao getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	public ApprovalExceptionDao getApprovalExceptionDao() {
		return approvalExceptionDao;
	}

	public void setApprovalExceptionDao(ApprovalExceptionDao approvalExceptionDao) {
		this.approvalExceptionDao = approvalExceptionDao;
	}

	@SuppressWarnings("unused")
	private String replaceExpression(String expression) throws Exception {

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

				Variable variable = variableService.findByAbreviaturaVariable(valueExpression);
				if (variable != null) {
					expressionModified = expressionModified + "#" + variable.getCodigoVariable() + "#";
				}

			} else if (caracter.equals("%")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("%"));
				i = expressionTemp.indexOf("%") + i + 1;

				log.debug("valueExpression----->" + valueExpression);
				Result result = resultService.findResultByName(valueExpression);
				if (result != null) {
					expressionModified = expressionModified + "%" + result.getIdResult() + "%";
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
