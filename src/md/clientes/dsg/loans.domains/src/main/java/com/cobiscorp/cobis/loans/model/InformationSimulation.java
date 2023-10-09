package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class InformationSimulation {

	public static final String EN_INATIONAL_415 = "EN_INATIONAL_415";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InformationSimulation";
	
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final Property<String> NAMECLIENT = new Property<String>("nameClient", String.class, false);
	
	public static final Property<Integer> NUMQUOTA = new Property<Integer>("numQuota", Integer.class, false);
	
	public static final Property<Date> PAYMENTDATE = new Property<Date>("paymentDate", Date.class, false);
	
	public static final Property<Double> INTEREST = new Property<Double>("interest", Double.class, false);
	
	public static final Property<Double> TOTALQUOTA = new Property<Double>("totalQuota", Double.class, false);
	
	public static final Property<Double> CAPITALBALANCE = new Property<Double>("capitalBalance", Double.class, false);
	
	public static final Property<BigDecimal> AMOUNTREQUEST = new Property<BigDecimal>("amountRequest", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
