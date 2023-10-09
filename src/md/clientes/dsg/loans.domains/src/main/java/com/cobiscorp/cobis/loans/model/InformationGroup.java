package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class InformationGroup {

	public static final String EN_INATIONPO_116 = "EN_INATIONPO_116";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InformationGroup";
	
	
	public static final Property<String> DELIVERDATE = new Property<String>("deliverDate", String.class, false);
	
	public static final Property<String> GROUPMEETING = new Property<String>("groupMeeting", String.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> ADVISER = new Property<String>("adviser", String.class, false);
	
	public static final Property<Double> AMOUNTBORROWED = new Property<Double>("amountBorrowed", Double.class, false);
	
	public static final Property<Double> INTERESTRATE = new Property<Double>("interestRate", Double.class, false);
	
	public static final Property<Integer> CYCLE = new Property<Integer>("cycle", Integer.class, false);
	
	public static final Property<String> DESTINATION = new Property<String>("destination", String.class, false);
	
	public static final Property<String> BRANCHOFFICE = new Property<String>("branchOffice", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<String> TERM = new Property<String>("term", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
