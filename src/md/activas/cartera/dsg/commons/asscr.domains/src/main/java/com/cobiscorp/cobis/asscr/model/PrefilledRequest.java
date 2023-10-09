package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PrefilledRequest {

	public static final String EN_PREFILLTR_905 = "EN_PREFILLTR_905";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PrefilledRequest";
	
	
	public static final Property<String> CLIENTIDSTR = new Property<String>("clientIdStr", String.class, false);
	
	public static final Property<String> GROUPREQUEST = new Property<String>("groupRequest", String.class, false);
	
	public static final Property<String> RENEWALSREQUEST = new Property<String>("renewalsRequest", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<Boolean> ISGROUP = new Property<Boolean>("isGroup", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
