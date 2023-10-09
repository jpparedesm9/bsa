package com.cobiscorp.notification.client.utils;

import java.util.HashMap;
import java.util.Map;

public class StoredProcedureParameters {

	private Map<String, Object> spParameters;
	
	public StoredProcedureParameters() {
		spParameters = new HashMap<>();
	}
	
	public Object getParameter(String parameterName) {
		return spParameters.get(parameterName);
	}

	public void addParameter(String name, Object value) {
		spParameters.put(name, value);
	}
	
	public Map<String,Object>getParameters(){
		return spParameters;
	}
	
	public void setParameters(Map<String,Object> parameters){
		this.spParameters = parameters;
	}
}