package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.StepDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class StepDaoImpl implements StepDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.StepDao#findStepByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	@SuppressWarnings("unchecked")
	public List<Step> findStepByProcessVersion(Integer idProcess, Short version) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT s FROM Step s ");
		sql.append(" WHERE s.processVersion.process.idProcess=:idProcess");
		sql.append(" AND s.processVersion.idProcessVersion.versionProcess=:version");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("version", version);

		return query.getResultList();
	}

	public Step saveStep(Step step) throws Exception {
		entityManager.persist(step);
		return step;
	}

	public void detach(Step step) {
		entityManager.detach(step);
	}

	public Step findByProcessVersionAndActivity(Integer idProcess, Short version, String activityName) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Step.findByProcessVersionAndActivity");
			query.setParameter("name", activityName);
			query.setParameter("process", idProcess);
			query.setParameter("versionProcess", version);
			return (Step) query.getSingleResult();
		} catch (NoResultException nrex) {
			return null;
		} catch (NonUniqueResultException nurex) {
			return null;
		}
	}

	public Step findById(Integer idStep) throws Exception {
		return entityManager.find(Step.class, idStep);

	}

}
