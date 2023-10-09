package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Address {

	public static final String EN_ADDRESSUA698 = "EN_ADDRESSUA698";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Address";
	
	
	public static final Property<String> CUSTOMER = new Property<String>("Customer", String.class, false);
	
	public static final Property<String> ADDRESSDESCRIPTION = new Property<String>("AddressDescription", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> NEIGHBORHOOD = new Property<String>("Neighborhood", String.class, false);
	
	public static final Property<String> HOME = new Property<String>("Home", String.class, false);
	
	public static final Property<String> STREET = new Property<String>("Street", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("Reference", String.class, false);
	
	public static final Property<String> BUILDING = new Property<String>("Building", String.class, false);
	
	public static final Property<String> PRINCIPAL = new Property<String>("Principal", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
