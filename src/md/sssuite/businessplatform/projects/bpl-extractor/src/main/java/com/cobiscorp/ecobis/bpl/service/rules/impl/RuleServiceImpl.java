package com.cobiscorp.ecobis.bpl.service.rules.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.rules.ConditionRuleDao;
import com.cobiscorp.ecobis.bpl.dao.rules.RuleDao;
import com.cobiscorp.ecobis.bpl.dao.rules.RuleVersionDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.ConditionRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.rules.RuleService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.IRuleExceptionAdmManager;
import com.cobiscorp.ecobis.bpl.util.ISubTypeRuleAdmManager;
import com.cobiscorp.ecobis.bpl.util.ISystemRuleAdmManager;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;

public class RuleServiceImpl implements RuleService {

	private RuleDao ruleDao;
	private RuleVersionDao ruleVersionDao;
	private ConditionRuleDao conditionRuleDao;
	private ISystemRuleAdmManager systemRuleAdmManager;
	private ISubTypeRuleAdmManager subTypeRuleAdmManager;
	private IRuleExceptionAdmManager ruleExceptionManager;
	private VariableService variableService;

	static Logger log = Logger.getLogger(RuleServiceImpl.class);

	/**
	 * @return the ruleDao
	 */
	public RuleDao getRuleDao() {
		return ruleDao;
	}

	/**
	 * @param ruleDao
	 *            the ruleDao to set
	 */
	public void setRuleDao(RuleDao ruleDao) {
		this.ruleDao = ruleDao;
	}

	/**
	 * @return the ruleVersionDao
	 */
	public RuleVersionDao getRuleVersionDao() {
		return ruleVersionDao;
	}

	/**
	 * @param ruleVersionDao
	 *            the ruleVersionDao to set
	 */
	public void setRuleVersionDao(RuleVersionDao ruleVersionDao) {
		this.ruleVersionDao = ruleVersionDao;
	}

	/**
	 * @return the conditionRuleDao
	 */
	public ConditionRuleDao getConditionRuleDao() {
		return conditionRuleDao;
	}

	/**
	 * @param conditionRuleDao
	 *            the conditionRuleDao to set
	 */
	public void setConditionRuleDao(ConditionRuleDao conditionRuleDao) {
		this.conditionRuleDao = conditionRuleDao;
	}

	/**
	 * @return the systemRuleAdmManager
	 */
	public ISystemRuleAdmManager getSystemRuleAdmManager() {
		return systemRuleAdmManager;
	}

	/**
	 * @param systemRuleAdmManager
	 *            the systemRuleAdmManager to set
	 */
	public void setSystemRuleAdmManager(ISystemRuleAdmManager systemRuleAdmManager) {
		this.systemRuleAdmManager = systemRuleAdmManager;
	}

	/**
	 * @return the subTypeRuleAdmManager
	 */
	public ISubTypeRuleAdmManager getSubTypeRuleAdmManager() {
		return subTypeRuleAdmManager;
	}

	/**
	 * @param subTypeRuleAdmManager
	 *            the subTypeRuleAdmManager to set
	 */
	public void setSubTypeRuleAdmManager(ISubTypeRuleAdmManager subTypeRuleAdmManager) {
		this.subTypeRuleAdmManager = subTypeRuleAdmManager;
	}

	/**
	 * @return the ruleExceptionManager
	 */
	public IRuleExceptionAdmManager getRuleExceptionManager() {
		return ruleExceptionManager;
	}

	/**
	 * @param ruleExceptionManager
	 *            the ruleExceptionManager to set
	 */
	public void setRuleExceptionManager(IRuleExceptionAdmManager ruleExceptionManager) {
		this.ruleExceptionManager = ruleExceptionManager;
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

	public Rule findAndSave(Rule rule, ApplicationContext context, DriverManagerDataSource dataSource) {

		// Guarda los sistemas
		systemRuleAdmManager.findAndSaveSystemRule(rule.getSystemRule(), dataSource);

		// Guarda los subtipos
		for (SubTypeRule subTypeRule : rule.getSubType()) {
			subTypeRuleAdmManager.findAndSaveSubTypeRule(subTypeRule, dataSource);
		}

		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
		Map<Integer, ConditionRule> conditionParentMap = new HashMap<Integer, ConditionRule>();
		Rule ruleNew = ruleDao.findByAcronym(rule.getName());
		RuleVersion ruleVersionSearch = null;
		List<RuleException> ruleExceptionList = new ArrayList<RuleException>();
		boolean isNuevo = false;

		if (ruleNew != null) {
			ruleVersionSearch = ruleVersionDao.findLastVesionProcess(rule.getId());
			if (ruleVersionSearch != null && ruleVersionSearch.getStatus().equals("DIS")) {
				for (ConditionRule conditionRule : conditionRuleDao.findByRuleVersion(ruleVersionSearch.getId())) {
					conditionRuleDao.delete(conditionRule);
				}
				ruleVersionDao.delete(ruleVersionSearch);
			} else if (ruleVersionSearch != null && ruleVersionSearch.getStatus().equals("PRD")) {
				ruleVersionSearch.setStatus("ANT");
				if (ruleVersionSearch.getDateFinish().compareTo(Calendar.getInstance()) > 0) {
					ruleVersionSearch.setDateFinish(Calendar.getInstance());
				}
				ruleVersionDao.update(ruleVersionSearch);
			}
		} else {

			isNuevo = true;
			ruleNew = new Rule();
			ruleNew.setId(seqnos.execute("bpl_rule"));
			ruleNew.setAcronym(rule.getAcronym());
			ruleNew.setName(rule.getName());
			ruleNew.setType(rule.getType());
			ruleNew.setSystemRule(rule.getSystemRule());
			ruleNew.setSystemRuleId(rule.getSystemRuleId());
			ruleNew.setSubTypeId(rule.getSubTypeId());
			ruleNew.setSubType(rule.getSubType());
			ruleNew.setRuleVersions(new ArrayList<RuleVersion>());

		}

		for (RuleVersion ruleVersion : rule.getRuleVersions()) {
			RuleVersion ruleVersionNew = new RuleVersion();
			ruleVersionNew.setDateFinish(ruleVersion.getDateFinish());
			ruleVersionNew.setDateStart(Calendar.getInstance());
			ruleVersionNew.setId(seqnos.execute("bpl_rule_version"));
			ruleVersionNew.setRule(ruleNew);
			ruleVersionNew.setStatus(ruleVersion.getStatus());
			ruleVersionNew.setConditionRules(new ArrayList<ConditionRule>());

			if (ruleVersionSearch == null) {
				ruleVersionNew.setVersion(1);
			} else {
				if (ruleVersionSearch.getStatus().equals("DIS")) {
					ruleVersionNew.setVersion(ruleVersionSearch.getVersion());
					log.debug("DIS_ruleVersionNew---------------------------------------->"+ruleVersionNew.getVersion());
				} else {
					ruleVersionNew.setVersion(ruleVersionSearch.getVersion() + 1);
					log.debug("PRO_ruleVersionNew---------------------------------------->"+ruleVersionNew.getVersion());
				}
			}

			for (ConditionRule conditionRule : ruleVersion.getConditionRules()) {

				log.info("Se procede a importar la condici\u00F3n: " + conditionRule.getVariable().getAbreviaturaVariable()
						+ conditionRule.getOperador() + conditionRule.getMinValue() + " " + conditionRule.getMaxValue());

				ConditionRule conditionRuleNew;

				if (!conditionParentMap.containsKey(conditionRule.getId())) {
					conditionRuleNew = new ConditionRule();
					conditionRuleNew.setIsLastSon(conditionRule.getIsLastSon());
					conditionRuleNew.setMaxValue(conditionRule.getMaxValue());
					conditionRuleNew.setMinValue(conditionRule.getMinValue());
					conditionRuleNew.setOperador(conditionRule.getOperador());
					conditionRuleNew.setIdResult(conditionRule.getIdResult());
					conditionRuleNew.setRulesVersion(ruleVersionNew);
				} else {
					conditionRuleNew = conditionParentMap.get(conditionRule.getId());
				}
				if (!conditionRuleNew.getIsLastSon()) {
					if (!conditionParentMap.containsKey(conditionRule.getId())) {
						conditionParentMap.put(conditionRule.getId(), conditionRuleNew);
					}
				}
				if (conditionRule.getConditionRuleParent() != null) {
					if (conditionParentMap.containsKey(conditionRule.getConditionRuleParent().getId())) {
						conditionRuleNew.setConditionRuleParent(conditionParentMap.get(conditionRule.getConditionRuleParent().getId()));

						if (conditionRule.getConditionRuleParent() != null && conditionRule.getIsLastSon()) {
							conditionRuleNew.setConditionRuleLastParent(conditionParentMap.get(conditionRule.getConditionRuleParent().getId()));
						}

						if (conditionParentMap.get(conditionRule.getConditionRuleParent().getId()).getConditionRulesSons() == null) {
							conditionParentMap.get(conditionRule.getConditionRuleParent().getId()).setConditionRulesSons(
									new ArrayList<ConditionRule>());
						}
						conditionParentMap.get(conditionRule.getConditionRuleParent().getId()).getConditionRulesSons().add(conditionRuleNew);
					} else {
						ConditionRule conditionRuleParentNew = new ConditionRule();
						conditionRuleParentNew.setIsLastSon(conditionRule.getConditionRuleParent().getIsLastSon());
						conditionRuleParentNew.setMaxValue(conditionRule.getConditionRuleParent().getMaxValue());
						conditionRuleParentNew.setMinValue(conditionRule.getConditionRuleParent().getMinValue());
						conditionRuleParentNew.setOperador(conditionRule.getConditionRuleParent().getOperador());
						conditionParentMap.put(Integer.valueOf(conditionRule.getConditionRuleParent().getId()), conditionRuleParentNew);
						conditionRuleNew.setConditionRuleParent(conditionRuleParentNew);
						conditionRuleParentNew.setConditionRulesSons(new ArrayList<ConditionRule>());
						conditionRuleParentNew.getConditionRulesSons().add(conditionRuleNew);
						conditionRuleParentNew.setRulesVersion(ruleVersionNew);
					}
				}

				if (null != conditionRule.getRuleExceptions()) {
					for (RuleException ruleException : conditionRule.getRuleExceptions()) {
						if (null == ruleExceptionManager.find(ruleException.getIdConditionRuleResult())) {
							ruleExceptionList.add(ruleException);
						}
					}
				}

				Variable variable = variableService.findAndSaveVariable(conditionRule.getVariable(), dataSource);
				conditionRuleNew.setVariable(variable);
				ruleVersionNew.getConditionRules().add(conditionRuleNew);
			}
			ruleNew.getRuleVersions().add(ruleVersionNew);

			if (null != ruleExceptionList) {

				RuleException re = new RuleException();

				for (RuleException ruleException : ruleExceptionList) {
					re.setDateAfter(ruleException.getDateAfter());
					re.setDateBefore(ruleException.getDateBefore());
					re.setId(seqnos.execute("bpl_rule_exceptions"));
					re.setIdCard(ruleException.getIdCard());
					re.setIdConditionRuleResult(ruleException.getIdConditionRuleResult());
					re.setIdCustomer(ruleException.getIdCustomer());
					re.setProduct(ruleException.getProduct());
					re.setResult(ruleException.getResult());
					re.setResult1(ruleException.getResult1());
					re.setResult2(ruleException.getResult2());
					re.setResult3(ruleException.getResult3());
					re.setResult4(ruleException.getResult4());
					re.setStatus(ruleException.getStatus());

					ruleExceptionManager.insert(re);
				}
			}

			if (isNuevo) {
				ruleDao.insert(ruleNew);
			} else {
				ruleDao.update(ruleNew);
			}
		}

		return ruleNew;
	}
}
