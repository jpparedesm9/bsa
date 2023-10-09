package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Person {

	public static final String EN_PERSONUDL_767 = "EN_PERSONUDL_767";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Person";
	
	
	public static final Property<Character> STATUSCODE = new Property<Character>("statusCode", Character.class, false);
	
	public static final Property<String> FULLNAME = new Property<String>("fullName", String.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<Character> TYPEPERSON = new Property<Character>("typePerson", Character.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<String> SANTANDERCODE = new Property<String>("santanderCode", String.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("official", String.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
