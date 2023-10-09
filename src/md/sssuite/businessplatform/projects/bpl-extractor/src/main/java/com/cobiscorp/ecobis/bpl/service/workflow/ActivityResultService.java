package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;

public interface ActivityResultService {

	/**
	 * Recupera los ActivityResult por idStep
	 * 
	 * @return
	 */
	List<ActivityResult> findActivityResultByIdStep(Integer idStep);
	
	ActivityResult save(ActivityResult activityResult) throws Exception;
}
