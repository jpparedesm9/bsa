package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ManagersPoints {

	public static final String EN_AAERPOITS501 = "EN_AAERPOITS501";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ManagersPoints";
	
	
	public static final Property<Character> CHECK = new Property<Character>("Check", Character.class, false);
	
	public static final Property<String> ROLE = new Property<String>("Role", String.class, false);
	
	public static final Property<String> SALEPOINTS = new Property<String>("SalePoints", String.class, false);
	
	public static final Property<Integer> IDROLE = new Property<Integer>("IdRole", Integer.class, false);
	
	public static final Property<Integer> PROCESSED = new Property<Integer>("Processed", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
