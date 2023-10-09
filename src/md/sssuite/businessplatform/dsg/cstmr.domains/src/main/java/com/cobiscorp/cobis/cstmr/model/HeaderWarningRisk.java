package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class HeaderWarningRisk {

	public static final String EN_HEADERWKR_788 = "EN_HEADERWKR_788";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "HeaderWarningRisk";
	
	
	public static final Property<Date> STARTDATE = new Property<Date>("startDate", Date.class, false);
	
	public static final Property<Date> FINISHDATE = new Property<Date>("finishDate", Date.class, false);
	
	public static final Property<String> TYPEALERT = new Property<String>("typeAlert", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
