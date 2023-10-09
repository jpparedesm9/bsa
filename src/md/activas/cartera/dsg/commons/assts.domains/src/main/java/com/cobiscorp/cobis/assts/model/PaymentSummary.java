package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentSummary {

	public static final String EN_PAYMENTMR_759 = "EN_PAYMENTMR_759";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentSummary";
	
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> PAYMENTWAY = new Property<String>("paymentWay", String.class, false);
	
	public static final Property<String> CORRESPONSALID = new Property<String>("corresponsalId", String.class, false);
	
	public static final Property<String> VALUEDATE = new Property<String>("valueDate", String.class, false);
	
	public static final Property<String> MESSAGE = new Property<String>("message", String.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<Integer> PAYMENTID = new Property<Integer>("paymentId", Integer.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("currency", String.class, false);
	
	public static final Property<String> PAYMENTSTATUS = new Property<String>("paymentStatus", String.class, false);
	
	public static final Property<String> REGISTERDATE = new Property<String>("registerDate", String.class, false);
	
	public static final Property<Integer> SEQUENTIALQUERY = new Property<Integer>("sequentialQuery", Integer.class, false);
	
	public static final Property<Integer> SEQUENTIALIDENTITY = new Property<Integer>("sequentialIdentity", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
