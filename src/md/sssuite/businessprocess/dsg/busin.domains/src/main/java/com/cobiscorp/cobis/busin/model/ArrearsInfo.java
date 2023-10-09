package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ArrearsInfo {

	public static final String EN_ARREARNFO773 = "EN_ARREARNFO773";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ArrearsInfo";
	
	
	public static final Property<Integer> CREDITNUMBER = new Property<Integer>("creditNumber", Integer.class, false);
	
	public static final Property<String> OPERATIONBANK = new Property<String>("operationBank", String.class, false);
	
	public static final Property<Integer> PROCESSEDNUMBER = new Property<Integer>("processedNumber", Integer.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeId", Integer.class, false);
	
	public static final Property<Integer> PROVINCE = new Property<Integer>("province", Integer.class, false);
	
	public static final Property<Integer> CITY = new Property<Integer>("city", Integer.class, false);
	
	public static final Property<String> REQUESTEDDESTINATION = new Property<String>("requestedDestination", String.class, false);
	
	public static final Property<Integer> REQUESTEDCURRENCY = new Property<Integer>("requestedCurrency", Integer.class, false);
	
	public static final Property<Date> DISBURSEMENTDATE = new Property<Date>("disbursementDate", Date.class, false);
	
	public static final Property<String> CREDITSTATUS = new Property<String>("creditStatus", String.class, false);
	
	public static final Property<Integer> NUMBEROFCREDITSEARNED = new Property<Integer>("numberOfCreditsEarned", Integer.class, false);
	
	public static final Property<Integer> OVERDUEDAYS = new Property<Integer>("overdueDays", Integer.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("Official", String.class, false);
	
	public static final Property<BigDecimal> COMMITTEDAMOUNT = new Property<BigDecimal>("committedAmount", BigDecimal.class, false);
	
	public static final Property<String> PAYMENTFREQUENCY = new Property<String>("paymentFrequency", String.class, false);
	
	public static final Property<BigDecimal> CAPITALOVERDUEQUOTES = new Property<BigDecimal>("capitalOverdueQuotes", BigDecimal.class, false);
	
	public static final Property<String> USERL = new Property<String>("userL", String.class, false);
	
	public static final Property<String> CUSTOMERORIGINALACTIVITY = new Property<String>("CustomerOriginalActivity", String.class, false);
	
	public static final Property<String> CUSTOMERCURRENTACTIVITY = new Property<String>("CustomerCurrentActivity", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
