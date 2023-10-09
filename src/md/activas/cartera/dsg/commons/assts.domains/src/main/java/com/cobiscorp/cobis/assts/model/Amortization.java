package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Amortization {

	public static final String EN_2ZNYDYMCX_592 = "EN_2ZNYDYMCX_592";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Amortization";
	
	
	public static final Property<Integer> SHARE = new Property<Integer>("share", Integer.class, false);
	
	public static final Property<Date> EXPIRATION = new Property<Date>("expiration", Date.class, false);
	
	public static final Property<Integer> DAYS = new Property<Integer>("days", Integer.class, false);
	
	public static final Property<BigDecimal> BALANCECAP = new Property<BigDecimal>("balanceCap", BigDecimal.class, false);
	
	public static final Property<BigDecimal> SHAREVALUE = new Property<BigDecimal>("shareValue", BigDecimal.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<String> PORROGA = new Property<String>("porroga", String.class, false);
	
	public static final Property<BigDecimal> ITEMS1 = new Property<BigDecimal>("items1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS2 = new Property<BigDecimal>("items2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS3 = new Property<BigDecimal>("items3", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS4 = new Property<BigDecimal>("items4", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS5 = new Property<BigDecimal>("items5", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS6 = new Property<BigDecimal>("items6", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS7 = new Property<BigDecimal>("items7", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS8 = new Property<BigDecimal>("items8", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS9 = new Property<BigDecimal>("items9", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS10 = new Property<BigDecimal>("items10", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS11 = new Property<BigDecimal>("items11", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS12 = new Property<BigDecimal>("items12", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS13 = new Property<BigDecimal>("items13", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS14 = new Property<BigDecimal>("items14", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEMS15 = new Property<BigDecimal>("items15", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
