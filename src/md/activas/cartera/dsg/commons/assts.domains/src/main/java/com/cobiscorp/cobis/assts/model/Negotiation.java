package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Negotiation {

	public static final String EN_NEGOTIATI_654 = "EN_NEGOTIATI_654";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Negotiation";
	
	
	public static final Property<String> PAYMENTTYPE = new Property<String>("paymentType", String.class, false);
	
	public static final Property<String> INTERESTTYPE = new Property<String>("interestType", String.class, false);
	
	public static final Property<Boolean> FULLFEE = new Property<Boolean>("fullFee", Boolean.class, false);
	
	public static final Property<Boolean> ADDITIONALPAYMENTS = new Property<Boolean>("additionalPayments", Boolean.class, false);
	
	public static final Property<String> CALCULATERETURN = new Property<String>("calculateReturn", String.class, false);
	
	public static final Property<String> REDUCTIONTYPE = new Property<String>("reductionType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
