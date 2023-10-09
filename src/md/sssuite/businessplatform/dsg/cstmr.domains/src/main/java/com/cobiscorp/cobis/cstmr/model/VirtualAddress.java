package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class VirtualAddress {

	public static final String EN_PHYSICADS_566 = "EN_PHYSICADS_566";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "VirtualAddress";
	
	
	public static final Property<String> ADDRESSTYPEDESCRIPTION = new Property<String>("addressTypeDescription", String.class, false);
	
	public static final Property<Integer> ADDRESSID = new Property<Integer>("addressId", Integer.class, false);
	
	public static final Property<String> ADDRESSTYPE = new Property<String>("addressType", String.class, false);
	
	public static final Property<String> ADDRESSDESCRIPTION = new Property<String>("addressDescription", String.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> ISCHECKED = new Property<String>("isChecked", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
