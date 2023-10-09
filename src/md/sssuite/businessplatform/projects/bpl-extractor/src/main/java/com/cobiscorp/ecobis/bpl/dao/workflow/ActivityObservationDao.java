package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;

public interface ActivityObservationDao {

	/**
	 * Recupera los ActivityRequirement por idStep
	 * 
	 * @return
	 */
	List<ActivityObservation> findActivityObservationByStep(Integer idStep);

	ActivityObservation saveActivityObservation(ActivityObservation activityObservation) throws Exception;
}
