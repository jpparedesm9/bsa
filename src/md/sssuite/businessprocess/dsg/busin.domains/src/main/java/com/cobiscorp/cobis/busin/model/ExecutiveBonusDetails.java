package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ExecutiveBonusDetails {

	public static final String EN_CUTESTILS591 = "EN_CUTESTILS591";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExecutiveBonusDetails";
	
	
	public static final Property<Integer> IDCODE = new Property<Integer>("idCode", Integer.class, false);
	
	public static final Property<Integer> IDCODEDETAIL = new Property<Integer>("idCodeDetail", Integer.class, false);
	
	public static final Property<String> REVISED = new Property<String>("revised", String.class, false);
	
	public static final Property<Integer> IDOFFICER = new Property<Integer>("idofficer", Integer.class, false);
	
	public static final Property<String> OFFICERNAME = new Property<String>("officerName", String.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final Property<String> LEVEL = new Property<String>("level", String.class, false);
	
	public static final Property<BigDecimal> VARA1 = new Property<BigDecimal>("varA1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARA2 = new Property<BigDecimal>("varA2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARB1 = new Property<BigDecimal>("varB1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARB2 = new Property<BigDecimal>("varB2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARC = new Property<BigDecimal>("varC", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARD1 = new Property<BigDecimal>("varD1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARD2 = new Property<BigDecimal>("varD2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VARE = new Property<BigDecimal>("varE", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALMODIFYEXECUTIVE = new Property<BigDecimal>("totalModifyExecutive", BigDecimal.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<BigDecimal> PORTFOLIOBALANCE = new Property<BigDecimal>("portfolioBalance", BigDecimal.class, false);
	
	public static final Property<Integer> CUSTOMERSNUMBRES = new Property<Integer>("customersNumbres", Integer.class, false);
	
	public static final Property<Double> WEIGHTEDARREARS = new Property<Double>("weightedArrears", Double.class, false);
	
	public static final Property<Integer> VIEWNUMBERS = new Property<Integer>("viewNumbers", Integer.class, false);
	
	public static final Property<Double> CUSTOMERRETENTION = new Property<Double>("customerRetention", Double.class, false);
	
	public static final Property<BigDecimal> PORTFOLIOGROWTH = new Property<BigDecimal>("portfolioGrowth", BigDecimal.class, false);
	
	public static final Property<Integer> INCREASECUSTOMERS = new Property<Integer>("increaseCustomers", Integer.class, false);
	
	public static final Property<BigDecimal> TOTALPREVIOUS = new Property<BigDecimal>("totalPrevious", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALMODIFIEDMONTHPREVIOUS = new Property<BigDecimal>("totalModifiedMonthPrevious", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
