package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.LoadBalance;

public interface LoadBalanceDao {

	LoadBalance findByName(String name);

	LoadBalance insert(LoadBalance loadBalance);

}
