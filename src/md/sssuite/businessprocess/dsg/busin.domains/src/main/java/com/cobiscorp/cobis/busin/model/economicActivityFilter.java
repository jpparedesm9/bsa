package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class economicActivityFilter {

	public static final String EN_MCACTIVTY182 = "EN_MCACTIVTY182";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "economicActivityFilter";
	
	
	public static final Property<String> ECONOMICSECTOR = new Property<String>("economicSector", String.class, false);
	
	public static final Property<String> ECONOMICSUBSECTOR = new Property<String>("economicSubSector", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("economicActivity", String.class, false);
	
	public static final Property<String> ECONOMICSUBACTIVITY = new Property<String>("economicSubActivity", String.class, false);
	
	public static final Property<String> CLARIFICATIONFIE = new Property<String>("clarificationFie", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
