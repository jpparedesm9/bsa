package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;

public interface ActivityDao {
	static HashMap<String, Activity> hmActivity = new LinkedHashMap<String, Activity>();

	Activity findByName(String name) throws Exception;

	Activity saveActivity(Activity activity) throws Exception;

	Activity findAndSaveActivity(Activity activity, DriverManagerDataSource dataSource) throws Exception;

}
