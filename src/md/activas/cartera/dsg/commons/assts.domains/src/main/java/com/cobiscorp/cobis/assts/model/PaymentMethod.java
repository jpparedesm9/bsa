package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PaymentMethod {

	public static final String EN_PAYMENTOT_664 = "EN_PAYMENTOT_664";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentMethod";
	
	
	public static final Property<String> PRODUCT = new Property<String>("product", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final Property<Integer> RETENTION = new Property<Integer>("retention", Integer.class, false);
	
	public static final Property<String> COBISPRODUCT = new Property<String>("cobisProduct", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
