package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DistributionLine {

	public static final String EN_STRIIOINE478 = "EN_STRIIOINE478";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DistributionLine";
	
	
	public static final Property<String> CREDITTYPE = new Property<String>("CreditType", String.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("Currency", Integer.class, false);
	
	public static final Property<Double> AMOUNTPROPOSED = new Property<Double>("AmountProposed", Double.class, false);
	
	public static final Property<Double> QUOTE = new Property<Double>("Quote", Double.class, false);
	
	public static final Property<Double> AMOUNTLOCALCURRENCY = new Property<Double>("AmountLocalCurrency", Double.class, false);
	
	public static final Property<String> MODULE = new Property<String>("Module", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
