package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RejectTransact {

	public static final String EN_REJECTTAA_797 = "EN_REJECTTAA_797";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RejectTransact";
	
	
	public static final Property<Integer> TRANSACT = new Property<Integer>("transact", Integer.class, false);
	
	public static final Property<String> REASON = new Property<String>("reason", String.class, false);
	
	public static final Property<String> EXCUSE = new Property<String>("excuse", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
