package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QueryDocumentsGrid {

	public static final String EN_DOCUMENTI_644 = "EN_DOCUMENTI_644";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QueryDocumentsGrid";
	
	
	public static final Property<Integer> PROCEDURE = new Property<Integer>("procedure", Integer.class, false);
	
	public static final Property<Character> ISGROUP = new Property<Character>("isGroup", Character.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<String> LOAN = new Property<String>("loan", String.class, false);
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
