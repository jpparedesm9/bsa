package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Phone {

	public static final String EN_PHONEBPJM_911 = "EN_PHONEBPJM_911";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Phone";
	
	
	public static final Property<String> ISCHECKED = new Property<String>("isChecked", String.class, false);
	
	public static final Property<String> PHONENUMBER = new Property<String>("phoneNumber", String.class, false);
	
	public static final Property<String> PHONETYPE = new Property<String>("phoneType", String.class, false);
	
	public static final Property<String> AREACODE = new Property<String>("areaCode", String.class, false);
	
	public static final Property<Integer> PHONEID = new Property<Integer>("phoneId", Integer.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<Integer> ADDRESSID = new Property<Integer>("addressId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
