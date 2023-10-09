package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerReference {

	public static final String EN_TOMREFREC822 = "EN_TOMREFREC822";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerReference";
	
	
	public static final Property<String> VERIFYDATA = new Property<String>("VerifyData", String.class, false);
	
	public static final Property<String> DATEVERIFICATION = new Property<String>("DateVerification", String.class, false);
	
	public static final Property<String> USERVERIFICATION = new Property<String>("UserVerification", String.class, false);
	
	public static final Property<Character> RESULT = new Property<Character>("Result", Character.class, false);
	
	public static final Property<Integer> IDCUSTOMER = new Property<Integer>("IdCustomer", Integer.class, false);
	
	public static final Property<Character> EFFECTIVEDATE = new Property<Character>("EffectiveDate", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
