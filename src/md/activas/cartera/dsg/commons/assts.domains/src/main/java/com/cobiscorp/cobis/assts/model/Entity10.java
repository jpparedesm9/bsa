package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Entity10 {

	public static final String EN_10DNYMDPG_710 = "EN_10DNYMDPG_710";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Entity10";
	
	
	public static final Property<String> ATTRIBUTE1 = new Property<String>("Attribute1", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
