package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.LinkDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;

public class LinkDaoImpl implements LinkDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.LinkDao#findLinkByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	@SuppressWarnings("unchecked")
	public List<Link> findLinkByProcessVersion(Integer idProcess, Short version) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT l  FROM Link l ");
		sql.append(" WHERE l.idProcess = :idProcess ");
		sql.append(" AND   l.version = :version ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("version", version);

		return query.getResultList();
	}
	
	public Link save(Link link) throws Exception{
		entityManager.persist(link);
		return link;
	}

}
