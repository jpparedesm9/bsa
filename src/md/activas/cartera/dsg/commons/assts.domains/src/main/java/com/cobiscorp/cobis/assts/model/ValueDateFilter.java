package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ValueDateFilter {

	public static final String EN_VALUEDAET_237 = "EN_VALUEDAET_237";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ValueDateFilter";
	
	
	public static final Property<Date> VALUEDATE = new Property<Date>("valueDate", Date.class, false);
	
	public static final Property<String> OPERATIONTYPE = new Property<String>("operationType", String.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<Integer> INDEXTRN = new Property<Integer>("indexTrn", Integer.class, false);
	
	public static final Property<String> OPTION = new Property<String>("option", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
