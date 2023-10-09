package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class VariableData {

	public static final String EN_ARIABLETA489 = "EN_ARIABLETA489";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "VariableData";
	
	
	public static final Property<String> IDFIELDVARIABLEDATA = new Property<String>("IdFieldVariableData", String.class, false);
	
	public static final Property<String> FIELD = new Property<String>("Field", String.class, false);
	
	public static final Property<String> VALUE = new Property<String>("Value", String.class, false);
	
	public static final Property<String> MANDATORY = new Property<String>("Mandatory", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
