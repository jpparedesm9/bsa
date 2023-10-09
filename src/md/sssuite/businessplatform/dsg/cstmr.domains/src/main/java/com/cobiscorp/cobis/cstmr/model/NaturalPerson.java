package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class NaturalPerson {

	public static final String EN_NATURALES_593 = "EN_NATURALES_593";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "NaturalPerson";
	
	
	public static final Property<String> NAMEGROUP = new Property<String>("nameGroup", String.class, false);
	
	public static final Property<String> SECONDSURNAME = new Property<String>("secondSurname", String.class, false);
	
	public static final Property<Date> BIRTHDATE = new Property<Date>("birthDate", Date.class, false);
	
	public static final Property<String> SECONDNAME = new Property<String>("secondName", String.class, false);
	
	public static final Property<String> HASALERT = new Property<String>("hasAlert", String.class, false);
	
	public static final Property<String> SURNAME = new Property<String>("surname", String.class, false);
	
	public static final Property<String> MARITALSTATUSDESCRIPTION = new Property<String>("maritalStatusDescription", String.class, false);
	
	public static final Property<String> BIOCIC = new Property<String>("bioCIC", String.class, false);
	
	public static final Property<Boolean> INDEFINITE = new Property<Boolean>("indefinite", Boolean.class, false);
	
	public static final Property<Integer> NATIONALITYCODE = new Property<Integer>("nationalityCode", Integer.class, false);
	
	public static final Property<String> SANTANDERACCOUNT = new Property<String>("santanderAccount", String.class, false);
	
	public static final Property<String> FIRSTNAME = new Property<String>("firstName", String.class, false);
	
	public static final Property<String> INDIVIDUALRISK = new Property<String>("individualRisk", String.class, false);
	
	public static final Property<Boolean> HASPARTNER = new Property<Boolean>("hasPartner", Boolean.class, false);
	
	public static final Property<String> BIOOCR = new Property<String>("bioOCR", String.class, false);
	
	public static final Property<String> DOCUMENTTYPEDESCRIPTION = new Property<String>("documentTypeDescription", String.class, false);
	
	public static final Property<Boolean> HASLISTBLACK = new Property<Boolean>("hasListBlack", Boolean.class, false);
	
	public static final Property<Integer> MONTHSINFORCE = new Property<Integer>("monthsInForce", Integer.class, false);
	
	public static final Property<Boolean> PERSONPEP = new Property<Boolean>("personPEP", Boolean.class, false);
	
	public static final Property<String> CHARGEPUB = new Property<String>("chargePub", String.class, false);
	
	public static final Property<String> TECHNOLOGICALDEGREE = new Property<String>("technologicalDegree", String.class, false);
	
	public static final Property<Character> PERSONTYPE = new Property<Character>("personType", Character.class, false);
	
	public static final Property<String> SPOUSE = new Property<String>("spouse", String.class, false);
	
	public static final Property<Integer> OFFICERCODE = new Property<Integer>("officerCode", Integer.class, false);
	
	public static final Property<String> STATUSCODE = new Property<String>("statusCode", String.class, false);
	
	public static final Property<Integer> AGE = new Property<Integer>("age", Integer.class, false);
	
	public static final Property<Character> BIOHASFINGERPRINT = new Property<Character>("bioHasFingerprint", Character.class, false);
	
	public static final Property<String> ACCOUNTINDIVIDUAL = new Property<String>("accountIndividual", String.class, false);
	
	public static final Property<String> DOCUMENTNUMBER = new Property<String>("documentNumber", String.class, false);
	
	public static final Property<String> MARRIEDSURNAME = new Property<String>("marriedSurname", String.class, false);
	
	public static final Property<Integer> COUNTRYCODE = new Property<Integer>("countryCode", Integer.class, false);
	
	public static final Property<String> BIOREADERKEY = new Property<String>("bioReaderKey", String.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<String> EMAIL = new Property<String>("email", String.class, false);
	
	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> GENDERDESCRIPTION = new Property<String>("genderDescription", String.class, false);
	
	public static final Property<String> IDENTIFICATIONRFC = new Property<String>("identificationRFC", String.class, false);
	
	public static final Property<Boolean> ISLINKED = new Property<Boolean>("isLinked", Boolean.class, false);
	
	public static final Property<Integer> NATIONALITYCODEAUX = new Property<Integer>("nationalityCodeAux", Integer.class, false);
	
	public static final Property<String> RELCHARGEPUB = new Property<String>("relChargePub", String.class, false);
	
	public static final Property<Character> GENDERCODE = new Property<Character>("genderCode", Character.class, false);
	
	public static final Property<String> SANTANDERCODE = new Property<String>("santanderCode", String.class, false);
	
	public static final Property<String> BIOIDENTIFICATIONTYPE = new Property<String>("bioIdentificationType", String.class, false);
	
	public static final Property<String> MARITALSTATUSCODE = new Property<String>("maritalStatusCode", String.class, false);
	
	public static final Property<Integer> NUMCYCLES = new Property<Integer>("numCycles", Integer.class, false);
	
	public static final Property<String> BIOEMISSIONNUMBER = new Property<String>("bioEmissionNumber", String.class, false);
	
	public static final Property<String> DOCUMENTTYPE = new Property<String>("documentType", String.class, false);
	
	public static final Property<Boolean> HASPROBLEMS = new Property<Boolean>("hasProblems", Boolean.class, false);
	
	public static final Property<Boolean> PUBLICPERSON = new Property<Boolean>("publicPerson", Boolean.class, false);
	
	public static final Property<String> KNOWNAS = new Property<String>("knownAs", String.class, false);
	
	public static final Property<String> NIVELCOLECTIVO = new Property<String>("nivelColectivo", String.class, false);
	
	public static final Property<Integer> COUNTYOFBIRTH = new Property<Integer>("countyOfBirth", Integer.class, false);
	
	public static final Property<Integer> IDGROUP = new Property<Integer>("idGroup", Integer.class, false);
	
	public static final Property<String> COLECTIVO = new Property<String>("colectivo", String.class, false);
	
	public static final Property<String> BIORENAPORESULT = new Property<String>("bioRenapoResult", String.class, false);
	
	public static final Property<String> RELATIONID = new Property<String>("relationId", String.class, false);
	
	public static final Property<Integer> BRANCHCODE = new Property<Integer>("branchCode", Integer.class, false);
	
	public static final Property<String> CREDITBUREAU = new Property<String>("creditBureau", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
