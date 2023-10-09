package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DisbursementResult {

	public static final String EN_DISBURSTE_282 = "EN_DISBURSTE_282";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DisbursementResult";
	
	
	public static final Property<BigDecimal> SUMTOTAL = new Property<BigDecimal>("sumTotal", BigDecimal.class, false);
	
	public static final Property<BigDecimal> DIFFERENCE = new Property<BigDecimal>("difference", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
