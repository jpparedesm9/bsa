package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ResultQueryByFilter {

	public static final String EN_RESULTBTI_148 = "EN_RESULTBTI_148";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ResultQueryByFilter";
	
	
	public static final Property<Character> CLIENTTYPE = new Property<Character>("clientType", Character.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> DOCUMENTTYPE = new Property<String>("documentType", String.class, false);
	
	public static final Property<Date> ENTRYDATE = new Property<Date>("entryDate", Date.class, false);
	
	public static final Property<String> DOCUMENTNAME = new Property<String>("documentName", String.class, false);
	
	public static final Property<String> FOLDER = new Property<String>("folder", String.class, false);
	
	public static final Property<String> EXTENSION = new Property<String>("extension", String.class, false);
	
	public static final Property<String> CODDOCUMENTTYPE = new Property<String>("codDocumentType", String.class, false);
	
	public static final Property<Integer> PROCEDURENUMBER = new Property<Integer>("procedureNumber", Integer.class, false);
	
	public static final Property<String> CLIENTGROUPNAME = new Property<String>("clientGroupName", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<Integer> PROCESSID = new Property<Integer>("processId", Integer.class, false);
	
	public static final Property<Boolean> SHOWRECENTDOCUMENT = new Property<Boolean>("showRecentDocument", Boolean.class, false);
	
	public static final Property<Boolean> SHOWDOCUMENTHISTORY = new Property<Boolean>("showDocumentHistory", Boolean.class, false);
	
	public static final Property<String> LOANNUMBER = new Property<String>("loanNumber", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
