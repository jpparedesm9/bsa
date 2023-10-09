package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVariableDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;

public class ProcessVariableDaoImpl implements ProcessVariableDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVariableDao#findProcessVariableByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	@SuppressWarnings("unchecked")
	public List<ProcessVariable> findProcessVariableByProcessVersion(Integer idProcess, Short versionProcess) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT pv FROM ProcessVariable pv ");
		sql.append(" WHERE pv.idProcess = :idProcess ");
		sql.append(" AND pv.versionProcess = :versionProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);

		return query.getResultList();
	}

}
