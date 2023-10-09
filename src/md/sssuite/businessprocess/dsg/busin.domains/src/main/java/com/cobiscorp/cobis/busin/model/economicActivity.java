package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class economicActivity {

	public static final String EN_CNOMACIVI771 = "EN_CNOMACIVI771";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "economicActivity";
	
	
	public static final Property<String> CODEECONOMICACTIVITY = new Property<String>("codeEconomicActivity", String.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("sector", String.class, false);
	
	public static final Property<String> SUBSECTOR = new Property<String>("subSector", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("economicActivity", String.class, false);
	
	public static final Property<String> ECSUBACTIVITY = new Property<String>("ecSubActivity", String.class, false);
	
	public static final Property<String> CLARIFICATIONFIE = new Property<String>("clarificationFIE", String.class, false);
	
	public static final Property<String> CODESUBACTIVITY = new Property<String>("codeSubActivity", String.class, false);
	
	public static final Property<String> CODESECTOR = new Property<String>("codeSector", String.class, false);
	
	public static final Property<String> CODESUBSECTOR = new Property<String>("codeSubsector", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
