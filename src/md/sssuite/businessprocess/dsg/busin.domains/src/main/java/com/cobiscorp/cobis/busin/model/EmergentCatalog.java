package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class EmergentCatalog {

	public static final String EN_EMGETALOG067 = "EN_EMGETALOG067";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EmergentCatalog";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
