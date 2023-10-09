package com.cobiscorp.cobis.bmtrc.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ValidationData {

	public static final String EN_VALIDATOA_518 = "EN_VALIDATOA_518";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ValidationData";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<String> USERKEY = new Property<String>("userKey", String.class, false);
	
	public static final Property<String> RESULTVALIDATION = new Property<String>("resultValidation", String.class, false);
	
	public static final Property<String> CUSTOMERTYPE = new Property<String>("customerType", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<Integer> CYCLENUMBER = new Property<Integer>("cycleNumber", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
