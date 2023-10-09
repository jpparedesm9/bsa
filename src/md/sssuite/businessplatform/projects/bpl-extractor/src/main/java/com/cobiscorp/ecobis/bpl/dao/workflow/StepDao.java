package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public interface StepDao {

	/**
	 * Recupera los steps por idProcess y version
	 * 
	 * @return
	 */
	List<Step> findStepByProcessVersion(Integer idProcess, Short version);

	Step findByProcessVersionAndActivity(Integer idProcess, Short version, String activityName) throws Exception;

	Step saveStep(Step step) throws Exception;

	void detach(Step step);

	Step findById(Integer idStep) throws Exception;

}
