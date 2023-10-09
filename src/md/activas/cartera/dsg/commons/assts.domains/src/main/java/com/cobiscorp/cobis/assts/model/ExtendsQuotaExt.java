package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ExtendsQuotaExt {

	public static final String EN_EXTENDSTU_507 = "EN_EXTENDSTU_507";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExtendsQuotaExt";
	
	
	public static final Property<Integer> QUOTAEXT = new Property<Integer>("quotaExt", Integer.class, false);
	
	public static final Property<String> STARTDATEEXT = new Property<String>("startDateExt", String.class, false);
	
	public static final Property<String> ENDDATEEXT = new Property<String>("endDateExt", String.class, false);
	
	public static final Property<BigDecimal> CAPITALEXT = new Property<BigDecimal>("capitalExt", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTERESTEXT = new Property<BigDecimal>("interestExt", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERS = new Property<BigDecimal>("others", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
