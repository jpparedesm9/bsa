package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QualificationRange {

	public static final String EN_QUALIFICA_678 = "EN_QUALIFICA_678";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QualificationRange";
	
	
	public static final Property<Integer> MAXVALUE = new Property<Integer>("maxValue", Integer.class, false);
	
	public static final Property<Integer> MINVALUE = new Property<Integer>("minValue", Integer.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
