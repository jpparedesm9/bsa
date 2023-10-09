package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentDetail {

	public static final String EN_PAYMENTTI_348 = "EN_PAYMENTTI_348";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentDetail";
	
	
	public static final Property<Integer> FEE = new Property<Integer>("fee", Integer.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> STATUSDESCRIPTION = new Property<String>("statusDescription", String.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<String> MONEYDESCRIPTION = new Property<String>("moneyDescription", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTMN = new Property<BigDecimal>("amountMn", BigDecimal.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
