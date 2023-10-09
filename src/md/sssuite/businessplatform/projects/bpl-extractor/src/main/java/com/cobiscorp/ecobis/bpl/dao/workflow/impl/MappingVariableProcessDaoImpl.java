package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.MappingVariableProcessDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;

public class MappingVariableProcessDaoImpl implements MappingVariableProcessDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.MappingVariableProcessDao#findMappingVariableProcessByProcessVersion(java.lang.Integer,
	 * java.lang.Short)
	 */
	@SuppressWarnings("unchecked")
	public List<MappingVariableProcess> findMappingVariableProcessByProcessVersion(Integer idProcess, Short versionProcess) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT mvp FROM MappingVariableProcess mvp ");
		sql.append(" WHERE mvp.idProcess = :idProcess ");
		sql.append(" AND mvp.versionProcess = :versionProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);

		return query.getResultList();

	}

}
