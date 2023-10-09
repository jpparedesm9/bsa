package com.cobiscorp.ecobis.bpl.dao.rules.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.rules.RuleVersionDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;

public class RuleVersionDaoImpl implements RuleVersionDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public RuleVersion findLastVesionProcess(Integer idRule) {

		// Busco la maxima version de proceso
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT MAX(rv.version) ");
		sql.append(" FROM  RuleVersion rv ");
		sql.append(" WHERE rv.rule.id = :idRule ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idRule", idRule);

		Integer version = (Integer) query.getSingleResult();

		if (version == null) {
			return null;
		}

		// Busco version en funcion del Porcess Version
		sql = new StringBuilder();
		sql.append(" SELECT rv  FROM RuleVersion rv ");
		sql.append(" WHERE  rv.rule.id = :idRule ");
		sql.append(" AND    rv.version = :version ");

		query = entityManager.createQuery(sql.toString());
		query.setParameter("idRule", idRule);
		query.setParameter("version", version);

		List<RuleVersion> ruleVersionList = query.getResultList();

		if (ruleVersionList.isEmpty()) {
			return null;
		}
		return ruleVersionList.get(0);
	}

	public void delete(RuleVersion ruleVersion) {
		entityManager.remove(entityManager.merge(ruleVersion));
	}

	public RuleVersion update(RuleVersion ruleVersion) {
		entityManager.merge(ruleVersion);
		return ruleVersion;
	}
}
