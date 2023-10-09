package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerTmpReferences {

	public static final String EN_CUSTOMEES_385 = "EN_CUSTOMEES_385";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerTmpReferences";
	
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
