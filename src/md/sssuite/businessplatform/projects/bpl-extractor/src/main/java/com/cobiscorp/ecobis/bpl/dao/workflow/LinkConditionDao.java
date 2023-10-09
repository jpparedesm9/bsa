package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;

public interface LinkConditionDao {

	/**
	 * Recupera el LinkCondition por idLink
	 * 
	 * @return
	 */
	List<LinkCondition> findByLink(Integer idLink);
	
	LinkCondition save(LinkCondition linkCondition) throws Exception;

}
