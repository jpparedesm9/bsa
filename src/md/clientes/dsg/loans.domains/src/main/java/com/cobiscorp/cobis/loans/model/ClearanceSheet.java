package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ClearanceSheet {

	public static final String EN_CLEARANTC_795 = "EN_CLEARANTC_795";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ClearanceSheet";
	
	
	public static final Property<BigDecimal> AMOUNTAPPROVED = new Property<BigDecimal>("amountApproved", BigDecimal.class, false);
	
	public static final Property<String> SIGNATURE = new Property<String>("signature", String.class, false);
	
	public static final Property<BigDecimal> INCENTIVE = new Property<BigDecimal>("incentive", BigDecimal.class, false);
	
	public static final Property<String> NAMECUSTOMER = new Property<String>("nameCustomer", String.class, false);
	
	public static final Property<BigDecimal> VALUESDISCOUNTING = new Property<BigDecimal>("valuesDiscounting", BigDecimal.class, false);
	
	public static final Property<String> LOAN = new Property<String>("loan", String.class, false);
	
	public static final Property<Integer> NUMBERCLEARANCE = new Property<Integer>("numberClearance", Integer.class, false);
	
	public static final Property<String> CHECKCLEARANCE = new Property<String>("checkClearance", String.class, false);
	
	public static final Property<String> NETTODELIVER = new Property<String>("netToDeliver", String.class, false);
	
	public static final Property<BigDecimal> SAVING = new Property<BigDecimal>("saving", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
