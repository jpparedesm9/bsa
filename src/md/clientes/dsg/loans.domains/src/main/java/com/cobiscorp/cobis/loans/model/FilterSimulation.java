package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class FilterSimulation {

	public static final String EN_FILTERSIA_640 = "EN_FILTERSIA_640";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "FilterSimulation";
	
	
	public static final Property<String> NAMECLIENT = new Property<String>("nameClient", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTREQUEST = new Property<BigDecimal>("amountRequest", BigDecimal.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
