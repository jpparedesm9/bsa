package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.LoadBalanceDao;
import com.cobiscorp.ecobis.bpl.service.workflow.impl.AddresseeServiceImpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LoadBalance;

public class LoadBalanceDaoImpl implements LoadBalanceDao {
	@PersistenceContext
	private EntityManager entityManager;
	static Logger log = Logger.getLogger(LoadBalanceDao.class);

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public LoadBalance insert(LoadBalance loadBalance) {
		log.debug("1_SaveLoadBalance-----------------------------------> ");
		entityManager.persist(loadBalance);
		log.debug("2_SaveLoadBalance-----------------------------------> ");
		return loadBalance;
	}

	@SuppressWarnings("unchecked")
	public LoadBalance findByName(String name) {
		Query query = entityManager.createNamedQuery("LoadBalance.findByName");
		query.setParameter("name", name);
		List<LoadBalance> loadBalanceList = (List<LoadBalance>) query.getResultList();

		if (loadBalanceList.isEmpty()) {
			return null;
		} else {
			return loadBalanceList.get(0);
		}
	}
}
