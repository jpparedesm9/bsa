package com.cobiscorp.ecobis.bpl.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.extractor.repository.ConditionRuleRepository;
import com.cobiscorp.ecobis.bpl.extractor.repository.ProgramaRepository;
import com.cobiscorp.ecobis.bpl.extractor.repository.RuleRepository;
import com.cobiscorp.ecobis.bpl.extractor.repository.RuleVersionRepository;
import com.cobiscorp.ecobis.bpl.extractor.repository.VariableRepository;
import com.cobiscorp.ecobis.bpl.rules.engine.model.ConditionRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;

public class RuleQueryManager {

	static Logger log = Logger.getLogger(RuleQueryManager.class);

	public static List<Rule> prepareListToXml(List<Rule> listRules, ApplicationContext context) {
		List<Rule> returnList = new ArrayList<Rule>();
		try {

			RuleVersionRepository ruleVersionRepository = context.getBean(RuleVersionRepository.class);
			ConditionRuleRepository conditionRuleRepository = context.getBean(ConditionRuleRepository.class);
			List<RuleVersion> listRuleVersion = ruleVersionRepository.findByListRules(listRules);
			List<ConditionRule> listConditionRule = conditionRuleRepository.findByListRulesVersion(listRuleVersion);
			for (Rule iterador : listRules) {
				returnList.add(getRule(iterador, listRuleVersion, listConditionRule, context));
			}
		} catch (Exception ex) {
			log.error(ex);
		}
		return returnList;
	}

	public static void saveListToBdd(List<Rule> listRules, ApplicationContext context, DriverManagerDataSource dataSource) {
		List<Rule> returnList = new ArrayList<Rule>();
		RuleRepository ruleRepository = context.getBean(RuleRepository.class);

		boolean existSystemRule = false;
		boolean existSubtypeRule = false;
		for (Rule iterador : listRules) {
			returnList.add(setRule(iterador, context, dataSource, existSystemRule, existSubtypeRule));
		}
		ruleRepository.save(returnList);

	}

	public static Rule saveRuleBdd(Rule rule, ApplicationContext context, DriverManagerDataSource dataSource) {
		RuleRepository ruleRepository = context.getBean(RuleRepository.class);
		return ruleRepository.save(setRule(rule, context, dataSource, false, false));
	}

	public static String validateRule(List<Rule> listRules, ApplicationContext context) {

		RuleRepository ruleRepository = context.getBean(RuleRepository.class);
		boolean isDesing = false;
		StringBuilder sb = new StringBuilder();
		sb.append("Las siguientes reglas tienen versiones en dise\u00F1o (");
		for (Rule iterador : listRules) {
			Rule ruleBdd = ruleRepository.findDesingRulesByAcronym(iterador.getAcronym());
			if (ruleBdd != null) {
				isDesing = true;
				sb.append(iterador.getId() + " - " + iterador.getName().trim());
				if (iterador != listRules.get(listRules.size() - 1)) {
					sb.append(", ");
				}
			}
		}
		sb.append(") y se proceder\u00e1 a eliminar, desea continuar?");
		if (isDesing) {
			return sb.toString();
		} else {
			return "";
		}
	}

	public static Rule setRule(Rule iterador, ApplicationContext context, DriverManagerDataSource dataSource, boolean existSystemRule,
			boolean existSubtypeRule) {

		log.info("Se procede a importar la regla: " + iterador.getAcronym() + "-" + iterador.getName());
		ISystemRuleAdmManager systemRuleManager = context.getBean(ISystemRuleAdmManager.class);
		ISubTypeRuleAdmManager subtypeRuleManager = context.getBean(ISubTypeRuleAdmManager.class);
		RuleRepository ruleRepository = context.getBean(RuleRepository.class);
		RuleVersionRepository ruleVersionRepository = context.getBean(RuleVersionRepository.class);
		ConditionRuleRepository conditionRuleRepository = context.getBean(ConditionRuleRepository.class);
		IRuleExceptionAdmManager exceptionManager = context.getBean(IRuleExceptionAdmManager.class);
		ProgramaRepository programaRepository = context.getBean(ProgramaRepository.class);
		VariableRepository variableRepository = context.getBean(VariableRepository.class);
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
		VariableService variableService = context.getBean(VariableService.class);

		Map<Short, Variable> variablesMap = new HashMap<Short, Variable>();
		Map<Integer, ConditionRule> conditionParentMap = new HashMap<Integer, ConditionRule>();
		List<RuleException> ruleExceptionList = new ArrayList<RuleException>();
		Rule tempRule = new Rule();
		SystemRule tmpSystemRule = new SystemRule();

		tmpSystemRule = systemRuleManager.findAndSaveSystemRule(iterador.getSystemRule(), dataSource);

		if (null != subtypeRuleManager.findAll(Integer.valueOf(tmpSystemRule.getId()))) {
			log.debug("tmpSystemRule.getId !=null");
			for (SubTypeRule subTypeRule : subtypeRuleManager.findAll(Integer.valueOf(tmpSystemRule.getId()))) {
				log.debug("subTypeRule" + subTypeRule.getAcronym());
				if (iterador.getSubTypeId().trim().equals(subTypeRule.getAcronym().trim())) {
					log.debug("subTypeRule match");
					existSubtypeRule = true;
				}
			}
		}

		if (!existSubtypeRule) {

			log.debug("!existSubtypeRule--->" + iterador.getName());
			for (SubTypeRule subtype : iterador.getSubType()) {

				if (iterador.getSubTypeId().trim().equals(subtype.getAcronym().trim())) {

					SubTypeRule tmpSubTypeRule = new SubTypeRule();
					tmpSubTypeRule.setId(seqnos.execute("bpl_subtype_rule"));
					tmpSubTypeRule.setName(subtype.getName());
					tmpSubTypeRule.setAcronym(subtype.getAcronym().trim());
					tmpSubTypeRule.setDescription(subtype.getDescription());
					tmpSubTypeRule.setIdSystemRule(tmpSystemRule.getId());
					subtypeRuleManager.insert(tmpSubTypeRule);

				}
			}
		}

		tempRule.setAcronym(iterador.getAcronym());
		Rule ruleId = ruleRepository.findByName(iterador.getName());
		if (ruleId != null) {
			tempRule.setId(ruleId.getId());
		} else {
			tempRule.setId(seqnos.execute("bpl_rule"));
		}
		tempRule.setName(iterador.getName());

		if (null != iterador.getDescription() && "" != iterador.getDescription().trim()) {
			tempRule.setDescription(iterador.getDescription());
		}
		tempRule.setType(iterador.getType());
		tempRule.setSystemRule(iterador.getSystemRule());
		tempRule.setSystemRuleId(iterador.getSystemRuleId());
		tempRule.setSubTypeId(iterador.getSubTypeId());
		tempRule.setSubType(iterador.getSubType());
		tempRule.setRuleVersions(new ArrayList<RuleVersion>());

		if (iterador.getRuleVersions() != null) {
			for (RuleVersion iterador2 : iterador.getRuleVersions()) {
				RuleVersion tempRuleVersion = new RuleVersion();
				tempRuleVersion.setDateFinish(iterador2.getDateFinish());
				tempRuleVersion.setDateStart(Calendar.getInstance());
				tempRuleVersion.setId(seqnos.execute("bpl_rule_version"));
				tempRuleVersion.setRule(tempRule);
				tempRuleVersion.setStatus(iterador2.getStatus());
				if (ruleId != null) {
					Integer maxId = ruleVersionRepository.findMaxVersion(ruleId);
					tempRuleVersion.setVersion(maxId == null ? 1 : maxId + 1);
				} else {
					tempRuleVersion.setVersion(1);
				}
				log.info("Se procede a importar la version: " + iterador.getAcronym() + "-" + tempRuleVersion.getVersion());
				List<RuleVersion> ruleVersions = ruleVersionRepository.findByRule(ruleId);
				log.debug("------------------------------>RULW_0");
				for (RuleVersion iterador3 : ruleVersions) {
					log.debug("------------------------------>RULW_1");
					if ("PRO".equals(iterador3.getStatus().trim())) {
						log.debug("------------------------------>RULE_3");
						iterador3.setStatus("ANT");
						if (iterador3.getDateFinish() != null && iterador3.getDateFinish().compareTo(tempRuleVersion.getDateStart()) > 0) {
							iterador3.setDateFinish(Calendar.getInstance());
							log.debug("------------------------------>RULE_4");
						}
						log.debug("------------------------------>RULE_5");
						ruleVersionRepository.saveAndFlush(iterador3);
						log.debug("------------------------------>RULE_6");
					} else {
						log.debug("------------------------------>RULE_7");
						if ("DIS".equals(iterador3.getStatus().trim())) {
							log.debug("------------------------------>RULE_8");
							//for (ConditionRule conditionRule : iterador3.getConditionRules()) {
								// conditionRuleRepository.delete(conditionRule);//Se comenta ya que daba error
							//	log.debug("------------------------------>RULE_8.1-->" + conditionRule.getId());

							//}
							// conditionRuleRepository.delete(conditionRuleRepository.findByRuleVersion(iterador3));
							log.debug("------------------------------>RULE_9");
							ruleVersionRepository.delete(iterador3);
							log.debug("------------------------------>RULE_10");
						}
					}
				}
				tempRuleVersion.setConditionRules(new ArrayList<ConditionRule>());
				for (ConditionRule iterador3 : iterador2.getConditionRules()) {
					log.info("Se procede a importar la condici\u00F3n: " + iterador3.getVariable().getAbreviaturaVariable() + iterador3.getOperador()
							+ iterador3.getMinValue() + " " + iterador3.getMaxValue());
					ConditionRule tempConditionRule;
					ConditionRule lastParent = null;
					if (!conditionParentMap.containsKey(iterador3.getId())) {
						tempConditionRule = new ConditionRule();
						tempConditionRule.setIsLastSon(iterador3.getIsLastSon());
						tempConditionRule.setMaxValue(iterador3.getMaxValue());
						tempConditionRule.setMinValue(iterador3.getMinValue());
						tempConditionRule.setOperador(iterador3.getOperador());
						tempConditionRule.setIdResult(iterador3.getIdResult());
						tempConditionRule.setRulesVersion(tempRuleVersion);
					} else {
						tempConditionRule = conditionParentMap.get(iterador3.getId());
					}
					if (!conditionParentMap.containsKey(iterador3.getId())) {
						conditionParentMap.put(iterador3.getId(), tempConditionRule);
					}

					if (iterador3.getConditionRuleParent() != null) {
						if (conditionParentMap.containsKey(iterador3.getConditionRuleParent().getId())) {
							tempConditionRule.setConditionRuleParent(conditionParentMap.get(iterador3.getConditionRuleParent().getId()));

							if (iterador3.getConditionRuleParent() != null && iterador3.getIsLastSon()) {
								tempConditionRule.setConditionRuleLastParent(conditionParentMap.get(iterador3.getConditionRuleParent().getId()));
							}

							if (conditionParentMap.get(iterador3.getConditionRuleParent().getId()).getConditionRulesSons() == null) {
								conditionParentMap.get(iterador3.getConditionRuleParent().getId()).setConditionRulesSons(
										new ArrayList<ConditionRule>());
							}
							conditionParentMap.get(iterador3.getConditionRuleParent().getId()).getConditionRulesSons().add(tempConditionRule);
						} else {
							ConditionRule tempConditionRuleParent = new ConditionRule();
							tempConditionRuleParent.setIsLastSon(iterador3.getConditionRuleParent().getIsLastSon());
							tempConditionRuleParent.setMaxValue(iterador3.getConditionRuleParent().getMaxValue());
							tempConditionRuleParent.setMinValue(iterador3.getConditionRuleParent().getMinValue());
							tempConditionRuleParent.setOperador(iterador3.getConditionRuleParent().getOperador());
							conditionParentMap.put(Integer.valueOf(iterador3.getConditionRuleParent().getId()), tempConditionRuleParent);
							tempConditionRule.setConditionRuleParent(tempConditionRuleParent);
							tempConditionRuleParent.setConditionRulesSons(new ArrayList<ConditionRule>());
							tempConditionRuleParent.getConditionRulesSons().add(tempConditionRule);
							tempConditionRuleParent.setRulesVersion(tempRuleVersion);
						}
					}

					if (null != iterador3.getRuleExceptions()) {
						for (RuleException ruleException : iterador3.getRuleExceptions()) {

							if (null == exceptionManager.find(ruleException.getIdConditionRuleResult())) {
								ruleExceptionList.add(ruleException);
								// exceptionManager.insert(ruleException);
							}
						}
					}

					if (!variablesMap.containsKey(iterador3.getVariable().getCodigoVariable())) {
						Variable tempVariable = variableService.findAndSaveVariable(iterador3.getVariable(), dataSource);
						tempConditionRule.setVariable(tempVariable);
						variablesMap.put(iterador3.getVariable().getCodigoVariable(), tempVariable);
						// variableRepository.save(tempVariable);
					} else {
						tempConditionRule.setVariable(variablesMap.get(iterador3.getVariable().getCodigoVariable()));
					}
					tempRuleVersion.getConditionRules().add(tempConditionRule);
				}
				tempRule.getRuleVersions().add(tempRuleVersion);
			}
		}
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

				exceptionManager.insert(re);
			}
		}
		return tempRule;
	}

	public static Rule prepareRuleToXml(String acronym, Integer ruleId, String type, ApplicationContext context) {
		Rule rule = null;
		try {
			RuleRepository ruleRepository = context.getBean(RuleRepository.class);
			RuleVersionRepository ruleVersionRepository = context.getBean(RuleVersionRepository.class);
			ConditionRuleRepository conditionRuleRepository = context.getBean(ConditionRuleRepository.class);

			if ("R".equals(type)) {
				rule = ruleRepository.findOne(ruleId);
			} else if ("P".equals(type)) {
				rule = ruleRepository.findByAcronym(acronym);
			}
			if (rule != null) {
				List<Rule> listRules = new ArrayList<Rule>();
				listRules.add(rule);
				List<RuleVersion> listRuleVersion = ruleVersionRepository.findByListRules(listRules);
				List<ConditionRule> listConditionRule = conditionRuleRepository.findByListRulesVersion(listRuleVersion);
				return getRule(rule, listRuleVersion, listConditionRule, context);
			}

		} catch (Exception ex) {
			log.error(ex);
		}
		return rule;

	}

	public static Rule getRule(Rule iterador, List<RuleVersion> listRuleVersion, List<ConditionRule> listConditionRule, ApplicationContext context)
			throws Exception {
		Rule tempRule = new Rule();
		try {
			IRuleExceptionAdmManager exceptionManager = context.getBean(IRuleExceptionAdmManager.class);

			ISystemRuleAdmManager systemRuleManager = context.getBean(ISystemRuleAdmManager.class);
			ISubTypeRuleAdmManager subtypeRuleManger = context.getBean(ISubTypeRuleAdmManager.class);

			log.info("Se procede a exportar la regla: " + iterador.getAcronym() + "-" + iterador.getName());

			tempRule.setAcronym(iterador.getAcronym());
			if (null != iterador.getDescription() && "" != iterador.getDescription()) {

				tempRule.setDescription(iterador.getDescription());
			}
			tempRule.setId(iterador.getId());
			tempRule.setName(iterador.getName());
			tempRule.setSystemRuleId(iterador.getSystemRuleId());
			tempRule.setType(iterador.getType());
			tempRule.setSubTypeId(iterador.getSubTypeId());
			for (SystemRule systemRule : systemRuleManager.queryAllSystems()) {
				SystemRule wTmpSystemRule = new SystemRule();
				if (systemRule.getAcronym().trim().equals(tempRule.getSystemRuleId().trim())) {
					wTmpSystemRule.setAcronym(systemRule.getAcronym());
					wTmpSystemRule.setDescription(systemRule.getDescription());
					wTmpSystemRule.setId(systemRule.getId());
					wTmpSystemRule.setModule(systemRule.getModule());
					wTmpSystemRule.setName(systemRule.getName());
					wTmpSystemRule.setSubtype(systemRule.getSubtype());

					tempRule.setSystemRule(wTmpSystemRule);
				}
			}
			tempRule.setSubType(subtypeRuleManger.findAll(Integer.valueOf(tempRule.getSystemRule().getId())));
			for (RuleVersion iterador2 : listRuleVersion) {
				if (iterador.getId() == iterador2.getRule().getId()) {
					log.info("Se procede a exportar la version: " + iterador.getAcronym() + "-" + iterador2.getVersion());
					RuleVersion tempRuleVersion = new RuleVersion();
					tempRuleVersion.setDateFinish(iterador2.getDateFinish());
					tempRuleVersion.setDateStart(iterador2.getDateStart());
					tempRuleVersion.setId(iterador2.getId());
					tempRuleVersion.setRule(iterador2.getRule());
					tempRuleVersion.setStatus(iterador2.getStatus());
					tempRuleVersion.setVersion(iterador2.getVersion());
					for (ConditionRule iterador3 : listConditionRule) {
						log.info("Se procede a exportar la condici\u00F3n: " + iterador3.getVariable().getAbreviaturaVariable()
								+ iterador3.getOperador() + iterador3.getMinValue() + " " + iterador3.getMaxValue());
						if (iterador2.getId() == iterador3.getRulesVersion().getId()) {
							if (tempRuleVersion.getConditionRules() == null) {
								tempRuleVersion.setConditionRules(new ArrayList<ConditionRule>());
							}
							if (iterador3.getIdResult() > 0) {
								List<RuleException> ruleException = exceptionManager.findAll(Integer.valueOf(iterador3.getIdResult()));

								iterador3.setRuleExceptions(ruleException);
							}

							tempRuleVersion.getConditionRules().add(iterador3);
						}
					}

					tempRule.setRuleVersions(new ArrayList<RuleVersion>());
					tempRule.getRuleVersions().add(tempRuleVersion);
				}
			}
		} catch (Exception ex) {
			log.error(ex);
			throw ex;
		}
		return tempRule;
	}
}
