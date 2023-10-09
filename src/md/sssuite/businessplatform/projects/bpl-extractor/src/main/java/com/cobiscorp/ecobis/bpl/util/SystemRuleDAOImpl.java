package com.cobiscorp.ecobis.bpl.util;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.transaction.annotation.Transactional;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;

@Transactional
public class SystemRuleDAOImpl implements ISystemRuleDAO {

	// private static ILogger logger =
	// LogFactory.getLogger(RuleRoleDAOImpl.class);

	private EntityManager em;

	@PersistenceContext
	public void setEm(EntityManager em) {
		this.em = em;
	}

	public SystemRule find(int id) {
		return em.find(SystemRule.class, id);
	}

	public boolean insert(SystemRule systemRule) {
		try {
			em.merge(systemRule);
			em.flush();
		} catch (PersistenceException e) {
			throw e;
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public List<SystemRule> queryAllSystems() {
		List<SystemRule> systemRule = new ArrayList<SystemRule>();

		try {
			// logger.logInfo("Ingreso a queryRolesDescription");

			systemRule = (List<SystemRule>) em.createNamedQuery("SystemRule.getAllSystems", SystemRule.class).getResultList();

		} catch (Exception ex) {
			// logger.logInfo("Fallo en queryRoleDescription");
			// throw new BusinessException(7300001, "No se pudo obtener el valor de la calificación del cliente.");
		} finally {
			// logger.logInfo("Fallo en queryRoleDescription");
		}
		return systemRule;

	}

	@SuppressWarnings("unchecked")
	public SystemRule findByAcronym(String acronym) {

		// Busco version en funcion del Porcess Version
		StringBuilder sql = new StringBuilder();
		sql = new StringBuilder();
		sql.append(" SELECT sr  FROM SystemRule sr ");
		sql.append(" WHERE  sr.acronym = :acronym ");

		Query query = em.createQuery(sql.toString());
		query.setParameter("acronym", acronym);

		List<SystemRule> systemRuleList = query.getResultList();

		if (systemRuleList.isEmpty()) {
			return null;
		}
		return systemRuleList.get(0);
	}
}
