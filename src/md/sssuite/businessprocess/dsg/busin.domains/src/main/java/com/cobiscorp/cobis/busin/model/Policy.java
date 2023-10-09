package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Policy {

	public static final String EN_POLICYKGO965 = "EN_POLICYKGO965";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Policy";
	
	
	public static final Property<String> MNEMONIC = new Property<String>("mnemonic", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> RESULT = new Property<String>("result", String.class, false);
	
	public static final Property<String> DETAIL = new Property<String>("detail", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
