package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Official;
import com.cobiscorp.ecobis.bpl.dao.workflow.OfficialDao;

public class OfficialDaoImpl implements OfficialDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Official findByLogin(String login) {
		try {

			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT o  FROM Official o ");
			sql.append(" WHERE  o.login = :login ");

			Query query = entityManager.createQuery(sql.toString());
			query.setParameter("login", login);

			return (Official) query.getSingleResult();

		} catch (NoResultException e) {
			return null;
		}
	}
}
