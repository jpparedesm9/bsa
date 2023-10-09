package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.RoleDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;

public class RoleDaoImpl implements RoleDao {

	static Logger log = Logger.getLogger(RoleDaoImpl.class);

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

	@SuppressWarnings("unchecked")
	public Role findByName(String name) {
		Query query = entityManager.createNamedQuery("Role.findByName");
		query.setParameter("name", name);
		List<Role> roleList = (List<Role>) query.getResultList();

		if (roleList.isEmpty()) {
			return null;
		} else {
			return roleList.get(0);
		}
	}

	public Role insert(Role role) {
		log.debug("SaveRole------------------------------------->1 ");
		entityManager.persist(role);
		entityManager.flush();
		log.debug("SaveRole------------------------------------->2 ");
		return role;
	}

	public void flush() {
		entityManager.flush();

	}
}
