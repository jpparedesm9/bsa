package com.cobiscorp.cobis.bmtrc.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AdditionalInformation {

	public static final String EN_ADDITIOLA_239 = "EN_ADDITIOLA_239";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AdditionalInformation";
	
	
	public static final Property<String> ENVIRONMENT = new Property<String>("environment", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
