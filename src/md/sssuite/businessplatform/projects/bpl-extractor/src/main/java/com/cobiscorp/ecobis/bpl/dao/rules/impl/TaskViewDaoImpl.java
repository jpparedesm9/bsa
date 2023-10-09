package com.cobiscorp.ecobis.bpl.dao.rules.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.rules.TaskViewDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;

public class TaskViewDaoImpl implements TaskViewDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<TaskView> findTaskViewByProcessVersion(Integer idProcess, Short versionProcess) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT tv  FROM TaskView tv ");
		sql.append(" LEFT JOIN tv.component c ");
		sql.append(" LEFT JOIN tv.componentDetail cd ");
		sql.append(" LEFT JOIN tv.activity  a ");
		sql.append(" WHERE  tv.idProcess = :idProcess ");
		sql.append(" AND    tv.versionProcess = :versionProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);

		return query.getResultList();

	}

}
