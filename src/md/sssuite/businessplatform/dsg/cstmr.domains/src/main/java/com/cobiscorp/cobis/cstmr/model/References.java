package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class References {

	public static final String EN_REFERENES_825 = "EN_REFERENES_825";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "References";
	
	
	public static final Property<String> FIRSTLASTNAME = new Property<String>("firstLastName", String.class, false);
	
	public static final Property<String> OFFICEPHONE = new Property<String>("officePhone", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> CELLPHONE = new Property<String>("cellPhone", String.class, false);
	
	public static final Property<String> POSTALCODE = new Property<String>("postalCode", String.class, false);
	
	public static final Property<String> COUNTRY = new Property<String>("country", String.class, false);
	
	public static final Property<String> MUNICIPALITY = new Property<String>("municipality", String.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<String> HOMEPHONE = new Property<String>("homePhone", String.class, false);
	
	public static final Property<Integer> KNOWNTIME = new Property<Integer>("knownTime", Integer.class, false);
	
	public static final Property<String> NEIGHBORHOOD = new Property<String>("neighborhood", String.class, false);
	
	public static final Property<String> EMAIL = new Property<String>("email", String.class, false);
	
	public static final Property<String> RELATIONSHIP = new Property<String>("relationship", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> COLONY = new Property<String>("colony", String.class, false);
	
	public static final Property<String> ADDRESS = new Property<String>("address", String.class, false);
	
	public static final Property<String> LOCATIONS = new Property<String>("locations", String.class, false);
	
	public static final Property<Integer> REFERENCES = new Property<Integer>("references", Integer.class, false);
	
	public static final Property<String> NAMES = new Property<String>("names", String.class, false);
	
	public static final Property<String> SECONDLASTNAME = new Property<String>("secondLastName", String.class, false);
	
	public static final Property<Integer> NUMBEROFREFERENCES = new Property<Integer>("numberOfReferences", Integer.class, false);
	
	public static final Property<String> STREET = new Property<String>("street", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
