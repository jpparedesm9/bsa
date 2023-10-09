package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectiveRole {

	public static final String EN_COLLECTLI_340 = "EN_COLLECTLI_340";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectiveRole";
	
	
	public static final Property<String> COLLECTIVE = new Property<String>("collective", String.class, false);
	
	public static final Property<String> COLLECTIVEDESCRIPTION = new Property<String>("collectiveDescription", String.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("official", String.class, false);
	
	public static final Property<String> ROLEDESCRIPTION = new Property<String>("roleDescription", String.class, false);
	
	public static final Property<String> ROLE = new Property<String>("role", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
