package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class EmergentList {

	public static final String EN_MEGETLIST633 = "EN_MEGETLIST633";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EmergentList";
	
	
	public static final Property<String> CODACTIVITIESEM = new Property<String>("CodActivitiesEm", String.class, false);
	
	public static final Property<String> DESCRIPTIONEM = new Property<String>("DescriptionEm", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
