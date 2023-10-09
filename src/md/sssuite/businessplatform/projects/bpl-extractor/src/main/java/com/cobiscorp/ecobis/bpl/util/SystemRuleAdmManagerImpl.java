package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;

public class SystemRuleAdmManagerImpl implements ISystemRuleAdmManager {

	private ISystemRuleDAO systemRuleDAO;
	private SeqnosProcedureManager seqnosQuery;

	static Logger log = Logger.getLogger(SystemRuleAdmManagerImpl.class);

	public void setSeqnosQuery(SeqnosProcedureManager seqnosQuery) {
		this.seqnosQuery = seqnosQuery;
	}

	public void setSystemRuleDAO(ISystemRuleDAO systemRuleDAO) {
		this.systemRuleDAO = systemRuleDAO;
	}

	public SystemRule find(Integer id) {

		return systemRuleDAO.find(id);
	}

	public boolean insert(SystemRule systemRule) {

		return systemRuleDAO.insert(systemRule);
	}

	public List<SystemRule> queryAllSystems() {
		return systemRuleDAO.queryAllSystems();
	}

	public SystemRule findAndSaveSystemRule(SystemRule systemRule, DriverManagerDataSource dataSource) {

		SystemRule systemRuleSearch = hmSystemRule.get(systemRule.getAcronym());

		log.debug("SystemRule---------------------------------------------------->1" + systemRuleSearch);
		if (systemRuleSearch == null) {
			log.debug("SystemRule---------------------------------------------------->2" + systemRuleSearch);
			systemRuleSearch = systemRuleDAO.findByAcronym(systemRule.getAcronym());
			log.debug("SystemRule---------------------------------------------------->3" + systemRuleSearch);
			if (systemRuleSearch == null) {

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

				log.debug("SystemRule---------------------------------------------------->4" + systemRuleSearch);
				Integer codigoSystemRule = seqnos.execute("bpl_system_rule");
				systemRuleSearch = new SystemRule();
				systemRuleSearch.setId(codigoSystemRule);
				systemRuleSearch.setAcronym(systemRule.getAcronym());
				systemRuleSearch.setDescription(systemRule.getDescription());
				systemRuleSearch.setModule(systemRule.getModule());
				systemRuleSearch.setName(systemRule.getName());

				systemRuleDAO.insert(systemRuleSearch);
				log.debug("SystemRule---------------------------------------------------->12" + systemRuleSearch);
			}
			hmSystemRule.put(systemRule.getAcronym(), systemRuleSearch);
		}
		return systemRuleSearch;
	}

}
