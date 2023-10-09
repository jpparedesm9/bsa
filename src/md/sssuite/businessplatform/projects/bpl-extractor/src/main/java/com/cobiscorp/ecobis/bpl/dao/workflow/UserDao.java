package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public interface UserDao {

	/**
	 * Recupera el User por idUser
	 * 
	 * @return
	 */
	User findById(Integer idUser);

	/**
	 * findByLogin
	 * 
	 * @param login
	 * @return
	 */
	User findByLogin(String login);

	/**
	 * insert
	 * 
	 * @return
	 */
	User insert(User user);

}
