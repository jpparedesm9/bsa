package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class QuotationCurrency {

	public static final String EN_QUOTATIUO_860 = "EN_QUOTATIUO_860";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuotationCurrency";
	
	
	public static final Property<Integer> CURRENCYTYPE = new Property<Integer>("currencyType", Integer.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<Integer> RESULT = new Property<Integer>("result", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
