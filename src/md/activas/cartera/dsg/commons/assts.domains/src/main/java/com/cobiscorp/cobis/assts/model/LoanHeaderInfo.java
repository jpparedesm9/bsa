package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LoanHeaderInfo {

	public static final String EN_LOANHEAFD_450 = "EN_LOANHEAFD_450";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanHeaderInfo";
	
	
	public static final Property<Integer> LOANID = new Property<Integer>("loanID", Integer.class, false);
	
	public static final Property<String> LOANBANKID = new Property<String>("loanBankID", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<String> CURRENCYNAME = new Property<String>("currencyName", String.class, false);
	
	public static final Property<String> MANAGER = new Property<String>("manager", String.class, false);
	
	public static final Property<Date> EXPIRATION = new Property<Date>("expiration", Date.class, false);
	
	public static final Property<BigDecimal> LOANAMOUNT = new Property<BigDecimal>("loanAmount", BigDecimal.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<BigDecimal> OVERDUEPAYMENT = new Property<BigDecimal>("overduePayment", BigDecimal.class, false);
	
	public static final Property<String> CREDITLINE = new Property<String>("creditLine", String.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
