package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;


public interface ISubTypeRuleDAO {

	public abstract SubTypeRule find(int id);

	public abstract List<SubTypeRule> findAll(Integer id);

	public abstract boolean insert(SubTypeRule subTypeRule);
	
	SubTypeRule findByAcronym(String acronym);

}
