package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectiveRolList {

	public static final String EN_COLLECTRE_695 = "EN_COLLECTRE_695";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectiveRolList";
	
	
	public static final Property<String> IDCOLLECTIVE = new Property<String>("idCollective", String.class, false);
	
	public static final Property<String> COLLECTIVEDESCRIPTION = new Property<String>("collectiveDescription", String.class, false);
	
	public static final Property<String> OFFICIALID = new Property<String>("officialID", String.class, false);
	
	public static final Property<String> OFFICIALNAME = new Property<String>("officialName", String.class, false);
	
	public static final Property<String> ROLEDESCRIPTION = new Property<String>("roleDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
