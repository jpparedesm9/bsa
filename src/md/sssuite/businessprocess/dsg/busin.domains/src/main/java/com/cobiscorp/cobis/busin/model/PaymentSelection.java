package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PaymentSelection {

	public static final String EN_PAYMENTEO_668 = "EN_PAYMENTEO_668";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentSelection";
	
	
	public static final Property<String> SELECTEDTYPE = new Property<String>("selectedType", String.class, false);
	
	public static final Property<String> GROUPID = new Property<String>("groupId", String.class, false);
	
	public static final Property<String> TRANSACTIONNUMBER = new Property<String>("transactionNumber", String.class, false);
	
	public static final Property<String> CREDITTYPE = new Property<String>("creditType", String.class, false);

	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
