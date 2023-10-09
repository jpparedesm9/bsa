package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QueryDocumentsCycle {

	public static final String EN_DOCUMENTS_548 = "EN_DOCUMENTS_548";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QueryDocumentsCycle";
	
	
	public static final Property<Integer> PROCEDURE = new Property<Integer>("procedure", Integer.class, false);
	
	public static final Property<String> LOAN = new Property<String>("loan", String.class, false);
	
	public static final Property<Integer> PROCESSINSTANCE = new Property<Integer>("processInstance", Integer.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<Integer> GROUPCYCLE = new Property<Integer>("groupCycle", Integer.class, false);
	
	public static final Property<String> GROUPCYCLEDETAIL = new Property<String>("groupCycleDetail", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
