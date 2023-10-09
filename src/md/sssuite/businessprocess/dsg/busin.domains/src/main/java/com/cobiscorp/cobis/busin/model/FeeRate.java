package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class FeeRate {

	public static final String EN_FEERATEXR359 = "EN_FEERATEXR359";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "FeeRate";
	
	
	public static final Property<String> COSTCATEGORY = new Property<String>("costCategory", String.class, false);
	
	public static final Property<Double> FACTORFROM = new Property<Double>("factorFrom", Double.class, false);
	
	public static final Property<Double> FACTORTO = new Property<Double>("factorTo", Double.class, false);
	
	public static final Property<Double> PERCENTAGE = new Property<Double>("percentage", Double.class, false);
	
	public static final Property<Double> PERCENTAGENEW = new Property<Double>("percentageNew", Double.class, false);
	
	public static final Property<Double> MAXVALUE = new Property<Double>("maxValue", Double.class, false);
	
	public static final Property<Double> MINVALUE = new Property<Double>("minValue", Double.class, false);
	
	public static final Property<Double> COMMISSION = new Property<Double>("commission", Double.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("currency", Integer.class, false);
	
	public static final Property<String> MINIMUM = new Property<String>("minimum", String.class, false);
	
	public static final Property<Integer> CURRENCYVALUEMIN = new Property<Integer>("currencyValueMin", Integer.class, false);
	
	public static final Property<Integer> CURRENCYVALUEMAX = new Property<Integer>("currencyValueMax", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
