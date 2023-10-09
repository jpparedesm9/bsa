package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.PolicyStepDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.PolicyStep;

public class PolicyStepDaoImpl implements PolicyStepDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.PolicyStepDao#findPolicyStepByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	@SuppressWarnings("unchecked")
	public List<PolicyStep> findPolicyStepByStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ps  FROM PolicyStep ps ");
		sql.append(" WHERE  ps.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

	public PolicyStep savePolicyStep(PolicyStep policyStep) throws Exception {
		entityManager.persist(policyStep);
		return policyStep;
	}

}
