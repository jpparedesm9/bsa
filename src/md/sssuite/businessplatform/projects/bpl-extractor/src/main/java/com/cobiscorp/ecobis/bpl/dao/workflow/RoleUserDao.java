package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser;

public interface RoleUserDao {

	/**
	 * Inserta el rolUser
	 * 
	 * @return
	 */
	RoleUser insert(RoleUser roleUser);

	/**
	 * @param login
	 * @return
	 */
	RoleUser findByLogin(String login);

}
