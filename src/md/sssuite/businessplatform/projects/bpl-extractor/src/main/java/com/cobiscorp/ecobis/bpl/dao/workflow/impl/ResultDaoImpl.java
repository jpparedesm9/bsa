package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ResultDao;
import com.cobiscorp.ecobis.bpl.service.workflow.impl.StepServiceImpl;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;

public class ResultDaoImpl implements ResultDao {
	static HashMap<String, Result> hmResult = new LinkedHashMap<String, Result>();
	static Logger log = Logger.getLogger(StepServiceImpl.class);
	
	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Result findById(Integer idResult) {
		return entityManager.find(Result.class, idResult);
	}

	@SuppressWarnings("unchecked")
	public List<Result> findAllResults() throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Result.findAll");
			return (List<Result>) query.getResultList();
		} catch (NoResultException nrex) {
			return new ArrayList<Result>();
		}
	}

	public Result findResultByName(String name) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Result.findByName");
			query.setParameter("name", name);
			return (Result) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException e) {
			return null;
		}
	}

	public Result saveResult(Result result) throws Exception {
		entityManager.persist(result);
		entityManager.flush();
		return result;
	}

	public Result findAndSave(Result result, DriverManagerDataSource dataSource) throws Exception {
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		Result searchResult = hmResult.get(result.getName());
		if (searchResult == null) {
			searchResult = findResultByName(result.getName());
			if (searchResult == null) {
				result.setIdResult(seqnos.execute("wf_resultado"));
				log.debug("Result-------------------->"+result.getName());
				log.debug("Result-------------------->"+result.getIdResult());
				result = saveResult(result);
				hmResult.put(result.getName(), result);
				return result;
			} else {
				hmResult.put(searchResult.getName(), searchResult);
				return searchResult;
			}

		}

		return searchResult;
	}

}
