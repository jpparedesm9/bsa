package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ValidationQuotaVsAvailableBalance {

	public static final String EN_VLOAEAACE560 = "EN_VLOAEAACE560";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ValidationQuotaVsAvailableBalance";
	
	
	public static final Property<BigDecimal> MAXIMUMQUOTA = new Property<BigDecimal>("MaximumQuota", BigDecimal.class, false);
	
	public static final Property<Double> MAXIMUMQUOTALINE = new Property<Double>("MaximumQuotaLine", Double.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("Rate", Double.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final Property<Double> SUMQUOTA = new Property<Double>("SumQuota", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
