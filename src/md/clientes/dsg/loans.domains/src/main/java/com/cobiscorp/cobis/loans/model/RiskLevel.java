package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RiskLevel {

	public static final String EN_RISKLEVEE_994 = "EN_RISKLEVEE_994";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RiskLevel";
	
	
	public static final Property<Integer> POINTS = new Property<Integer>("points", Integer.class, false);
	
	public static final Property<String> VARIABLENAME = new Property<String>("variableName", String.class, false);
	
	public static final Property<String> LEVEL = new Property<String>("level", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
