package com.cobiscorp.cobis.mbile.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Mobile {

	public static final String EN_MOBILEMMS_124 = "EN_MOBILEMMS_124";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Mobile";
	
	
	public static final Property<String> IMEI = new Property<String>("imei", String.class, false);
	
	public static final Property<String> MACADDRESS = new Property<String>("macAddress", String.class, false);
	
	public static final Property<Character> DEVICESTATUS = new Property<Character>("deviceStatus", Character.class, false);
	
	public static final Property<String> ALIAS = new Property<String>("alias", String.class, false);
	
	public static final Property<Date> REGISTRATIONDATE = new Property<Date>("registrationDate", Date.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("official", String.class, false);
	
	public static final Property<Boolean> ALLOWUPDATE = new Property<Boolean>("allowUpdate", Boolean.class, false);
	
	public static final Property<String> REGISTRATIONUSER = new Property<String>("registrationUser", String.class, false);
	
	public static final Property<String> OFFICIALDESCRIPTION = new Property<String>("officialDescription", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, true);
	
	public static final Property<String> DEVICESTATUSDESCRIPTION = new Property<String>("deviceStatusDescription", String.class, false);
	
	public static final Property<String> TYPEDESCRIPTION = new Property<String>("typeDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		pks.add(CODE);
		return pks;
	}

}
