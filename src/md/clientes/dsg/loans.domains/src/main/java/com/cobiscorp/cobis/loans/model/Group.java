package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Group {

	public static final String EN_GROUPWBWL_452 = "EN_GROUPWBWL_452";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Group";
	
	
	public static final Property<Boolean> HASGROUPACCOUNT = new Property<Boolean>("hasGroupAccount", Boolean.class, false);
	
	public static final Property<String> MEETINGADDRESS = new Property<String>("meetingAddress", String.class, false);
	
	public static final Property<Date> NEXTVISITDATE = new Property<Date>("nextVisitDate", Date.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<String> TITULAR2NAME = new Property<String>("titular2Name", String.class, false);
	
	public static final Property<Integer> GROUPOFFICE = new Property<Integer>("groupOffice", Integer.class, false);
	
	public static final Property<Integer> TITULARCLIENT2 = new Property<Integer>("titularClient2", Integer.class, false);
	
	public static final Property<String> USERNAME = new Property<String>("userName", String.class, false);
	
	public static final Property<Boolean> ADDRESSMEMBER = new Property<Boolean>("addressMember", Boolean.class, false);
	
	public static final Property<String> DAY = new Property<String>("day", String.class, false);
	
	public static final Property<Date> CONSTITUTIONDATE = new Property<Date>("constitutionDate", Date.class, false);
	
	public static final Property<Character> UPDATEGROUP = new Property<Character>("updateGroup", Character.class, false);
	
	public static final Property<String> NAMEGROUP = new Property<String>("nameGroup", String.class, false);
	
	public static final Property<Integer> CYCLENUMBER = new Property<Integer>("cycleNumber", Integer.class, false);
	
	public static final Property<String> PAYMENT = new Property<String>("payment", String.class, false);
	
	public static final Property<String> GROUPACCOUNT = new Property<String>("groupAccount", String.class, false);
	
	public static final Property<Boolean> OTHERPLACE = new Property<Boolean>("otherPlace", Boolean.class, false);
	
	public static final Property<Integer> TITULARCLIENT1 = new Property<Integer>("titularClient1", Integer.class, false);
	
	public static final Property<Character> OPERATION = new Property<Character>("operation", Character.class, false);
	
	public static final Property<Character> HASLIQUIDGAR = new Property<Character>("hasLiquidGar", Character.class, false);
	
	public static final Property<Date> TIME = new Property<Date>("time", Date.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final Property<String> TITULAR1NAME = new Property<String>("titular1Name", String.class, false);
	
	public static final Property<Boolean> HASINDIVIDUALACCOUNT = new Property<Boolean>("hasIndividualAccount", Boolean.class, false);
	
	public static final Property<Integer> OFFICER = new Property<Integer>("officer", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
