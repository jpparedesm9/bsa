package com.cobiscorp.ecobis.bpl.dao.rules.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.rules.RuleDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

public class RuleDaoImpl implements RuleDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public Rule findByAcronym(String acronym) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT r ");
		sql.append(" FROM   Rule r ");
		sql.append(" WHERE  r.name = :acronym ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("acronym", acronym);
		List<Rule> ruleList = query.getResultList();

		if (ruleList.isEmpty()) {
			return null;
		}

		return ruleList.get(0);
	}

	public void detach(Rule rule) {
		entityManager.detach(rule);
	}

	public Rule insert(Rule rule) {
		entityManager.persist(rule);
		return rule;
	}

	public Rule update(Rule rule) {
		entityManager.merge(rule);
		return rule;
	}

}
