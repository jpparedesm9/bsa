package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class RefinanceDetailLoans {

	public static final String EN_REFINANLA_273 = "EN_REFINANLA_273";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinanceDetailLoans";
	
	
	public static final Property<String> LOANNUMBER = new Property<String>("loanNumber", String.class, false);
	
	public static final Property<Integer> CURRENCYCODE = new Property<Integer>("currencyCode", Integer.class, false);
	
	public static final Property<String> CURRENCYNAME = new Property<String>("currencyName", String.class, false);
	
	public static final Property<String> LOANTYPECODE = new Property<String>("loanTypeCode", String.class, false);
	
	public static final Property<String> LOANTYPENAME = new Property<String>("loanTypeName", String.class, false);
	
	public static final Property<BigDecimal> LOANAMOUNT = new Property<BigDecimal>("loanAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTTOCANCEL = new Property<BigDecimal>("amountToCancel", BigDecimal.class, false);
	
	public static final Property<BigDecimal> DELIVERCUSTOMER = new Property<BigDecimal>("deliverCustomer", BigDecimal.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("observations", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
