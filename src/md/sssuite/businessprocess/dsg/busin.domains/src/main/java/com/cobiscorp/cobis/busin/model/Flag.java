package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Flag {

	public static final String EN_FLAGDMKRN641 = "EN_FLAGDMKRN641";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Flag";
	
	
	public static final Property<Integer> FLAG = new Property<Integer>("flag", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
