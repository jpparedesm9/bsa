package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QueryCentral {

	public static final String EN_UECENTRAL063 = "EN_UECENTRAL063";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QueryCentral";
	
	
	public static final Property<String> REPORTMONTHCIC = new Property<String>("ReportMonthCIC", String.class, false);
	
	public static final Property<String> REPORTMONTHINFOCRED = new Property<String>("ReportMonthINFOCRED", String.class, false);
	
	public static final Property<Character> LEVELINDEBTEDNESS = new Property<Character>("LevelIndebtedness", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
