package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanDebtor {

	public static final String EN_LOANDEBTO_749 = "EN_LOANDEBTO_749";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanDebtor";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerID", Integer.class, false);
	
	public static final Property<String> IDENTITYCARD = new Property<String>("identityCard", String.class, false);
	
	public static final Property<String> ROLE = new Property<String>("role", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> PHONE = new Property<String>("phone", String.class, false);
	
	public static final Property<String> ADDRESS = new Property<String>("address", String.class, false);
	
	public static final Property<String> CENTRALCOLLECTION = new Property<String>("centralCollection", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
