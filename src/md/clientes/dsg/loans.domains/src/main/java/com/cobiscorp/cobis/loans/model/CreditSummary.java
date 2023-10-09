package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CreditSummary {

	public static final String EN_CREDITSMM_284 = "EN_CREDITSMM_284";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CreditSummary";
	
	
	public static final Property<Double> CURRENCYBALANCE = new Property<Double>("currencyBalance", Double.class, false);
	
	public static final Property<Double> PAYMENT = new Property<Double>("payment", Double.class, false);
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<Double> EXPIRED = new Property<Double>("expired", Double.class, false);
	
	public static final Property<Double> BEGINNINGBALANCE = new Property<Double>("beginningBalance", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
