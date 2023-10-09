package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class InfoPayment {

	public static final String EN_IFPAYMENT499 = "EN_IFPAYMENT499";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InfoPayment";
	
	
	public static final Property<String> TITLECOLUMN = new Property<String>("titleColumn", String.class, false);
	
	public static final Property<BigDecimal> AGREEDPAYMENT = new Property<BigDecimal>("agreedPayment", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PAYMENTPAID = new Property<BigDecimal>("paymentPaid", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("balance", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
