package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyRolDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;

public class HierarchyRolDaoImpl implements HierarchyRolDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public HierarchyRol findById(Integer idHierarchyRol) {
		return entityManager.find(HierarchyRol.class, idHierarchyRol);
	}

	public HierarchyRol findByProcessVersionHierarchyAndRole(Integer idProcess, Short version, Integer idHierarchy, Integer idRole) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("HierarchyRol.findByProcessVersionHierarchyAndRole");
			query.setParameter("idProcess", idProcess);
			query.setParameter("versionProcess", version);
			query.setParameter("idHierarchy", idHierarchy);
			query.setParameter("idRole", idRole);
			return (HierarchyRol) query.getSingleResult();
		} catch (NoResultException nrex) {
			return null;
		} catch (NonUniqueResultException nurex) {
			return null;
		}
	}

	public HierarchyRol insert(HierarchyRol hierarchyRol) {
		entityManager.persist(hierarchyRol);
		return hierarchyRol;
	}

}
