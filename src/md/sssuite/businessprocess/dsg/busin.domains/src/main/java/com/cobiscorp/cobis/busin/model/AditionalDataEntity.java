package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AditionalDataEntity {

	public static final String EN_ADITIONLA_444 = "EN_ADITIONLA_444";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AditionalDataEntity";
	
	
	public static final Property<String> DATO1 = new Property<String>("dato1", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
