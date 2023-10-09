package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class WarrantyDescription {

	public static final String EN_WARRANTEI_906 = "EN_WARRANTEI_906";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantyDescription";
	
	
	public static final Property<String> REASON = new Property<String>("reason", String.class, false);
	
	public static final Property<String> PERIODICITY = new Property<String>("periodicity", String.class, false);
	
	public static final Property<Character> CONTROLVISIT = new Property<Character>("controlVisit", Character.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
