package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;

public interface ActivityObservationService {

	/**
	 * Recupera los ActivityRequirement por idStep
	 * 
	 * @return
	 */
	List<ActivityObservation> findActivityObservationByStep(Integer idStep);

	ActivityObservation save(ActivityObservation activityObservation) throws Exception;

}
