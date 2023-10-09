package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DocumentsUpload {

	public static final String EN_DOCUMENTO_493 = "EN_DOCUMENTO_493";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DocumentsUpload";
	
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<Boolean> UPLOADS = new Property<Boolean>("uploads", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
