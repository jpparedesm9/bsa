package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;

public interface PolicyStepService {

	/**
	 * Recupera los PolicyStep por idStep
	 * 
	 * @return
	 */
	List<PolicyStep> findPolicyStepByStep(Integer idStep);

	PolicyStep savePolicyStep(PolicyStep policyStep) throws Exception;

}
