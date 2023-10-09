package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;

public interface LinkConditionService {

	/**
	 * Recupera el LinkCondition por idLink
	 * 
	 * @return
	 */
	List<LinkCondition> findByLink(Integer idLink);

}
