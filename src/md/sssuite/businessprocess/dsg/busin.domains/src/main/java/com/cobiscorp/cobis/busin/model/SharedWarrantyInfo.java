package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SharedWarrantyInfo {

	public static final String EN_SHAREDWRR_168 = "EN_SHAREDWRR_168";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SharedWarrantyInfo";
	
	
	public static final Property<Character> SHARED = new Property<Character>("shared", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
