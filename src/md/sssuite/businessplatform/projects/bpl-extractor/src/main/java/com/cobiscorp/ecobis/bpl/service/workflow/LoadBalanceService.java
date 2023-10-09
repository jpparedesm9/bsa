package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.LoadBalance;

public interface LoadBalanceService {
	HashMap<String, LoadBalance> hmLoadBalance = new HashMap<String, LoadBalance>();

	LoadBalance findByName(String name);

	LoadBalance save(LoadBalance loadBalance);

	LoadBalance findAndSave(LoadBalance loadBalance, DriverManagerDataSource dataSource);
}
