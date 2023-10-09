package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SearchRejectedDispersions {

	public static final String EN_SEARCHRSD_733 = "EN_SEARCHRSD_733";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SearchRejectedDispersions";
	
	
	public static final Property<Date> STARTDATE = new Property<Date>("startDate", Date.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<String> CUSTOMERCODE = new Property<String>("customerCode", String.class, false);
	
	public static final Property<Integer> ACTION = new Property<Integer>("action", Integer.class, false);
	
	public static final Property<Character> TYPE = new Property<Character>("type", Character.class, false);
	
	public static final Property<Boolean> SELECTALL = new Property<Boolean>("selectAll", Boolean.class, false);
	
	public static final Property<Date> ENDDATE = new Property<Date>("endDate", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
