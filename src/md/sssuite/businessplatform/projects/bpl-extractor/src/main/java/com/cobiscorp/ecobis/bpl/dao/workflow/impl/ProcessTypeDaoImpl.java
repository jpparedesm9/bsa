package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessTypeDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;

public class ProcessTypeDaoImpl implements ProcessTypeDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<ProcessType> findByProcess(Integer idProcess) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT pt  FROM ProcessType pt ");
		sql.append(" WHERE  pt.process.idProcess = :idProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);

		return query.getResultList();

	}

}
