package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ReceptorDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;

public class ReceptorDaoImpl implements ReceptorDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ActivityObservationDao#findActivityObservationByStep(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public List<Receptor> findReceptorByStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT r  FROM Receptor r ");
		sql.append(" WHERE  r.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

}
