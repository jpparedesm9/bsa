package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Insurance {

	public static final String EN_INSURANCE408 = "EN_INSURANCE408";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Insurance";
	
	
	public static final Property<String> INSURANCECODE = new Property<String>("insuranceCode", String.class, false);
	
	public static final Property<String> INSURANCETYPE = new Property<String>("insuranceType", String.class, false);
	
	public static final Property<String> INSURANCECOMPANY = new Property<String>("insuranceCompany", String.class, false);
	
	public static final Property<BigDecimal> INSURANCEVALUE = new Property<BigDecimal>("insuranceValue", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
