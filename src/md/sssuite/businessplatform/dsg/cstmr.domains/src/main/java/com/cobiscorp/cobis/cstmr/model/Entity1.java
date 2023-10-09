package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Entity1 {

	public static final String EN_1CIXLMJPY_756 = "EN_1CIXLMJPY_756";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Entity1";
	
	
	public static final Property<Integer> CODIGO = new Property<Integer>("codigo", Integer.class, false);
	
	public static final Property<Boolean> REFRESHGRID = new Property<Boolean>("refreshGrid", Boolean.class, false);
	
	public static final Property<String> SCREENMODE = new Property<String>("screenMode", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
