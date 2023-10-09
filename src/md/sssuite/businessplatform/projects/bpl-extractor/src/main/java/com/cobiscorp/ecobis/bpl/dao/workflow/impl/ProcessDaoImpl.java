package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;

public class ProcessDaoImpl implements ProcessDao {
	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Process insert(Process process) {
		entityManager.persist(process);
		entityManager.flush();
		return process;
	}

	public void flush() {
		entityManager.flush();
	}

	public Process update(Process process) {
		entityManager.merge(process);
		entityManager.flush();
		return process;
	}

	@SuppressWarnings("unchecked")
	public Process findByName(String name) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT p  FROM Process p ");
		sql.append(" WHERE  p.name = :name ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("name", name);

		List<Process> processList = query.getResultList();

		for (Process process : processList) {
			process.getListProcessVersion().size();
		}

		if (processList.isEmpty()) {
			return null;
		}

		return processList.get(0);
	}

}
