package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.RoleUserDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser;

public class RoleUserDaoImpl implements RoleUserDao {

	static Logger log = Logger.getLogger(RoleUserDao.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Role findById(Integer idRole) {
		return entityManager.find(Role.class, idRole);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.RoleUserDao#insert(com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser)
	 */
	public RoleUser insert(RoleUser roleUser) {
		if (roleUser.getIdRoleUser() == null) {
			entityManager.persist(roleUser);
		} else {
			entityManager.merge(roleUser);
		}
		return roleUser;
	}

	public RoleUser findByLogin(String login) {
		try {

			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ru  FROM RoleUser ru ");
			sql.append(" WHERE  ru.user.login = :login ");

			Query query = entityManager.createQuery(sql.toString());
			query.setParameter("login", login);

			return (RoleUser) query.getSingleResult();

		} catch (NoResultException e) {
			return null;
		}
	}

}
