package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Official {

	public static final String EN_OFFICIALL_467 = "EN_OFFICIALL_467";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Official";
	
	
	public static final Property<String> USERNAMEOFFICIAL = new Property<String>("usernameOfficial", String.class, false);
	
	public static final Property<Integer> IDOFFICE = new Property<Integer>("idOffice", Integer.class, false);
	
	public static final Property<String> NAMEOFFICIAL = new Property<String>("nameOfficial", String.class, false);
	
	public static final Property<String> STATUSOFFICIAL = new Property<String>("statusOfficial", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
