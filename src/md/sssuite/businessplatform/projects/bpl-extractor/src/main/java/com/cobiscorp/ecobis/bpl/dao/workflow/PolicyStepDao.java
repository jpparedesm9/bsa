package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;

public interface PolicyStepDao {

	/**
	 * Recupera los PolicyStep por idStep
	 * 
	 * @return
	 */
	List<PolicyStep> findPolicyStepByStep(Integer idStep);

	PolicyStep savePolicyStep(PolicyStep policyStep) throws Exception;
}
