package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Context {

	public static final String EN_CONTEXTVM_800 = "EN_CONTEXTVM_800";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Context";
	
	
	public static final Property<Integer> CHANNEL = new Property<Integer>("channel", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
