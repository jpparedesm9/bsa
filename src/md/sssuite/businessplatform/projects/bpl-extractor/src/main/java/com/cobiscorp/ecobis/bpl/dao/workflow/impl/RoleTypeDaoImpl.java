package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.RoleTypeDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.RoleUserDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;

public class RoleTypeDaoImpl implements RoleTypeDao {

	static Logger log = Logger.getLogger(RoleUserDao.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<RoleType> findByRole(Integer idRole) {

			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT rt  FROM RoleType rt ");
			sql.append(" WHERE  rt.role.idRole = :idRole ");

			Query query = entityManager.createQuery(sql.toString());
			query.setParameter("idRole", idRole);

			return query.getResultList();

	}

	public RoleType insert(RoleType roleType) {
		entityManager.persist(roleType);
		return roleType;
	}

}
