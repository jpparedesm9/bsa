package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;

public interface ActivityService {
	static HashMap<String, Activity> hmActivity = new LinkedHashMap<String, Activity>();

	Activity findByName(String name) throws Exception;

	Activity saveActivity(Activity activity) throws Exception;

	Activity findAndSave(Activity activity, DriverManagerDataSource dataSource) throws Exception;
}
