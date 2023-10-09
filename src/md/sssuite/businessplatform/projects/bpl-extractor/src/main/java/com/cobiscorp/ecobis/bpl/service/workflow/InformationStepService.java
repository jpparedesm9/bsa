package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;

public interface InformationStepService {

	/**
	 * Recupera el LinkCondition por idLink
	 * 
	 * @return
	 */
	List<InformationStep> findByLink(Integer idStep);

}
