package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GeneralDataValue {

	public static final String EN_GENERALUL_700 = "EN_GENERALUL_700";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralDataValue";
	
	
	public static final Property<String> CODE = new Property<String>("code", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
