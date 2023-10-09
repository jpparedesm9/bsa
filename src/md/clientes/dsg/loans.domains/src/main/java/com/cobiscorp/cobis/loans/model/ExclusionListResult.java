package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ExclusionListResult {

	public static final String EN_EXCLUSIIL_143 = "EN_EXCLUSIIL_143";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExclusionListResult";
	
	
	public static final Property<String> RFC = new Property<String>("rfc", String.class, false);
	
	public static final Property<String> CURP = new Property<String>("curp", String.class, false);
	
	public static final Property<Character> SCORE = new Property<Character>("score", Character.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
