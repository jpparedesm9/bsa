package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SpousePerson {

	public static final String EN_SPOUSEPNN_845 = "EN_SPOUSEPNN_845";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SpousePerson";
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> DOCUMENTNUMBER = new Property<String>("documentNumber", String.class, false);
	
	public static final Property<String> DOCUMENTTYPEDESCRIPTION = new Property<String>("documentTypeDescription", String.class, false);
	
	public static final Property<String> SECONDNAME = new Property<String>("secondName", String.class, false);
	
	public static final Property<String> PHONE = new Property<String>("phone", String.class, false);
	
	public static final Property<String> SECONDSURNAME = new Property<String>("secondSurname", String.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<Date> BIRTHDATE = new Property<Date>("birthDate", Date.class, false);
	
	public static final Property<Character> GENDERCODE = new Property<Character>("genderCode", Character.class, false);
	
	public static final Property<Character> PERSONTYPE = new Property<Character>("personType", Character.class, false);
	
	public static final Property<String> FIRSTNAME = new Property<String>("firstName", String.class, false);
	
	public static final Property<String> SURNAME = new Property<String>("surname", String.class, false);
	
	public static final Property<String> GENDERDESCRIPTION = new Property<String>("genderDescription", String.class, false);
	
	public static final Property<Integer> COUNTRYOFBIRTH = new Property<Integer>("countryOfBirth", Integer.class, false);
	
	public static final Property<String> DOCUMENTTYPE = new Property<String>("documentType", String.class, false);
	
	public static final Property<String> IDENTIFICATIONRFC = new Property<String>("identificationRFC", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
