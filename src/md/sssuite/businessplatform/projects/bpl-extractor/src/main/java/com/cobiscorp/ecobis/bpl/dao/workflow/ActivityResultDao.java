package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;

public interface ActivityResultDao {

	/**
	 * Recupera los ActivityResult por idStep
	 * 
	 * @return
	 */
	List<ActivityResult> findActivityResultByIdStep(Integer idStep);
	
	ActivityResult saveActivityResult(ActivityResult activityResult) throws Exception;

}
