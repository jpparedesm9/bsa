package com.cobiscorp.ecobis.bpl.dao.rules.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.rules.ConditionRuleDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.ConditionRule;

public class ConditionRuleDaoImpl implements ConditionRuleDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public void delete(ConditionRule conditionRule) {
		entityManager.remove(entityManager.merge(conditionRule));
	}

	@SuppressWarnings("unchecked")
	public List<ConditionRule> findByRuleVersion(Integer idRuleVersion) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT cr ");
		sql.append(" FROM   ConditionRule cr ");
		sql.append(" WHERE  cr.ruleVersion.id = :idRuleVersion ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idRuleVersion", idRuleVersion);
		
		return query.getResultList();
	}

}
