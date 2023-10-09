package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Priorities {

	public static final String EN_PRIORITII_152 = "EN_PRIORITII_152";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Priorities";
	
	
	public static final Property<String> ITEM = new Property<String>("item", String.class, false);
	
	public static final Property<Integer> PRIORITY = new Property<Integer>("priority", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
