package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerExclusionList {

	public static final String EN_CUSTOMENL_622 = "EN_CUSTOMENL_622";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerExclusionList";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Character> SCORE = new Property<Character>("score", Character.class, false);
	
	public static final Property<Integer> OPERATION = new Property<Integer>("operation", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
