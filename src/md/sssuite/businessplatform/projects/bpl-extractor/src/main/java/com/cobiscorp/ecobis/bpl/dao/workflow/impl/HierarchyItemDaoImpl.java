package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItem;

public class HierarchyItemDaoImpl implements HierarchyItemDao {

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
	public List<HierarchyItem> findByHierarchyItemStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT hi  FROM HierarchyItem hi ");
		sql.append(" JOIN   FETCH hi.hierarchyItemTpl ");
		sql.append(" JOIN   FETCH hi.hierarchyItemTpl.hierarchyTypeTpl ");
		sql.append(" WHERE  hi.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

}
