package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CentralInternalReasons {

	public static final String EN_CIRARESOS228 = "EN_CIRARESOS228";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CentralInternalReasons";
	
	
	public static final Property<Integer> IDCUSTOMER = new Property<Integer>("IdCustomer", Integer.class, false);
	
	public static final Property<String> ROLE = new Property<String>("Role", String.class, false);
	
	public static final Property<String> REASON = new Property<String>("Reason", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
