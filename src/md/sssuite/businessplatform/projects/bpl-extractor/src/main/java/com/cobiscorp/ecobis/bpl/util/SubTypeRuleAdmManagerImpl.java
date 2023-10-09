package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;

public class SubTypeRuleAdmManagerImpl implements ISubTypeRuleAdmManager {

	private ISubTypeRuleDAO subTypeRuleDAO;
	private SeqnosProcedureManager seqnosQuery;

	static Logger log = Logger.getLogger(SubTypeRuleAdmManagerImpl.class);

	public void setSeqnosQuery(SeqnosProcedureManager seqnosQuery) {
		this.seqnosQuery = seqnosQuery;
	}

	public void setSubTypeRuleDAO(ISubTypeRuleDAO subTypeRuleDAO) {
		this.subTypeRuleDAO = subTypeRuleDAO;
	}

	public SubTypeRule find(Integer id) {
		return subTypeRuleDAO.find(id);
	}

	public boolean insert(SubTypeRule subTypeRule) {
		return subTypeRuleDAO.insert(subTypeRule);
	}

	public List<SubTypeRule> findAll(Integer id) {
		return subTypeRuleDAO.findAll(id);
	}

	public SubTypeRule findAndSaveSubTypeRule(SubTypeRule subTypeRule, DriverManagerDataSource dataSource) {
		SubTypeRule subTypeRuleSearch = hmSubTypeRule.get(subTypeRule.getAcronym());

		log.debug("SubTypeRule---------------------------------------------------->1" + subTypeRuleSearch);
		if (subTypeRuleSearch == null) {
			log.debug("SubTypeRule---------------------------------------------------->2" + subTypeRuleSearch);
			subTypeRuleSearch = subTypeRuleDAO.findByAcronym(subTypeRule.getAcronym());
			log.debug("SubTypeRule---------------------------------------------------->3" + subTypeRuleSearch);
			if (subTypeRuleSearch == null) {

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

				log.debug("SubTypeRule---------------------------------------------------->4" );
				Integer codigoSubTypeRule = seqnos.execute("bpl_system_rule");
				subTypeRuleSearch = new SubTypeRule();
				subTypeRuleSearch.setId(codigoSubTypeRule);
				subTypeRuleSearch.setAcronym(subTypeRule.getAcronym());
				subTypeRuleSearch.setDescription(subTypeRule.getDescription());
				subTypeRuleSearch.setName(subTypeRule.getName());
				subTypeRuleSearch.setId(subTypeRule.getId());
//				subTypeRuleSearch.setSystem(subTypeRule.getSystem());

				boolean a = subTypeRuleDAO.insert(subTypeRuleSearch);
				log.debug("SubTypeRule---------------------------------------------------->5");
			}
			log.debug("SubTypeRule---------------------------------------------------->6");
			hmSubTypeRule.put(subTypeRuleSearch.getAcronym(), subTypeRuleSearch);
			log.debug("SubTypeRule---------------------------------------------------->7" );
		}
		return subTypeRuleSearch;
	}
}
