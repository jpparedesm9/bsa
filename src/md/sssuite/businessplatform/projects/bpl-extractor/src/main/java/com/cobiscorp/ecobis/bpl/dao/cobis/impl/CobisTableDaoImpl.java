package com.cobiscorp.ecobis.bpl.dao.cobis.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.CobisTable;
import com.cobiscorp.ecobis.bpl.dao.cobis.CobisTableDao;

public class CobisTableDaoImpl implements CobisTableDao {
	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public CobisTable findCobisTableByTableName(String tableName) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("CobisTable.findByTableName");
			query.setParameter("table", tableName);
			return (CobisTable) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException e) {
			return null;
		}
	}

}
