package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemTplDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItemTpl;

public class HierarchyItemTplDaoImpl implements HierarchyItemTplDao {

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
	public List<HierarchyItemTpl> findByHierarchyTypeTpl(Integer idHierarchyTypeTpl) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT hit  FROM HierarchyItemTpl hit ");
		sql.append(" WHERE  hit.hierarchyTypeTpl.idHierarchyTypeTpl = :idHierarchyTypeTpl ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idHierarchyTypeTpl", idHierarchyTypeTpl);

		return query.getResultList();

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemDao#findByHierarchyItemStep(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public HierarchyItemTpl findByHierarchyTypeTplAndHierarchyItemTpl(String nameHierarchyTypeTpl, String nameHierarchyItemTpl) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT hit  FROM HierarchyItemTpl hit ");
		sql.append(" WHERE  hit.hierarchyTypeTpl.name = :nameHierarchyTypeTpl ");
		sql.append(" AND    hit.description = :nameHierarchyItemTpl ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("nameHierarchyTypeTpl", nameHierarchyTypeTpl);
		query.setParameter("nameHierarchyItemTpl", nameHierarchyItemTpl);

		List<HierarchyItemTpl> hierarchyItemTplList = query.getResultList();

		if (hierarchyItemTplList.isEmpty()) {
			return null;
		}

		return hierarchyItemTplList.get(0);
	}

	public HierarchyItemTpl insert(HierarchyItemTpl hierarchyItemTpl) {
		entityManager.persist(hierarchyItemTpl);
		return hierarchyItemTpl;
	}

	public HierarchyItemTpl update(HierarchyItemTpl hierarchyItemTpl) {
		entityManager.merge(hierarchyItemTpl);
		return hierarchyItemTpl;
	}

}
