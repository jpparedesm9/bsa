package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyLevelTplDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyLevelTpl;

public class HierarchyLevelTplDaoImpl implements HierarchyLevelTplDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * @param entityManager
	 *            the entityManager to set
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public HierarchyLevelTpl insert(HierarchyLevelTpl hierarchyLevelTpl) {
		entityManager.persist(hierarchyLevelTpl);
		return hierarchyLevelTpl;
	}

	public HierarchyLevelTpl update(HierarchyLevelTpl hierarchyLevelTpl) {
		entityManager.merge(hierarchyLevelTpl);
		return hierarchyLevelTpl;
	}

}
