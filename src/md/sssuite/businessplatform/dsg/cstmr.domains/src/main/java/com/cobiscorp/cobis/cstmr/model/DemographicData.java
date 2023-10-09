package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DemographicData {

	public static final String EN_DEMOGRADH_602 = "EN_DEMOGRADH_602";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DemographicData";
	
	
	public static final Property<String> PROFESSION = new Property<String>("profession", String.class, true);
	
	public static final Property<Integer> RESIDENCECOUNTRY = new Property<Integer>("residenceCountry", Integer.class, false);
	
	public static final Property<String> DISABILITYTYPE = new Property<String>("disabilityType", String.class, false);
	
	public static final Property<Character> HASDISABILITY = new Property<Character>("hasDisability", Character.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> WHICHPROFESSION = new Property<String>("whichProfession", String.class, false);
	
	public static final Property<String> STUDIESLEVEL = new Property<String>("studiesLevel", String.class, false);
	
	public static final Property<String> HOUSINGTYPE = new Property<String>("housingType", String.class, false);
	
	public static final Property<Character> TEMPLATE = new Property<Character>("template", Character.class, false);
	
	public static final Property<Integer> DEPENDENTS = new Property<Integer>("dependents", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		pks.add(PROFESSION);
		return pks;
	}

}
