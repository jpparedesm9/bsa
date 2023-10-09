package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class WarrantieComext {

	public static final String EN_ARRNCMEXT747 = "EN_ARRNCMEXT747";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantieComext";
	
	
	public static final Property<Boolean> ADDITIONALCRITERIA = new Property<Boolean>("additionalCriteria", Boolean.class, false);
	
	public static final Property<Integer> CURRENCYWARRANTIE = new Property<Integer>("currencyWarrantie", Integer.class, false);
	
	public static final Property<String> WARRANTIETYPE = new Property<String>("warrantieType", String.class, false);
	
	public static final Property<Integer> CURRENCYCOMEXT = new Property<Integer>("currencyComext", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
