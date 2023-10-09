package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Sponsor {

	public static final String EN_SPONSORST_532 = "EN_SPONSORST_532";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Sponsor";
	
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final Property<String> SPONSORNAME = new Property<String>("sponsorName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
