package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SharedEntityWarranty {

	public static final String EN_SHAREDWRR_638 = "EN_SHAREDWRR_638";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SharedEntityWarranty";
	
	
	public static final Property<Double> SHAREDPERCENTAGE = new Property<Double>("sharedPercentage", Double.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<Double> CORPORATION = new Property<Double>("corporation", Double.class, false);
	
	public static final Property<BigDecimal> BOOKVALUE = new Property<BigDecimal>("bookValue", BigDecimal.class, false);
	
	public static final Property<String> NAMEENTITY = new Property<String>("nameEntity", String.class, false);
	
	public static final Property<BigDecimal> VALUECOMERCIAL = new Property<BigDecimal>("valueComercial", BigDecimal.class, false);
	
	public static final Property<String> ENTITY = new Property<String>("entity", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
