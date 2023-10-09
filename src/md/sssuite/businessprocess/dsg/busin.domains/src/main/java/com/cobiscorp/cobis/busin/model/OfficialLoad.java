package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class OfficialLoad {

	public static final String EN_OICIALLOA020 = "EN_OICIALLOA020";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "OfficialLoad";
	
	
	public static final Property<Integer> CODEOFFICIAL = new Property<Integer>("CodeOfficial", Integer.class, false);
	
	public static final Property<String> NAME = new Property<String>("Name", String.class, false);
	
	public static final Property<Integer> INPROCESS = new Property<Integer>("InProcess", Integer.class, false);
	
	public static final Property<Integer> DISBURSED = new Property<Integer>("Disbursed", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
