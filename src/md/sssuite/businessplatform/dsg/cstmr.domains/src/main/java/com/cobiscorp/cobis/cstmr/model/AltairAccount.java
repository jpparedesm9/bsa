package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AltairAccount {

	public static final String EN_ALTAIRAUN_367 = "EN_ALTAIRAUN_367";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AltairAccount";
	
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<String> OLDACCOUNTINDIVIDUAL = new Property<String>("oldAccountIndividual", String.class, false);
	
	public static final Property<String> NEWACCOUNTINDIVIDUAL = new Property<String>("newAccountIndividual", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
