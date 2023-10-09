package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MaintenanceCatalog {

	public static final String EN_AENCECTLG231 = "EN_AENCECTLG231";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MaintenanceCatalog";
	
	
	public static final Property<String> CATALOG = new Property<String>("Catalog", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
