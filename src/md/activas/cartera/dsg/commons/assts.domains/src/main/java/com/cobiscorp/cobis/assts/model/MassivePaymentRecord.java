package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MassivePaymentRecord {

	public static final String EN_MASSIVEEM_261 = "EN_MASSIVEEM_261";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MassivePaymentRecord";
	
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> PAYMENTDATE = new Property<String>("paymentDate", String.class, false);
	
	public static final Property<Integer> ROWNUMBER = new Property<Integer>("rowNumber", Integer.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("observations", String.class, false);
	
	public static final Property<String> AMOUNT = new Property<String>("amount", String.class, false);
	
	public static final Property<String> PAYMENTMETHOD = new Property<String>("paymentMethod", String.class, false);
	
	public static final Property<String> CORRESPONSALCODE = new Property<String>("corresponsalCode", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
