package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class HeaderQueryDocuments {

	public static final String EN_SCANNEDNC_732 = "EN_SCANNEDNC_732";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "HeaderQueryDocuments";
	
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<Character> CLIENTTYPE = new Property<Character>("clientType", Character.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<Integer> PROCEDURE = new Property<Integer>("procedure", Integer.class, false);
	
	public static final Property<String> LOAN = new Property<String>("loan", String.class, false);
	
	public static final Property<String> DOCUMENTTYPE = new Property<String>("documentType", String.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
