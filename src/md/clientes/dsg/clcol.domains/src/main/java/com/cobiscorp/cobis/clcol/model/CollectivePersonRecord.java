package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectivePersonRecord {

	public static final String EN_COLLECTDI_520 = "EN_COLLECTDI_520";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectivePersonRecord";
	
	
	public static final Property<String> NUMBEREXTADDRESS = new Property<String>("numberExtAddress", String.class, false);
	
	public static final Property<String> STREETADDRESS = new Property<String>("streetAddress", String.class, false);
	
	public static final Property<String> SURNAME = new Property<String>("surname", String.class, false);
	
	public static final Property<String> BIRTHENTITYDESC = new Property<String>("birthEntityDesc", String.class, false);
	
	public static final Property<String> CELLPHONENUMBER = new Property<String>("cellPhoneNumber", String.class, false);
	
	public static final Property<String> EMAIL = new Property<String>("email", String.class, false);
	
	public static final Property<String> OFFICEDESC = new Property<String>("officeDesc", String.class, false);
	
	public static final Property<String> SECONDSURNAME = new Property<String>("secondSurname", String.class, false);
	
	public static final Property<String> CURP = new Property<String>("curp", String.class, false);
	
	public static final Property<String> BIRTHDATE = new Property<String>("birthDate", String.class, false);
	
	public static final Property<String> GENDER = new Property<String>("gender", String.class, false);
	
	public static final Property<String> COLONYADDRESS = new Property<String>("colonyAddress", String.class, false);
	
	public static final Property<String> CPADDRESS = new Property<String>("cpAddress", String.class, false);
	
	public static final Property<String> PERIODICITY = new Property<String>("periodicity", String.class, false);
	
	public static final Property<String> OFFICEID = new Property<String>("officeId", String.class, false);
	
	public static final Property<String> MONTHSALES = new Property<String>("monthSales", String.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("observations", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("economicActivity", String.class, false);
	
	public static final Property<String> COLLECTIVENAME = new Property<String>("collectiveName", String.class, false);
	
	public static final Property<String> NUMBERCHILDREN = new Property<String>("numberChildren", String.class, false);
	
	public static final Property<String> BIRTHENTITY = new Property<String>("birthEntity", String.class, false);
	
	public static final Property<String> FIRSTNAME = new Property<String>("firstName", String.class, false);
	
	public static final Property<String> OFFICIALLOGIN = new Property<String>("officialLogin", String.class, false);
	
	public static final Property<String> CLIENTLEVEL = new Property<String>("clientLevel", String.class, false);
	
	public static final Property<String> SECONDNAME = new Property<String>("secondName", String.class, false);
	
	public static final Property<String> NUMBERINTADDRESS = new Property<String>("numberIntAddress", String.class, false);
	
	public static final Property<String> RFC = new Property<String>("rfc", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
