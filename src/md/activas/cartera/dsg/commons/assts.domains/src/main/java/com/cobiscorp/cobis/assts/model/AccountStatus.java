package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AccountStatus {

	public static final String EN_ACCOUNTSS_868 = "EN_ACCOUNTSS_868";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AccountStatus";
	
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<String> BANKNUMBER = new Property<String>("bankNumber", String.class, false);
	
	public static final Property<Boolean> TOPRINT = new Property<Boolean>("toPrint", Boolean.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<String> EMAIL = new Property<String>("email", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
