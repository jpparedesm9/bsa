package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LegalPerson {

	public static final String EN_PERSONOWF_669 = "EN_PERSONOWF_669";

	public static final String VERSION = "1.0.0";

	public static final String ENTITY_NAME = "LegalPerson";

	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);

	public static final Property<Character> PERSONTYPE = new Property<Character>("personType", Character.class, false);

	public static final Property<String> DOCUMENTTYPE = new Property<String>("documentType", String.class, false);

	public static final Property<String> DOCUMENTNUMBER = new Property<String>("documentNumber", String.class, false);

	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);

	public static final Property<String> EMAILADDRESS = new Property<String>("emailAddress", String.class, false);

	public static final Property<String> DOCUMENTTYPEDESCRIPTION = new Property<String>("documentTypeDescription", String.class, false);

	public static final Property<String> RELATIONID = new Property<String>("relationId", String.class, false);

	public static final Property<String> BUSINESSNAME = new Property<String>("businessName", String.class, false);

	public static final Property<String> TRADENAME = new Property<String>("tradename", String.class, false);

	public static final Property<Date> CONSTITUTIONDATE = new Property<Date>("constitutionDate", Date.class, false);

	public static final Property<String> ACRONYM = new Property<String>("acronym", String.class, false);
	
	public static final Property<Integer> CONSTITUTIONPLACECODE = new Property<Integer>("constitutionPlaceCode", Integer.class, false);
	
	public static final Property<String> CONSTITUTIONPLACEDESCRIPTION = new Property<String>("constitutionPlaceDescription", String.class, false);
	
	public static final Property<String> COVERAGECODE = new Property<String>("coverageCode", String.class, false);
	
	public static final Property<String> COVERAGEDESCRIPTION = new Property<String>("coverageDescription", String.class, false);
	
	public static final Property<String> SEGMENTCODE = new Property<String>("segmentCode", String.class, false);
	
	public static final Property<String> SEGMENTDESCRIPTION = new Property<String>("segmentDescription", String.class, false);
	
	public static final Property<String> LEGALPERSONTYPECODE = new Property<String>("legalpersonTypeCode", String.class, false);

	public static final Property<String> SIPLA = new Property<String>("sipla", String.class, false);
	public static final Property<String> VALIDATEDDOC = new Property<String>("validatedDoc", String.class, false);

	
	
	
	

	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
