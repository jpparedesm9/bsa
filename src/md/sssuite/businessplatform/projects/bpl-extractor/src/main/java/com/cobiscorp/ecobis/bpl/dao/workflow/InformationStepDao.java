package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;

public interface InformationStepDao {

	/**
	 * Recupera el LinkCondition por idLink
	 * 
	 * @return
	 */
	List<InformationStep> findByLink(Integer idStep);

}
