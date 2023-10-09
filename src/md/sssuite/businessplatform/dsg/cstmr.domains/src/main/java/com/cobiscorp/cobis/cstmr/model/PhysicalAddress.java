package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PhysicalAddress {

	public static final String EN_VIRTUALEA_495 = "EN_VIRTUALEA_495";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PhysicalAddress";
	
	public static final Property<String> PARAMVASMS = new Property<String>("paramVASMS", String.class, false);
	
	public static final Property<Integer> COUNTRYCODE = new Property<Integer>("countryCode", Integer.class, false);
	
	public static final Property<Integer> DIRECTIONNUMBERINTERNAL = new Property<Integer>("directionNumberInternal", Integer.class, false);
	
	public static final Property<Double> LONGITUDE = new Property<Double>("longitude", Double.class, false);
	
	public static final Property<String> ADDRESSTYPEDESCRIPTION = new Property<String>("addressTypeDescription", String.class, false);
	
	public static final Property<String> ADDRESSTYPE = new Property<String>("addressType", String.class, false);
	
	public static final Property<String> NEIGHBORHOODCODE = new Property<String>("neigborhoodCode", String.class, false);
	
	public static final Property<Integer> PROVINCECODE = new Property<Integer>("provinceCode", Integer.class, false);
	
	public static final Property<String> CITYPOBLATION = new Property<String>("cityPoblation", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> STREET = new Property<String>("street", String.class, false);
	
	public static final Property<Boolean> ISSHIPPINGADDRESS = new Property<Boolean>("isShippingAddress", Boolean.class, false);
	
	public static final Property<String> PARISHDESCRIPTION = new Property<String>("parishDescription", String.class, false);
	
	public static final Property<String> CITYDESCRIPTION = new Property<String>("cityDescription", String.class, false);
	
	public static final Property<String> MAIL = new Property<String>("mail", String.class, false);
	
	public static final Property<Integer> ADDRESSID = new Property<Integer>("addressId", Integer.class, false);
	
	public static final Property<Double> LATITUDE = new Property<Double>("latitude", Double.class, false);
	
	public static final Property<String> POSTALCODE = new Property<String>("postalCode", String.class, false);
	
	public static final Property<String> ADDRESSDESCRIPTION = new Property<String>("addressDescription", String.class, false);
	
	public static final Property<String> URBANTYPE = new Property<String>("urbanType", String.class, false);
	
	public static final Property<String> OWNERSHIPTYPE = new Property<String>("ownershipType", String.class, false);
	
	public static final Property<String> COUNTRYDESCRIPTION = new Property<String>("countryDescription", String.class, false);
	
	public static final Property<Integer> RESIDENCETIME = new Property<Integer>("residenceTime", Integer.class, false);
	
	public static final Property<Boolean> ISMAINADDRESS = new Property<Boolean>("isMainAddress", Boolean.class, false);
	
	public static final Property<String> NEIGHBORHOOD = new Property<String>("neighborhood", String.class, false);
	
	public static final Property<Integer> CITYCODE = new Property<Integer>("cityCode", Integer.class, false);
	
	public static final Property<String> PROVINCEDESCRIPTION = new Property<String>("provinceDescription", String.class, false);
	
	public static final Property<Integer> BUSINESSCODE = new Property<Integer>("businessCode", Integer.class, false);
	
	public static final Property<String> DEPARTMENT = new Property<String>("department", String.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<Integer> DIRECTIONNUMBER = new Property<Integer>("directionNumber", Integer.class, false);
	
	public static final Property<Integer> PARISHCODE = new Property<Integer>("parishCode", Integer.class, false);
	
	public static final Property<Integer> NUMBEROFRESIDENTS = new Property<Integer>("numberOfResidents", Integer.class, false);
	
	public static final Property<Integer> MONTHSINFORCE = new Property<Integer>("monthsInForce", Integer.class, false);
	
	public static final Property<String> ADDRESSMESSAGE = new Property<String>("addressMessage", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
