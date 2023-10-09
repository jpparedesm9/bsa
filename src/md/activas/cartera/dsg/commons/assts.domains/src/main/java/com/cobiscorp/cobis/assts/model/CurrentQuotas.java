package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class CurrentQuotas {

	public static final String EN_CURRENTQQ_270 = "EN_CURRENTQQ_270";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CurrentQuotas";
	
	
	public static final Property<Integer> QUOTA = new Property<Integer>("quota", Integer.class, false);
	
	public static final Property<String> STARTDATE = new Property<String>("startDate", String.class, false);
	
	public static final Property<Date> ENDDATE = new Property<Date>("endDate", Date.class, false);
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTEREST = new Property<BigDecimal>("interest", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERS = new Property<BigDecimal>("others", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
