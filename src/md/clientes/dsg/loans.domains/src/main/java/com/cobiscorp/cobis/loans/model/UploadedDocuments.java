package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class UploadedDocuments {

	public static final String EN_UPLOADECU_469 = "EN_UPLOADECU_469";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "UploadedDocuments";
	
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<Boolean> UPLOADS = new Property<Boolean>("uploads", Boolean.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
