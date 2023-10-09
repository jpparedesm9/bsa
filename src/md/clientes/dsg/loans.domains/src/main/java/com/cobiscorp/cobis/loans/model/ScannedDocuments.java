package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ScannedDocuments {

	public static final String EN_DEBTORTAZ_977 = "EN_DEBTORTAZ_977";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ScannedDocuments";
	
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> MEMBERS = new Property<String>("members", String.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
