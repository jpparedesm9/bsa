package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class EconomicActivity {

	public static final String EN_ECONOMITC_959 = "EN_ECONOMITC_959";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EconomicActivity";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> INCOMESOURCE = new Property<String>("incomeSource", String.class, false);
	
	public static final Property<String> PLACEAFFILIATION = new Property<String>("placeAffiliation", String.class, false);
	
	public static final Property<Integer> GRIDROW = new Property<Integer>("gridRow", Integer.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> ACTIVITYSTATUS = new Property<String>("activityStatus", String.class, false);
	
	public static final Property<String> PRINCIPAL = new Property<String>("principal", String.class, false);
	
	public static final Property<String> SUBSECTOR = new Property<String>("subSector", String.class, false);
	
	public static final Property<String> ACTIVITYSCHEDULE = new Property<String>("activitySchedule", String.class, false);
	
	public static final Property<String> ENVIRONMENT = new Property<String>("environment", String.class, false);
	
	public static final Property<String> ATENTIONDAYS = new Property<String>("atentionDays", String.class, false);
	
	public static final Property<String> PERSONTYPE = new Property<String>("personType", String.class, false);
	
	public static final Property<Integer> ANTIQUITY = new Property<Integer>("antiquity", Integer.class, false);
	
	public static final Property<String> CAEDEC = new Property<String>("caedec", String.class, false);
	
	public static final Property<String> SECTORDESCRIPTION = new Property<String>("sectorDescription", String.class, false);
	
	public static final Property<String> ATTENTIONSCHEDULE = new Property<String>("attentionSchedule", String.class, false);
	
	public static final Property<String> SUBACTIVITY = new Property<String>("subActivity", String.class, false);
	
	public static final Property<String> AUTHORIZED = new Property<String>("authorized", String.class, false);
	
	public static final Property<String> SUBSECTORDESCRIPTION = new Property<String>("subSectorDescription", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("economicActivity", String.class, false);
	
	public static final Property<String> ECONOMICSECTOR = new Property<String>("economicSector", String.class, false);
	
	public static final Property<Date> VERIFICATIONDATE = new Property<Date>("verificationDate", Date.class, false);
	
	public static final Property<String> AFFILIATE = new Property<String>("affiliate", String.class, false);
	
	public static final Property<Integer> NUMBEREMPLOYEES = new Property<Integer>("numberEmployees", Integer.class, false);
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<String> VERIFIED = new Property<String>("verified", String.class, false);
	
	public static final Property<String> VERFICATIONSOURCE = new Property<String>("verficationSource", String.class, false);
	
	public static final Property<Date> STARTDATEACTIVITY = new Property<Date>("startdateActivity", Date.class, false);
	
	public static final Property<String> PROPERTYTYPE = new Property<String>("propertyType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
