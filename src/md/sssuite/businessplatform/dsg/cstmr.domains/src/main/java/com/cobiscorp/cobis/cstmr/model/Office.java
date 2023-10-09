package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Office {

	public static final String EN_OFFICEGPI_129 = "EN_OFFICEGPI_129";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Office";
	
	
	public static final Property<Integer> IDOFFICE = new Property<Integer>("idOffice", Integer.class, false);
	
	public static final Property<String> NAMEOFFICE = new Property<String>("nameOffice", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
