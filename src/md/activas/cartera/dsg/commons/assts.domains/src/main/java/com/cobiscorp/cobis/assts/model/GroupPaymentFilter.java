package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GroupPaymentFilter {

	public static final String EN_GROUPPAME_264 = "EN_GROUPPAME_264";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GroupPaymentFilter";
	
	
	public static final Property<String> GROUP = new Property<String>("group", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
