package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.VariableDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

public class VariableDaoImpl implements VariableDao {

	static Logger log = Logger.getLogger(VariableDaoImpl.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Variable findByAbreviaturaVariable(String abreviaturaVariable) {

		log.debug("-------------------------------------------->1");
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT new Variable(v.codigoVariable, v.descVariable, v.abreviaturaVariable, v.nombreVariable)  FROM Variable v ");
		sql.append(" WHERE  v.abreviaturaVariable = :abreviaturaVariable ");
		log.debug("-------------------------------------------->2");

		Query query = entityManager.createQuery(sql.toString());
		log.debug("-------------------------------------------->3");
		query.setParameter("abreviaturaVariable", abreviaturaVariable);
		log.debug("-------------------------------------------->4");

		List<Variable> variableList = query.getResultList();

		log.debug("-------------------------------------------->5");

		if (variableList.isEmpty()) {
			log.debug("-------------------------------------------->6");
			return null;
		}
		log.debug("-------------------------------------------->7" + variableList.get(0));
		log.debug("-------------------------------------------->8" + variableList.get(0).getAbreviaturaVariable());

		return variableList.get(0);
	}

	public Variable saveAndFlush(Variable variable) {
		log.debug("CODE_VARIABLE------------>"+variable.getCodigoVariable());
		log.debug("NAME_VARIABLE------------>"+variable.getNombreVariable());
		entityManager.persist(variable);
		log.debug("GUARDO------------------->");
		return variable;
	}

	public Variable findById(Short idVariable) {
		return entityManager.find(Variable.class, idVariable);
	}

}
