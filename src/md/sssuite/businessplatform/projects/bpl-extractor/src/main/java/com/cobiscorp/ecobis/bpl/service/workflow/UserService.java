package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public interface UserService {

	HashMap<String, User> hmUser = new HashMap<String, User>();

	/**
	 * Recupera el User por idUser
	 * 
	 * @return
	 */
	User findById(Integer idUser);

	/**
	 * Recupera el User por idUser
	 * 
	 * @return
	 */
	User findAndSave(User user, DriverManagerDataSource dataSource);

}
