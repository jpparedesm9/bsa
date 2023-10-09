package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ProcessInstance {

	public static final String EN_PROCESSNA_485 = "EN_PROCESSNA_485";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ProcessInstance";
	
	
	public static final Property<Integer> INSTANCEID = new Property<Integer>("instanceId", Integer.class, false);
	
	public static final Property<Integer> COMPANY = new Property<Integer>("company", Integer.class, false);
	
	public static final Property<Integer> ACTIVITYID = new Property<Integer>("activityId", Integer.class, false);
	
	public static final Property<Integer> TRANSACTIONNUMBER = new Property<Integer>("transactionNumber", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
