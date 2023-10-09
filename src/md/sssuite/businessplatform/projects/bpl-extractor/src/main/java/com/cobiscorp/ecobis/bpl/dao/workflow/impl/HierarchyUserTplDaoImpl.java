package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyUserTplDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyUserTpl;

public class HierarchyUserTplDaoImpl implements HierarchyUserTplDao {

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

	@SuppressWarnings("unchecked")
	public List<HierarchyUserTpl> findByHierarchyItemTpl(Integer idHierarchyItemTpl) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT hut  FROM HierarchyUserTpl hut ");
		sql.append(" WHERE  hut.hierarchyItemTpl.idHierarchyItemTpl = :idHierarchyItemTpl ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idHierarchyItemTpl", idHierarchyItemTpl);

		return query.getResultList();

	}

	public HierarchyUserTpl insert(HierarchyUserTpl hierarchyUserTpl) {
		entityManager.persist(hierarchyUserTpl);
		return hierarchyUserTpl;
	}

	public HierarchyUserTpl update(HierarchyUserTpl hierarchyUserTpl) {
		entityManager.merge(hierarchyUserTpl);
		return hierarchyUserTpl;
	}

}
