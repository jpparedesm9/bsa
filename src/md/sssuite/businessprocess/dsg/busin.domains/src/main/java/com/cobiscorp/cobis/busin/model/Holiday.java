package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Holiday {

	public static final String EN_HOLIDAYLQ971 = "EN_HOLIDAYLQ971";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Holiday";
	
	
	public static final Property<Date> HOLIDAYDATE = new Property<Date>("holidayDate", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
