package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;

public class HierarchyDaoImpl implements HierarchyDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<Hierarchy> findHierarchyByProcessVersion(Integer idProcess, Short version) {
		StringBuilder sql = new StringBuilder();

		sql.append(" SELECT h FROM Hierarchy h ");
		sql.append(" WHERE h.idProcess = :idProcess ");
		sql.append(" AND h.version = :version ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("version", version);

		return query.getResultList();
	}

	public Hierarchy findById(Integer idHierarchy) {
		return entityManager.find(Hierarchy.class, idHierarchy);
	}

	public Hierarchy insert(Hierarchy hierarchy) {
		entityManager.persist(hierarchy);
		return hierarchy;
	}

	public Hierarchy findHierarchyByProcessVersionAndName(Integer idProcess, Short version, String hierarchyName) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Hierarchy.findByProcessVersionAndName");
			query.setParameter("idProcess", idProcess);
			query.setParameter("version", version);
			query.setParameter("name", hierarchyName);
			return (Hierarchy) query.getSingleResult();
		} catch (NoResultException nrex) {
			return null;
		} catch (NonUniqueResultException nurex) {
			return null;
		}

	}

}
