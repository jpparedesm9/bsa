package com.cobiscorp.ecobis.bpl.util;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;

public class ExceptionRuleDAOImpl implements ExceptionRuleDAO {

	private EntityManager entityManager;

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {

		this.entityManager = entityManager;
	}

	public RuleException find(int id) {

		return entityManager.find(RuleException.class, id);

	}

	public RuleException insert(RuleException ruleException) {

		try {
			entityManager.persist(ruleException);

			return ruleException;

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return ruleException;
	}

	public List<RuleException> findAll(Integer id) {

		List<RuleException> ruleException = new ArrayList<RuleException>();

		try {
			ruleException = (List<RuleException>) entityManager.createNamedQuery("RuleException.getAllExceptions", RuleException.class)
					.setParameter("id", id).getResultList();
		} catch (Exception ex) {

			ex.printStackTrace();
		}
		return ruleException;
	}

}
