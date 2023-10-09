package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class UploadFile {

	public static final String EN_UPLOADFEL_340 = "EN_UPLOADFEL_340";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "UploadFile";
	
	
	public static final Property<String> UPLOADERRORS = new Property<String>("uploadErrors", String.class, false);
	
	public static final Property<String> CONCILIATIONFILE = new Property<String>("conciliationFile", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
