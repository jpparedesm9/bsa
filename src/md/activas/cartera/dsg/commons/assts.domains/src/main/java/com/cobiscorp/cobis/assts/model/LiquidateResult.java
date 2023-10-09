package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LiquidateResult {

	public static final String EN_LIQUIDATT_728 = "EN_LIQUIDATT_728";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LiquidateResult";
	
	
	public static final Property<BigDecimal> SUMTOTAL = new Property<BigDecimal>("sumTotal", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
