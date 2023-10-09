package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;

public interface ActivityRequirementService {

	/**
	 * Recupera los ActivityRequirement por idStep
	 * 
	 * @return
	 */
	List<ActivityRequirement> findActivityRequirementByStep(Integer idStep);

	ActivityRequirement save(ActivityRequirement activityRequirement) throws Exception;

}
