package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RefinanceLoansItems {

	public static final String EN_REFINANOM_289 = "EN_REFINANOM_289";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinanceLoansItems";
	
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> CONCEPTSTATUS = new Property<String>("conceptStatus", String.class, false);
	
	public static final Property<String> PREVIOWSDUTY = new Property<String>("previowsDuty", String.class, false);
	
	public static final Property<String> QUOTASTATUS = new Property<String>("quotaStatus", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
