package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Item {

	public static final String EN_ITEMCAOVU_635 = "EN_ITEMCAOVU_635";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Item";
	
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
