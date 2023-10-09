package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RelationContext {

	public static final String EN_RELATIONC_716 = "EN_RELATIONC_716";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RelationContext";
	
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<Integer> RELATIOID = new Property<Integer>("relatioId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
