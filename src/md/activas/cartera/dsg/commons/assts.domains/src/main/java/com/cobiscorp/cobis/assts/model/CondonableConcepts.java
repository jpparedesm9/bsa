package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CondonableConcepts {

	public static final String EN_CONDONAOB_448 = "EN_CONDONAOB_448";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CondonableConcepts";
	
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
