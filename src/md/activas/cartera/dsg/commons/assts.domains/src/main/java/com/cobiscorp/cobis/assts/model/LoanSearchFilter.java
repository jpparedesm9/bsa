package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanSearchFilter {

	public static final String EN_LOANSEACI_824 = "EN_LOANSEACI_824";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanSearchFilter";
	
	
	public static final Property<Integer> CATEGORY = new Property<Integer>("category", Integer.class, false);
	
	public static final Property<String> GROUP = new Property<String>("group", String.class, false);
	
	public static final Property<Integer> CODCLIENT = new Property<Integer>("codClient", Integer.class, false);
	
	public static final Property<Boolean> AVANCESEARCH = new Property<Boolean>("avanceSearch", Boolean.class, false);
	
	public static final Property<Boolean> ISGROUP = new Property<Boolean>("isGroup", Boolean.class, false);
	
	public static final Property<Character> ISDISBURSMENT = new Property<Character>("isDisbursment", Character.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<String> MIGRATEDOPER = new Property<String>("migratedOper", String.class, false);
	
	public static final Property<Integer> OFFICER = new Property<Integer>("officer", Integer.class, false);
	
	public static final Property<String> NUMIDENTIFICATION = new Property<String>("numIdentification", String.class, false);
	
	public static final Property<Integer> CODCURRENCY = new Property<Integer>("codCurrency", Integer.class, false);
	
	public static final Property<Date> DISBURSEMENTDATE = new Property<Date>("disbursementDate", Date.class, false);
	
	public static final Property<String> GROUPSUMMARY = new Property<String>("groupSummary", String.class, false);
	
	public static final Property<String> NUMPROCEDURES = new Property<String>("numProcedures", String.class, false);
	
	public static final Property<Integer> OFFICE = new Property<Integer>("office", Integer.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
