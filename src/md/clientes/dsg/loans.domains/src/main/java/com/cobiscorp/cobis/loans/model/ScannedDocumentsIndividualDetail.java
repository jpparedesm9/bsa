package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ScannedDocumentsIndividualDetail {

	public static final String EN_SCANNEDTI_109 = "EN_SCANNEDTI_109";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ScannedDocumentsIndividualDetail";
	
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> UPLOADED = new Property<String>("uploaded", String.class, false);
	
	public static final Property<String> FILE = new Property<String>("file", String.class, false);
	
	public static final Property<String> EXTENSION = new Property<String>("extension", String.class, false);
	
	public static final Property<String> DOCUMENTID = new Property<String>("documentId", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
