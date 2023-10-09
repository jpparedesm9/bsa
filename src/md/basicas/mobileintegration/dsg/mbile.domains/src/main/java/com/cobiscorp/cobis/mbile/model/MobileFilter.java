package com.cobiscorp.cobis.mbile.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MobileFilter {

	public static final String EN_MOBILEFLE_971 = "EN_MOBILEFLE_971";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MobileFilter";
	
	
	public static final Property<String> OFFICIAL = new Property<String>("official", String.class, false);
	
	public static final Property<String> IMEI = new Property<String>("imei", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
