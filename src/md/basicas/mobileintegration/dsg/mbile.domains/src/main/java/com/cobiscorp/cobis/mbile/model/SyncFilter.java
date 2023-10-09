package com.cobiscorp.cobis.mbile.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SyncFilter {

	public static final String EN_SYNCFILRT_494 = "EN_SYNCFILRT_494";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SyncFilter";
	
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<Date> DATESYNC = new Property<Date>("dateSync", Date.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<Date> DATEENTRY = new Property<Date>("dateEntry", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
