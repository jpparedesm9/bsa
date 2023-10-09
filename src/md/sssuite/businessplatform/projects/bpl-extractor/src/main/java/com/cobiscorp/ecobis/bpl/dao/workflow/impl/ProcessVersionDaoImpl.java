package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVersionDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public class ProcessVersionDaoImpl implements ProcessVersionDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVersionDao# findProductionProcessVersion()
	 */
	@SuppressWarnings("unchecked")
	public List<ProcessVersion> findProductionProcessVersion() {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT pv  FROM ProcessVersion pv ");
		sql.append(" WHERE pv.status = 'PRD' ");
		sql.append(" ORDER BY  pv.process.name ");

		Query query = entityManager.createQuery(sql.toString());

		return query.getResultList();

	}

	public ProcessVersion findProcessVersionById(Integer idProcess, Short versionProcess) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("ProcessVersion.findProcessVersionById");
			IdProcessVersion idProcessVersion = new IdProcessVersion();
			query.setParameter("idProcess", idProcess);
			query.setParameter("versionProcess", versionProcess);
			return (ProcessVersion) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public ProcessVersion findByNameAndStatus(String name, String status) {

		// Busco la maxima version de proceso
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT new ProcessVersion(MAX(pv.versionProcess)) FROM ProcessVersion pv ");
		sql.append(" WHERE  pv.status = :status ");
		sql.append(" AND    pv.process.name = :name ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("name", name);
		query.setParameter("status", status);

		List<ProcessVersion> processVersionList = query.getResultList();

		if (processVersionList.isEmpty()) {
			return null;
		}

		// Busco la Vesion de proceso ultima
		Short versionProcess = processVersionList.get(0).getVersionProcess();

		sql = new StringBuilder();
		sql.append(" SELECT pv  FROM ProcessVersion pv ");
		sql.append(" WHERE  pv.status = :status ");
		sql.append(" AND    pv.process.name = :name ");
		sql.append(" AND    pv.versionProcess = :versionProcess ");

		query = entityManager.createQuery(sql.toString());
		query.setParameter("name", name);
		query.setParameter("status", status);
		query.setParameter("versionProcess", versionProcess);

		processVersionList = query.getResultList();

		if (processVersionList.isEmpty()) {
			return null;
		}

		return processVersionList.get(0);
	}

	@SuppressWarnings("unchecked")
	public ProcessVersion findByName(String name) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT pv  FROM ProcessVersion pv ");
		sql.append(" AND    pv.process.name = :name ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("name", name);

		List<ProcessVersion> processVersionList = query.getResultList();

		if (processVersionList.isEmpty()) {
			return null;
		}

		return processVersionList.get(0);
	}

	@SuppressWarnings("unchecked")
	public ProcessVersion findLastVesionProcess(Integer idProcess) {

		// Busco la maxima version de proceso
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT MAX(pv.versionProcess) ");
		sql.append(" FROM  ProcessVersion pv ");
		sql.append(" WHERE pv.process.idProcess = :idProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);

		Short processVersion = (Short) query.getSingleResult();

		if (processVersion == null) {
			return null;
		}

		// Busco version en funcion del Porcess Version
		sql = new StringBuilder();
		sql.append(" SELECT pv  FROM ProcessVersion pv ");
		sql.append(" WHERE  pv.process.idProcess = :idProcess ");
		sql.append(" AND    pv.versionProcess = :versionProcess ");

		query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", new Short("" + processVersion));

		List<ProcessVersion> processVersionList = query.getResultList();

		if (processVersionList.isEmpty()) {
			return null;
		}
		return processVersionList.get(0);
	}

}
