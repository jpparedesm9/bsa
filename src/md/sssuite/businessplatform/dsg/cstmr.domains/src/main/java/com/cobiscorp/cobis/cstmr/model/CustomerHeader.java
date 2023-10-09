package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerHeader {

	public static final String EN_CUSTOMERD_325 = "EN_CUSTOMERD_325";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerHeader";
	
	
	public static final Property<Integer> PERSONSEQUENTIAL = new Property<Integer>("personSequential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
