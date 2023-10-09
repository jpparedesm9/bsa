package com.cobiscorp.cobis.wrrnt.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Warranty {

	public static final String EN_WARRANTYY_755 = "EN_WARRANTYY_755";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Warranty";
	
	
	public static final Property<BigDecimal> SHAREVALUE = new Property<BigDecimal>("shareValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> COVERAGEVALUE = new Property<BigDecimal>("coverageValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> NEWCOMMERCIALVALUE = new Property<BigDecimal>("newCommercialValue", BigDecimal.class, false);
	
	public static final Property<Integer> OFFICE = new Property<Integer>("office", Integer.class, false);
	
	public static final Property<Integer> SHARESNUMBER = new Property<Integer>("sharesNumber", Integer.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<String> EXTERNALCODE = new Property<String>("externalCode", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<Integer> CUSTODY = new Property<Integer>("custody", Integer.class, false);
	
	public static final Property<Double> PERCENT = new Property<Double>("percent", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
