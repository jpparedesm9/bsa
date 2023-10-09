package com.cobiscorp.ecobis.bpl.dao.cobis;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Component;

public interface ComponentDao {
	static HashMap<String, Component> hmComponent = new LinkedHashMap<String, Component>();

	

	Component findByName(String name) throws Exception;

	Component saveComponent(Component component) throws Exception;

	Component findAndSaveComponent(Component component, DriverManagerDataSource dataSource) throws Exception;

	Integer findMaxId() throws Exception;
}
