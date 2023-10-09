package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Fund {

	public static final String EN_FUNDMJKIO_384 = "EN_FUNDMJKIO_384";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Fund";
	
	
	public static final Property<BigDecimal> AMOUNTSOURCE = new Property<BigDecimal>("amountSource", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INCRESEDVALUE = new Property<BigDecimal>("incresedValue", BigDecimal.class, false);
	
	public static final Property<String> SPONSORID = new Property<String>("sponsorId", String.class, false);
	
	public static final Property<String> FUNDNAME = new Property<String>("fundName", String.class, false);
	
	public static final Property<Character> SOURCETYPE = new Property<Character>("sourceType", Character.class, false);
	
	public static final Property<Date> VALIDITYDATE = new Property<Date>("validityDate", Date.class, false);
	
	public static final Property<BigDecimal> RESERVEDVALUE = new Property<BigDecimal>("reservedValue", BigDecimal.class, false);
	
	public static final Property<Character> STATUSCODE = new Property<Character>("statusCode", Character.class, false);
	
	public static final Property<BigDecimal> AVAILABLEBALANCE = new Property<BigDecimal>("availableBalance", BigDecimal.class, false);
	
	public static final Property<Integer> FUNDID = new Property<Integer>("fundId", Integer.class, false);
	
	public static final Property<BigDecimal> USEDVALUE = new Property<BigDecimal>("usedValue", BigDecimal.class, false);
	
	public static final Property<Double> NEWCUSTOMERCREDIT = new Property<Double>("newCustomerCredit", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
