package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentPlan {

	public static final String EN_PAYMENTLL_576 = "EN_PAYMENTLL_576";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentPlan";
	
	
	public static final Property<BigDecimal> INTEREST = new Property<BigDecimal>("interest", BigDecimal.class, false);
	
	public static final Property<Integer> NUMPAYMENT = new Property<Integer>("numPayment", Integer.class, false);
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VOLUNTARYSAVINGS = new Property<BigDecimal>("voluntarySavings", BigDecimal.class, false);
	
	public static final Property<String> DATEPAYMENT = new Property<String>("datePayment", String.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("balance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERS = new Property<BigDecimal>("others", BigDecimal.class, false);
	
	public static final Property<BigDecimal> EXTRASAVINGS = new Property<BigDecimal>("extraSavings", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
