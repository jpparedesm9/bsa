package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;

public interface RoleService {

	HashMap<String, Role> hmRole = new HashMap<String, Role>();

	/**
	 * Recupera el Role por idRole
	 * 
	 * @return
	 */
	Role findById(Integer idRole);

	/**
	 * Recupera el Role por idRole
	 * 
	 * @return
	 */
	Role findAndSave(Role role, DriverManagerDataSource dataSource);

}
