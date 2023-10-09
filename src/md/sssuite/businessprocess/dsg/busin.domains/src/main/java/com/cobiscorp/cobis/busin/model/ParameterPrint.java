package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ParameterPrint {

	public static final String EN_AMETERINT997 = "EN_AMETERINT997";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ParameterPrint";
	
	
	public static final Property<String> NAMEMANAGER = new Property<String>("nameManager", String.class, false);
	
	public static final Property<String> CITY = new Property<String>("city", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
