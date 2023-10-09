package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CreditHeader {

	public static final String EN_CREDITHAD_216 = "EN_CREDITHAD_216";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CreditHeader";
	
	
	public static final Property<Integer> CREDITCODE = new Property<Integer>("creditCode", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
