package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConciliationSearchFilter {

	public static final String EN_CONCILIIC_277 = "EN_CONCILIIC_277";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConciliationSearchFilter";
	
	
	public static final Property<Character> CONCILIATIONSTATUS = new Property<Character>("conciliationStatus", Character.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<String> CUSTOMERCODE = new Property<String>("customerCode", String.class, false);
	
	public static final Property<Date> DATEUNTIL = new Property<Date>("dateUntil", Date.class, false);
	
	public static final Property<String> NOTCONCILIATIONREASON = new Property<String>("notConciliationReason", String.class, false);
	
	public static final Property<Double> AMOUNT = new Property<Double>("amount", Double.class, false);
	
	public static final Property<Date> DATEFROM = new Property<Date>("dateFrom", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
