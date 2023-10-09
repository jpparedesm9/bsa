package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.PolicyStepDao;
import com.cobiscorp.ecobis.bpl.service.workflow.PolicyStepService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;

public class PolicyStepServiceImpl implements PolicyStepService {

	private PolicyStepDao policyStepDao;

	/**
	 * @return the policyStepDao
	 */
	public PolicyStepDao getPolicyStepDao() {
		return policyStepDao;
	}

	/**
	 * @param policyStepDao
	 *            the policyStepDao to set
	 */
	public void setPolicyStepDao(PolicyStepDao policyStepDao) {
		this.policyStepDao = policyStepDao;
	}

	public List<PolicyStep> findPolicyStepByStep(Integer idStep) {
		return policyStepDao.findPolicyStepByStep(idStep);
	}

	public PolicyStep savePolicyStep(PolicyStep policyStep) throws Exception {
		return policyStepDao.savePolicyStep(policyStep);
	}

}
