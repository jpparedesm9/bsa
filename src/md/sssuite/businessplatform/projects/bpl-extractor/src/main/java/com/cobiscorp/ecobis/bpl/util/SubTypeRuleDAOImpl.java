package com.cobiscorp.ecobis.bpl.util;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;

public class SubTypeRuleDAOImpl implements ISubTypeRuleDAO {

	// private static ILogger logger =
	// LogFactory.getLogger(RuleRoleDAOImpl.class);

	private EntityManager em;

	@PersistenceContext
	public void setEm(EntityManager em) {
		this.em = em;
	}

	public SubTypeRule find(int id) {
		return em.find(SubTypeRule.class, id);
	}

	public boolean insert(SubTypeRule subTypeRule) {
		try {
			em.persist(em.merge(subTypeRule));
		} catch (PersistenceException e) {
			return false;
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public List<SubTypeRule> findAll(Integer id) {

		List<SubTypeRule> subTypeRules = new ArrayList<SubTypeRule>();

		try {
			subTypeRules = (List<SubTypeRule>) em.createNamedQuery("SubTypeRule.getAllSubTypes", SubTypeRule.class).setParameter("id", id)
					.getResultList();
		} catch (Exception ex) {

			ex.printStackTrace();
		}
		return subTypeRules;
	}

	@SuppressWarnings("unchecked")
	public SubTypeRule findByAcronym(String acronym) {

		// Busco version en funcion del Porcess Version
		StringBuilder sql = new StringBuilder();
		sql = new StringBuilder();
		sql.append(" SELECT sr  FROM SubTypeRule sr ");
		sql.append(" WHERE  sr.acronym = :acronym ");

		Query query = em.createQuery(sql.toString());
		query.setParameter("acronym", acronym);

		List<SubTypeRule> subTypeRuleList = query.getResultList();

		if (subTypeRuleList.isEmpty()) {
			return null;
		}
		return subTypeRuleList.get(0);
	}

}
