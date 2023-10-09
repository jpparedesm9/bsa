package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ScannedDocuments {

	public static final String EN_SCANNEDOU_199 = "EN_SCANNEDOU_199";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ScannedDocuments";
	
	
	public static final Property<String> MEMBER = new Property<String>("member", String.class, false);
	
	public static final Property<Integer> CUSTOMERTID = new Property<Integer>("customertId", Integer.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
