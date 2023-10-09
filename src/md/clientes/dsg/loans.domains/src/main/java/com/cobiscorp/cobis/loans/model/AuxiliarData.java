package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AuxiliarData {

	public static final String EN_AUXILIART_213 = "EN_AUXILIART_213";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AuxiliarData";
	
	
	public static final Property<String> GROUPSTATUSVALIDATION = new Property<String>("groupStatusValidation", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
