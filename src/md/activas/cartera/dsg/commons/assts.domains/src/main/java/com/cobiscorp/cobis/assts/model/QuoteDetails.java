package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class QuoteDetails {

	public static final String EN_QUOTEDETA_803 = "EN_QUOTEDETA_803";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuoteDetails";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<BigDecimal> EXPIRED = new Property<BigDecimal>("expired", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ACTIVE = new Property<BigDecimal>("active", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INACTIVE = new Property<BigDecimal>("inactive", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
