package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ReferenceInfor {

	public static final String EN_REFERENEI_541 = "EN_REFERENEI_541";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ReferenceInfor";	
	
	public static final Property<String> AUTHORIZATIONNUMBER = new Property<String>("authorizationNumber", String.class, false);
	
	public static final Property<Date> REFVALIDITY = new Property<Date>("refValidity", Date.class, false);
	
	public static final Property<Date> OPERATIONDATE = new Property<Date>("operationDate", Date.class, false);
	
	public static final Property<String> REFSTATUS = new Property<String>("refStatus", String.class, false);
	
	public static final Property<Date> OPERATIONTIME = new Property<Date>("operationTime", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
