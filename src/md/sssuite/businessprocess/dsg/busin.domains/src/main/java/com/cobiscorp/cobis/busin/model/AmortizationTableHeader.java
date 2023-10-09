package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AmortizationTableHeader {

	public static final String EN_ZTOTBEEAD288 = "EN_ZTOTBEEAD288";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AmortizationTableHeader";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("rate", Double.class, false);
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
