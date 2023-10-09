package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Payment {

	public static final String EN_PAYMENTZY_669 = "EN_PAYMENTZY_669";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Payment";
	
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> REFERENCEDACCOUNT = new Property<String>("referencedAccount", String.class, false);
	
	public static final Property<Integer> RETENTION = new Property<Integer>("retention", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerID", Integer.class, false);
	
	public static final Property<String> REDUCTIONTYPE = new Property<String>("reductionType", String.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> PAYMENTTYPE = new Property<String>("paymentType", String.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<String> COLLECTIONTYPE = new Property<String>("collectionType", String.class, false);
	
	public static final Property<String> ENTIREFEE = new Property<String>("entireFee", String.class, false);
	
	public static final Property<BigDecimal> QUOTATIONVALUE = new Property<BigDecimal>("quotationValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PAYQUOTATIONVALUE = new Property<BigDecimal>("payQuotationValue", BigDecimal.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<Integer> CURRENCYTYPE = new Property<Integer>("currencyType", Integer.class, false);
	
	public static final Property<String> NUMCHECK = new Property<String>("numCheck", String.class, false);
	
	public static final Property<BigDecimal> FINEPREPAYMENT = new Property<BigDecimal>("finePrepayment", BigDecimal.class, false);
	
	public static final Property<Integer> OPERATIONCURRENCYTYPE = new Property<Integer>("operationCurrencyType", Integer.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<Date> DATEPAY = new Property<Date>("datePay", Date.class, false);
	
	public static final Property<Integer> QUERYSEQUENTIAL = new Property<Integer>("querySequential", Integer.class, false);
	
	public static final Property<String> ADVANCE = new Property<String>("advance", String.class, false);
	
	public static final Property<String> QUOTATION = new Property<String>("quotation", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("customer", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTPREPAYMENT = new Property<BigDecimal>("amountPrepayment", BigDecimal.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<Boolean> ONLINE = new Property<Boolean>("onLine", Boolean.class, false);
	
	public static final Property<Integer> UNAPPLIEDPAYMENTS = new Property<Integer>("unappliedPayments", Integer.class, false);
	
	public static final Property<Integer> SEQUENTIALPAY = new Property<Integer>("sequentialPay", Integer.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final Property<Integer> REGIONAL = new Property<Integer>("regional", Integer.class, false);
	
	public static final Property<String> BILLTO = new Property<String>("billTo", String.class, false);
	
	public static final Property<BigDecimal> UNAPPLIEDAMOUNT = new Property<BigDecimal>("unappliedAmount", BigDecimal.class, false);
	
	public static final Property<String> NOTE = new Property<String>("note", String.class, false);
	
	public static final Property<Double> PREPAYRATE = new Property<Double>("prepayRate", Double.class, false);
	
	public static final Property<String> CONTINUEPAYMENT = new Property<String>("continuePayment", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
