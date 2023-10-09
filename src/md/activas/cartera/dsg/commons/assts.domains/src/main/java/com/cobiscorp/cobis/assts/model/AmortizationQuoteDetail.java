package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class AmortizationQuoteDetail {

	public static final String EN_AMORTIZIQ_340 = "EN_AMORTIZIQ_340";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AmortizationQuoteDetail";
	
	
	public static final Property<String> ITEM = new Property<String>("item", String.class, false);
	
	public static final Property<String> STATUSITEM = new Property<String>("statusItem", String.class, false);
	
	public static final Property<Integer> PERIOD = new Property<Integer>("period", Integer.class, false);
	
	public static final Property<BigDecimal> QUOTE = new Property<BigDecimal>("quote", BigDecimal.class, false);
	
	public static final Property<BigDecimal> GRACE = new Property<BigDecimal>("grace", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PAID = new Property<BigDecimal>("paid", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ACCUMULATED = new Property<BigDecimal>("accumulated", BigDecimal.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<String> TITLEFORM = new Property<String>("titleForm", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
