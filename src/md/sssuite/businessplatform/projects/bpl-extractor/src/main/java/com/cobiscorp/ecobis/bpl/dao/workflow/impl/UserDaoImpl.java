package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.UserDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public class UserDaoImpl implements UserDao {

	static Logger log = Logger.getLogger(UserDaoImpl.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public User findById(Integer idUser) {
		return entityManager.find(User.class, idUser);
	}

	public User findByLogin(String login) {
		try {

			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT u  FROM User u ");
			sql.append(" WHERE  u.login = :login ");

			Query query = entityManager.createQuery(sql.toString());
			query.setParameter("login", login);

			return (User) query.getSingleResult();

		} catch (NoResultException e) {
			return null;
		}
	}

	public User insert(User user) {
		entityManager.persist(user);
		return user;
	}

}
