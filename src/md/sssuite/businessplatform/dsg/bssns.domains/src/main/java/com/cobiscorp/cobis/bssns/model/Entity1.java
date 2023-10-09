package com.cobiscorp.cobis.bssns.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Entity1 {

	public static final String EN_1OMXLHKZV_316 = "EN_1OMXLHKZV_316";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Entity1";
	
	
	public static final Property<String> ATTRIBUTE1 = new Property<String>("attribute1", String.class, false);
	
	public static final Property<String> ATTRIBUTE2 = new Property<String>("attribute2", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
