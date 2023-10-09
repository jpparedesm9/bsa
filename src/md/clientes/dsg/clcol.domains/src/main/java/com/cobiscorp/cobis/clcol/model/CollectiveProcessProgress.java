package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectiveProcessProgress {

	public static final String EN_COLLECTEC_545 = "EN_COLLECTEC_545";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectiveProcessProgress";
	
	
	public static final Property<String> PROGRESS = new Property<String>("progress", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
