package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentPlanHeader {

	public static final String EN_ANTAHEDER771 = "EN_ANTAHEDER771";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentPlanHeader";
	
	
	public static final Property<Date> PAYMENTDAY = new Property<Date>("paymentDay", Date.class, false);
	
	public static final Property<Date> DISPERSIONDATEVALIDATE = new Property<Date>("dispersionDateValidate", Date.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<Character> TYPEPAYMENT = new Property<Character>("typePayment", Character.class, false);
	
	public static final Property<Date> DISPERSIONDATE = new Property<Date>("dispersionDate", Date.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> APPROVEDAMOUNT = new Property<BigDecimal>("approvedAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> APR = new Property<BigDecimal>("apr", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AUXAPPROVEDAMOUNT = new Property<BigDecimal>("auxApprovedAmount", BigDecimal.class, false);
	
	public static final Property<String> DEBITACCOUNT = new Property<String>("debitAccount", String.class, false);
	
	public static final Property<String> CLASSOPERATION = new Property<String>("classOperation", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Character> DEBIT = new Property<Character>("debit", Character.class, false);
	
	public static final Property<Integer> DAYSPERYEAR = new Property<Integer>("daysPerYear", Integer.class, false);
	
	public static final Property<Integer> IDREQUESTED = new Property<Integer>("idRequested", Integer.class, false);
	
	public static final Property<Double> FEE = new Property<Double>("fee", Double.class, false);
	
	public static final Property<Date> INITIALDATE = new Property<Date>("initialDate", Date.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final Property<Integer> LOCALCURRENCY = new Property<Integer>("localCurrency", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("productType", String.class, false);
	
	public static final Property<Integer> OPERATIONCODE = new Property<Integer>("operationCode", Integer.class, false);
	
	public static final Property<BigDecimal> RATE = new Property<BigDecimal>("rate", BigDecimal.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("currency", Integer.class, false);
	
	public static final Property<BigDecimal> SHAREVALUE = new Property<BigDecimal>("shareValue", BigDecimal.class, false);
	
	public static final Property<Date> FIRSTEXPIRATIONFEEDATE = new Property<Date>("firstExpirationFeeDate", Date.class, false);
	
	public static final Property<BigDecimal> SUMAMOUNT = new Property<BigDecimal>("sumAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TEA = new Property<BigDecimal>("tea", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TIR = new Property<BigDecimal>("tir", BigDecimal.class, false);
	
	public static final Property<String> WAYTOPAY = new Property<String>("wayToPay", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
