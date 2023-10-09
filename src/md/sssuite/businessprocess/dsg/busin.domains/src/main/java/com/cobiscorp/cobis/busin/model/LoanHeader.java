package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LoanHeader {

	public static final String EN_LONHEADER746 = "EN_LONHEADER746";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanHeader";
	
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("ProductType", String.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<Double> PRICEQUOTE = new Property<Double>("PriceQuote", Double.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("Office", String.class, false);
	
	public static final Property<BigDecimal> PROPOSEDAMOUNT = new Property<BigDecimal>("ProposedAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTTODISBURSE = new Property<BigDecimal>("AmounttoDisburse", BigDecimal.class, false);
	
	public static final Property<Date> INITIALDATE = new Property<Date>("InitialDate", Date.class, false);
	
	public static final Property<BigDecimal> VALUEDISCOUNT = new Property<BigDecimal>("ValueDiscount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VALUETODISBURSE = new Property<BigDecimal>("ValuetoDisburse", BigDecimal.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("Customer", String.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("Operation", String.class, false);
	
	public static final Property<BigDecimal> BALANCEOPERATION = new Property<BigDecimal>("BalanceOperation", BigDecimal.class, false);
	
	public static final Property<Integer> PROCESSNUMBER = new Property<Integer>("ProcessNumber", Integer.class, false);
	
	public static final Property<String> OPERATIONBANCK = new Property<String>("OperationBanck", String.class, false);
	
	public static final Property<String> NUMBERLINE = new Property<String>("NumberLine", String.class, false);
	
	public static final Property<String> CREDITLINEVALID = new Property<String>("CreditLineValid", String.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("OfficeId", Integer.class, false);
	
	public static final Property<Boolean> LOCKDELETE = new Property<Boolean>("LockDelete", Boolean.class, false);
	
	public static final Property<String> LOCKCODE = new Property<String>("LockCode", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
