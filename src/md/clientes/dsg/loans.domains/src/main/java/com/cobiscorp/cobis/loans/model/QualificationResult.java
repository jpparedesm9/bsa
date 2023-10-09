package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QualificationResult {

	public static final String EN_QUALIFICL_379 = "EN_QUALIFICL_379";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QualificationResult";
	
	
	public static final Property<String> LEVEL = new Property<String>("level", String.class, false);
	
	public static final Property<Integer> POINTS = new Property<Integer>("points", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
