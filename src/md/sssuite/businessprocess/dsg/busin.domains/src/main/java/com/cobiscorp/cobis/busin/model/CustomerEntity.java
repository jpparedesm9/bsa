package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerEntity {

	public static final String EN_ACCOUNTQW243 = "EN_ACCOUNTQW243";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerEntity";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<Integer> SUBSIDIARY = new Property<Integer>("Subsidiary", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
