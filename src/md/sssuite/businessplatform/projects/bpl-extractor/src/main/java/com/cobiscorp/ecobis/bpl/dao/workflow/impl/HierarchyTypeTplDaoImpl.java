package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyTypeTplDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;

public class HierarchyTypeTplDaoImpl implements HierarchyTypeTplDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemDao#findByHierarchyItemStep(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public HierarchyTypeTpl findById(Integer idHierarchyTypeTpl) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT htt  FROM HierarchyTypeTpl htt ");
		sql.append(" WHERE  htt.idHierarchyTypeTpl = :idHierarchyTypeTpl ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idHierarchyTypeTpl", idHierarchyTypeTpl);

		List<HierarchyTypeTpl> hierarchyTypeTplList = query.getResultList();

		if (hierarchyTypeTplList.isEmpty()) {
			return null;
		}

		return hierarchyTypeTplList.get(0);
	}

	@SuppressWarnings("unchecked")
	public HierarchyTypeTpl findByName(String name) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT htt  FROM HierarchyTypeTpl htt ");
		sql.append(" WHERE  htt.name = :name ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("name", name);

		List<HierarchyTypeTpl> hierarchyTypeTplList = query.getResultList();

		if (hierarchyTypeTplList.isEmpty()) {
			return null;
		}

		return hierarchyTypeTplList.get(0);
	}

	public HierarchyTypeTpl insert(HierarchyTypeTpl hierarchyItemTpl) {
		entityManager.persist(hierarchyItemTpl);
		return hierarchyItemTpl;
	}

	public HierarchyTypeTpl update(HierarchyTypeTpl hierarchyItemTpl) {
		entityManager.merge(hierarchyItemTpl);
		return hierarchyItemTpl;
	}

}
