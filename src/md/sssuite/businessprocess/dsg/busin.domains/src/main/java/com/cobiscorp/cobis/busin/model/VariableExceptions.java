package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class VariableExceptions {

	public static final String EN_ABLEECPTO836 = "EN_ABLEECPTO836";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "VariableExceptions";
	
	
	public static final Property<String> VARIABLENAME = new Property<String>("VariableName", String.class, false);
	
	public static final Property<String> VARIABLEVALUE = new Property<String>("VariableValue", String.class, false);
	
	public static final Property<String> VARIABLERULE = new Property<String>("VariableRule", String.class, false);
	
	public static final Property<String> VARIABLEDESCRIPTION = new Property<String>("VariableDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
