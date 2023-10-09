package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Business {

	public static final String EN_BUSINESSS_830 = "EN_BUSINESSS_830";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Business";
	
	
	public static final Property<String> COLONY = new Property<String>("colony", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> PHONE = new Property<String>("phone", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("economicActivity", String.class, false);
	
	public static final Property<String> STREET = new Property<String>("street", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITYDESC = new Property<String>("economicActivityDesc", String.class, false);
	
	public static final Property<String> TYPELOCAL = new Property<String>("typeLocal", String.class, false);
	
	public static final Property<Double> MOUNTLYINCOMES = new Property<Double>("mountlyIncomes", Double.class, false);
	
	public static final Property<Boolean> AREENTREPRENEUR = new Property<Boolean>("areEntrepreneur", Boolean.class, false);
	
	public static final Property<Integer> NUMBEROFBUSINESS = new Property<Integer>("numberOfBusiness", Integer.class, false);
	
	public static final Property<String> POSTALCODE = new Property<String>("postalCode", String.class, false);
	
	public static final Property<String> WHICHRESOURCE = new Property<String>("whichResource", String.class, false);
	
	public static final Property<Integer> TIMEBUSINESSADDRESS = new Property<Integer>("timeBusinessAddress", Integer.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<Integer> TIMEACTIVITY = new Property<Integer>("timeActivity", Integer.class, false);
	
	public static final Property<String> RESOURCES = new Property<String>("resources", String.class, false);
	
	public static final Property<String> COUNTRY = new Property<String>("country", String.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final Property<String> MUNICIPALITY = new Property<String>("municipality", String.class, false);
	
	public static final Property<Date> DATEBUSINESS = new Property<Date>("dateBusiness", Date.class, false);
	
	public static final Property<String> CREDITDESTINATION = new Property<String>("creditDestination", String.class, false);
	
	public static final Property<String> TURNAROUND = new Property<String>("turnaround", String.class, false);
	
	public static final Property<String> LOCATIONS = new Property<String>("locations", String.class, false);
	
	public static final Property<String> NAMES = new Property<String>("names", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
