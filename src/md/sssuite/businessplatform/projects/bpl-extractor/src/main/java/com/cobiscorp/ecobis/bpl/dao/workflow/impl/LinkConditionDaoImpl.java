package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.LinkConditionDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;

public class LinkConditionDaoImpl implements LinkConditionDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<LinkCondition> findByLink(Integer idLink) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT lc  FROM LinkCondition lc ");
		sql.append(" WHERE lc.link.idLink = :idLink ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idLink", idLink);

		return query.getResultList();

	}

	public LinkCondition save(LinkCondition linkCondition) throws Exception {
		entityManager.persist(linkCondition);
		return linkCondition;
	}

}
