package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ActivitiesList {

	public static final String EN_ATVITSIST298 = "EN_ATVITSIST298";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ActivitiesList";
	
	
	public static final Property<String> CODACTIVITIES = new Property<String>("CodActivities", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
