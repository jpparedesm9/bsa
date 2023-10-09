package com.cobiscorp.ecobis.fpm.mock;

import java.util.HashMap;
import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager;

public class RuleManagerMock implements IRuleManager {

	
	public List<RuleProcess> generate(
			HashMap<RuleVersion, List<VariableProcess>> arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Rule> queryAllRules() {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Rule> queryByType(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Rule> queryByTypeAndSubtype(String arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Variable> queryConditionRuleVersionActive(RuleVersion arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public RuleVersion queryRuleVersionActive(Rule arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public RuleVersion simulate(RuleVersion arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<RuleProcess> generate(
			HashMap<RuleVersion, List<VariableProcess>> arg0, Integer arg1,
			String arg2, Integer arg3) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Rule> queryByTypeAndSubtypeAndSystem(String arg0, String arg1,
			String arg2) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<Rule> queryPoliciesInRules(Integer arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<RuleProcess> generate(String arg0, List<VariableProcess> arg1,
			Integer arg2, String arg3, Integer arg4) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public List<RuleProcess> generateList(
			HashMap<String, List<VariableProcess>> arg0, Integer arg1,
			String arg2, Integer arg3) {
		// TODO Auto-generated method stub
		return null;
	}

}
