package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.bpl.dao.workflow.LinkRoleDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;

public class LinkRoleDaoImpl implements LinkRoleDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public LinkRole save(LinkRole linkRole) throws Exception {
		entityManager.persist(linkRole);
		return linkRole;
	}

}
