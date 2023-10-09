package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;

public interface ISystemRuleDAO {

	public abstract SystemRule find(int id);

	public abstract boolean insert(SystemRule systemRule);

	public abstract List<SystemRule> queryAllSystems();

	SystemRule findByAcronym(String acronym);

}
