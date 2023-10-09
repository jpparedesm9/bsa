package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.RequirementDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ResultDao;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Requirement;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public class RequirementDaoImpl implements RequirementDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public List<Requirement> findAllRequirements() throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Requirement.findAll");
			return (List<Requirement>) query.getResultList();
		} catch (NoResultException nrex) {
			return new ArrayList<Requirement>();
		}

	}

	public Requirement findRequirementByName(String name) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Requirement.findByName");
			query.setParameter("name", name);
			return (Requirement) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException e) {
			return null;
		}
	}

	public Requirement saveRequirement(Requirement requirement) throws Exception {
		entityManager.persist(requirement);
		return requirement;
	}

	public Requirement findAndSave(Requirement requirement, DriverManagerDataSource dataSource) throws Exception {
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		Requirement searchRequirement = hmRequirement.get(requirement.getName());
		if (searchRequirement == null) {
			searchRequirement = findRequirementByName(requirement.getName());
			if (searchRequirement == null) {
				requirement.setIdRequirement(seqnos.execute("wf_tipo_documento"));
				requirement = saveRequirement(requirement);
				hmRequirement.put(requirement.getName(), requirement);
				return requirement;
			} else {
				hmRequirement.put(searchRequirement.getName(), searchRequirement);
				return searchRequirement;
			}

		}

		return searchRequirement;
	}

}
