package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class NegotiablePayments {

	public static final String EN_GTIBPENTS486 = "EN_GTIBPENTS486";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "NegotiablePayments";
	
	
	public static final Property<BigDecimal> PAYMENTONE = new Property<BigDecimal>("paymentOne", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PAYMENTTWO = new Property<BigDecimal>("paymentTwo", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final Property<BigDecimal> NEGOTIABLEBALANCE = new Property<BigDecimal>("negotiableBalance", BigDecimal.class, false);
	
	public static final Property<String> APPLICATIONDATE = new Property<String>("applicationDate", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
