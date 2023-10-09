package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessActivityDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;

public class ProcessActivityDaoImpl implements ProcessActivityDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<ProcessActivity> findProcessActivityByProcessVersion(Integer idProcess, Short versionProcess) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT pa  FROM ProcessActivity pa ");
		sql.append(" WHERE  pa.idProcess = :idProcess ");
		sql.append(" AND    pa.versionProcess = :versionProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);

		return query.getResultList();

	}
}