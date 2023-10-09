package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CreditCandidates {

	public static final String EN_CREDITCAI_379 = "EN_CREDITCAI_379";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CreditCandidates";
	
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<Boolean> ISCHECKED = new Property<Boolean>("isChecked", Boolean.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<Date> DATEDISPERSION = new Property<Date>("dateDispersion", Date.class, false);
	
	public static final Property<String> AUXTEXT = new Property<String>("auxText", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> OFFICERASSIGNED = new Property<String>("officerAssigned", String.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<Integer> OFFICERASSIGNEDID = new Property<Integer>("officerAssignedId", Integer.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeId", Integer.class, false);
	
	public static final Property<String> PERIODICITY = new Property<String>("periodicity", String.class, false);
	
	public static final Property<Date> DATEINSERTION = new Property<Date>("dateInsertion", Date.class, false);
	
	public static final Property<String> OFFICERREASSIGNED = new Property<String>("officerReassigned", String.class, false);
	
	public static final Property<Integer> OFFICERREASSIGNEDID = new Property<Integer>("officerReassignedId", Integer.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
