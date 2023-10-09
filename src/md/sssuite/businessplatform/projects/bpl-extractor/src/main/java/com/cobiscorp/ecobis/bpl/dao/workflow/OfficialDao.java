package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Official;

public interface OfficialDao {

	/**
	 * Recupera los Official por login
	 * 
	 * @return
	 */
	Official findByLogin(String login);

}
