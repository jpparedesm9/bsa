package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class AgreedPayments {

	public static final String EN_AGEPAYMEN121 = "EN_AGEPAYMEN121";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AgreedPayments";
	
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("rate", Double.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
