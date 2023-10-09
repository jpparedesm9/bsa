package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.LoadBalanceDao;
import com.cobiscorp.ecobis.bpl.service.workflow.LoadBalanceService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LoadBalance;

public class LoadBalanceServiceImpl implements LoadBalanceService {

	private LoadBalanceDao loadBalanceDao;
	static Logger log = Logger.getLogger(LoadBalanceService.class);

	/**
	 * @return the loadBalanceDao
	 */
	public LoadBalanceDao getLoadBalanceDao() {
		return loadBalanceDao;
	}

	/**
	 * @param loadBalanceDao
	 *            the loadBalanceDao to set
	 */
	public void setLoadBalanceDao(LoadBalanceDao loadBalanceDao) {
		this.loadBalanceDao = loadBalanceDao;
	}

	public LoadBalance findByName(String name) {
		return loadBalanceDao.findByName(name);
	}

	public LoadBalance save(LoadBalance loadBalance) {
		return loadBalanceDao.insert(loadBalance);
	}

	public LoadBalance findAndSave(LoadBalance loadBalance, DriverManagerDataSource dataSource) {

		LoadBalance loadBalanceSearch = hmLoadBalance.get(loadBalance.getName());
		
		log.debug("1_LoadBalanceServiceImpl-----------------------------------> ");

		if (loadBalanceSearch == null) {
			
			log.debug("2_LoadBalanceServiceImpl-----------------------------------> ");

			loadBalanceSearch = loadBalanceDao.findByName(loadBalance.getName());
			log.debug("3_LoadBalanceServiceImpl-----------------------------------> ");
			if (loadBalanceSearch == null) {
				
				log.debug("4_LoadBalanceServiceImpl-----------------------------------> ");

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
				loadBalanceSearch = new LoadBalance();
				log.debug("5_LoadBalanceServiceImpl-----------------------------------> ");
				loadBalanceSearch.setIdLoadBalance(seqnos.execute("wf_dist_carga"));
				loadBalanceSearch.setName(loadBalance.getName());
				loadBalanceSearch.setDescription(loadBalance.getDescription());
				loadBalanceSearch.setSp(loadBalance.getSp());

				log.debug("6_LoadBalanceServiceImpl-----------------------------------> ");
				loadBalanceSearch = save(loadBalanceSearch);
				log.debug("7_LoadBalanceServiceImpl-----------------------------------> ");
			}
			log.debug("8_LoadBalanceServiceImpl-----------------------------------> ");
			hmLoadBalance.put(loadBalance.getName(), loadBalanceSearch);
			log.debug("9_LoadBalanceServiceImpl-----------------------------------> ");
		}
		return loadBalanceSearch;
	}
}
