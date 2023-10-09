package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConsultationAccounts {

	public static final String EN_ULATNCOUN431 = "EN_ULATNCOUN431";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConsultationAccounts";
	
	
	public static final Property<String> ACCOUNT = new Property<String>("Account", String.class, false);
	
	public static final Property<String> ACCOUNTDESCRIPTION = new Property<String>("AccountDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
