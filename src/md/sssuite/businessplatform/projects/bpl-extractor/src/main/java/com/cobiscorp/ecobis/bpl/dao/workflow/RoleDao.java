package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;

public interface RoleDao {

	static HashMap<String, Role> hmRole = new LinkedHashMap<String, Role>();

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
	Role findByName(String name);

	/**
	 * Recupera el Role por idRole
	 * 
	 * @return
	 */
	Role insert(Role role);
	

	void flush();

}
