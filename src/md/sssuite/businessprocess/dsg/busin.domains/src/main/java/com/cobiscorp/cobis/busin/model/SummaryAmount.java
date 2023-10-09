package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SummaryAmount {

	public static final String EN_SMARYAOUT669 = "EN_SMARYAOUT669";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SummaryAmount";
	
	
	public static final Property<Integer> OFFICE = new Property<Integer>("Office", Integer.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("Currency", Integer.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCE = new Property<BigDecimal>("CapitalBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCETODATE = new Property<BigDecimal>("CapitalBalanceToDate", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
