package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RoleHierarchy {

	public static final String EN_OLHIERCHY364 = "EN_OLHIERCHY364";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RoleHierarchy";
	
	
	public static final Property<Integer> HIERARCHYID = new Property<Integer>("HierarchyId", Integer.class, false);
	
	public static final Property<Integer> ROLEHIERARCHYIDINI = new Property<Integer>("RoleHierarchyIdIni", Integer.class, false);
	
	public static final Property<String> ROLEHIERARCHYDESCINI = new Property<String>("RoleHierarchyDescIni", String.class, false);
	
	public static final Property<Integer> ROLEHIERARCHYIDEND = new Property<Integer>("RoleHierarchyIdEnd", Integer.class, false);
	
	public static final Property<String> ROLEHIERARCHYDESCEND = new Property<String>("RoleHierarchyDescEnd", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
