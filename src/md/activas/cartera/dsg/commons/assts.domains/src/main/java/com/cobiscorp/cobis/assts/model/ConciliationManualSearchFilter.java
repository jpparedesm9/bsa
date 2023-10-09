package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConciliationManualSearchFilter {

	public static final String EN_CONCILIAH_649 = "EN_CONCILIAH_649";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConciliationManualSearchFilter";
	
	
	public static final Property<Character> CONCILIATE = new Property<Character>("conciliate", Character.class, false);
	
	public static final Property<Character> NOTCONCILIATIONREASON = new Property<Character>("notConciliationReason", Character.class, false);
	
	public static final Property<String> CONCILIATIONTYPE = new Property<String>("conciliationType", String.class, false);
	
	public static final Property<String> CUSTOMTYPE = new Property<String>("customType", String.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<Character> PAYMENTSTATE = new Property<Character>("paymentState", Character.class, false);
	
	public static final Property<Integer> CUSTOMCODE = new Property<Integer>("customCode", Integer.class, false);
	
	public static final Property<Date> DATEUNTIL = new Property<Date>("dateUntil", Date.class, false);
	
	public static final Property<Date> DATEFROM = new Property<Date>("dateFrom", Date.class, false);
	
	public static final Property<Integer> CORRESPTRANSACTIONCODE = new Property<Integer>("correspTransactionCode", Integer.class, false);
	
	public static final Property<String> CORRESPONDENT = new Property<String>("correspondent", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
