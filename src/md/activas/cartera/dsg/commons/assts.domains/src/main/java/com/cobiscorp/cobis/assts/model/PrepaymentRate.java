package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PrepaymentRate {

	public static final String EN_PREPAYMAA_382 = "EN_PREPAYMAA_382";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PrepaymentRate";
	
	
	public static final Property<Double> PERCENTAGE = new Property<Double>("percentage", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
