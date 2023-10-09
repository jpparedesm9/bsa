package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DetailAmountsToCancel {

	public static final String EN_DETAILANC_439 = "EN_DETAILANC_439";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailAmountsToCancel";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> ITEM = new Property<String>("item", String.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
