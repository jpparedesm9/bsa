package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Official {

	public static final String EN_OFFICIALN156 = "EN_OFFICIALN156";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Official";
	
	
	public static final Property<String> OFFICIAL = new Property<String>("Official", String.class, false);
	
	public static final Property<Integer> DESTINATARIO = new Property<Integer>("Destinatario", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
