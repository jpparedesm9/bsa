package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectivePersonFile {

	public static final String EN_COLLECTIE_310 = "EN_COLLECTIE_310";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectivePersonFile";
	
	
	public static final Property<String> SUCCESSRECORDS = new Property<String>("successRecords", String.class, false);
	
	public static final Property<String> FILENAME = new Property<String>("fileName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
