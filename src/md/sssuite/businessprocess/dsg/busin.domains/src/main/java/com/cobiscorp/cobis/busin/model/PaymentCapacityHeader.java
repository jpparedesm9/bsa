package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PaymentCapacityHeader {

	public static final String EN_AYENTACTE293 = "EN_AYENTACTE293";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentCapacityHeader";
	
	
	public static final Property<Integer> PERIODGRACE = new Property<Integer>("PeriodGrace", Integer.class, false);
	
	public static final Property<Integer> STARTMONTH = new Property<Integer>("StartMonth", Integer.class, false);
	
	public static final Property<Integer> COUNTTERM = new Property<Integer>("CountTerm", Integer.class, false);
	
	public static final Property<Boolean> VALIDATIONSUCCESS = new Property<Boolean>("ValidationSuccess", Boolean.class, false);
	
	public static final Property<String> STATUS = new Property<String>("Status", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
