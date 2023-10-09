package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Member {

	public static final String EN_MEMBERWLM_444 = "EN_MEMBERWLM_444";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Member";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> QUALIFICATION = new Property<String>("qualification", String.class, false);
	
	public static final Property<Boolean> HASINDIVIDUALACCOUNTAUX = new Property<Boolean>("hasIndividualAccountAux", Boolean.class, false);
	
	public static final Property<Date> MEMBERSHIPDATE = new Property<Date>("membershipDate", Date.class, false);
	
	public static final Property<Integer> POINTS = new Property<Integer>("points", Integer.class, false);
	
	public static final Property<Double> SAVINGVOLUNTARY = new Property<Double>("savingVoluntary", Double.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<Integer> CREDITCODE = new Property<Integer>("creditCode", Integer.class, false);
	
	public static final Property<String> ROLE = new Property<String>("role", String.class, false);
	
	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);
	
	public static final Property<String> QUALIFICATIONID = new Property<String>("qualificationId", String.class, false);
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<String> ROLEID = new Property<String>("roleId", String.class, false);
	
	public static final Property<String> LEVEL = new Property<String>("level", String.class, false);
	
	public static final Property<String> CHECKRENAPO = new Property<String>("checkRenapo", String.class, false);
	
	public static final Property<Date> DISCONNECTIONDATE = new Property<Date>("disconnectionDate", Date.class, false);
	
	public static final Property<String> CTAINDIVIDUAL = new Property<String>("ctaIndividual", String.class, false);
	
	public static final Property<Integer> NUMBERCYCLEPERSONGROUP = new Property<Integer>("numberCyclePersonGroup", Integer.class, false);
	
	public static final Property<String> STATEID = new Property<String>("stateId", String.class, false);
	
	public static final Property<Character> OPERATION = new Property<Character>("operation", Character.class, false);
	
	public static final Property<String> MEETINGPLACE = new Property<String>("meetingPlace", String.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("customer", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
