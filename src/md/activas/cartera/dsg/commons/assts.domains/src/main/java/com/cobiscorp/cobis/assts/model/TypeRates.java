package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class TypeRates {

	public static final String EN_VALUERATE_478 = "EN_VALUERATE_478";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TypeRates";
	
	
	public static final Property<String> IDENTIFIER = new Property<String>("identifier", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Character> CLASE = new Property<Character>("clase", Character.class, false);
	
	public static final Property<Character> RATEPIT = new Property<Character>("ratePit", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
