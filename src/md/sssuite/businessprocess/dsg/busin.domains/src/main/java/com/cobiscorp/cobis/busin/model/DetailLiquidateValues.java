package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DetailLiquidateValues {

	public static final String EN_ELQUDATAU522 = "EN_ELQUDATAU522";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailLiquidateValues";
	
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("Value", BigDecimal.class, false);
	
	public static final Property<String> SIGN = new Property<String>("Sign", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
