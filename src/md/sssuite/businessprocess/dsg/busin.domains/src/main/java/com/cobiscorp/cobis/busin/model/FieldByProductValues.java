package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class FieldByProductValues {

	public static final String EN_EYPRODULE548 = "EN_EYPRODULE548";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "FieldByProductValues";
	
	
	public static final Property<String> REQUESTID = new Property<String>("requestId", String.class, false);
	
	public static final Property<String> PRODUCTID = new Property<String>("productId", String.class, false);
	
	public static final Property<Integer> FIELDID = new Property<Integer>("fieldId", Integer.class, false);
	
	public static final Property<String> VALUE = new Property<String>("value", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
