package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ExecutiveBonusHeader {

	public static final String EN_ECUTEOUER953 = "EN_ECUTEOUER953";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExecutiveBonusHeader";
	
	
	public static final Property<String> DATEPROCESS = new Property<String>("dateProcess", String.class, false);
	
	public static final Property<String> EXECUTIVE = new Property<String>("executive", String.class, false);
	
	public static final Property<Integer> IDSUPERVISOR = new Property<Integer>("idSupervisor", Integer.class, false);
	
	public static final Property<Integer> IDCODE = new Property<Integer>("idCode", Integer.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final Property<String> USERL = new Property<String>("userL", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
