package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class paymentsPaid {

	public static final String EN_PAMENTSAI291 = "EN_PAMENTSAI291";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "paymentsPaid";
	
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("rate", Double.class, false);
	
	public static final Property<String> TOTAL = new Property<String>("total", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
