package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;

public interface ActivityRequirementDao {

	/**
	 * Recupera los ActivityRequirement por idStep
	 * 
	 * @return
	 */
	List<ActivityRequirement> findActivityRequirementByStep(Integer idStep);

	ActivityRequirement saveActivityRequirement(ActivityRequirement activityRequirement) throws Exception;
}
