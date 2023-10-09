package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Credit {

	public static final String EN_CREDITAUT_386 = "EN_CREDITAUT_386";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Credit";
	
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<String> SUBTYPE = new Property<String>("subtype", String.class, false);
	
	public static final Property<String> LINKED = new Property<String>("linked", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final Property<String> BUSINESSSECTOR = new Property<String>("businessSector", String.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final Property<Double> APPROVEDAMOUNT = new Property<Double>("approvedAmount", Double.class, false);
	
	public static final Property<String> NEMONICCURRENCY = new Property<String>("nemonicCurrency", String.class, false);
	
	public static final Property<String> NAMEACTIVITY = new Property<String>("nameActivity", String.class, false);
	
	public static final Property<Double> PERCENTAGEWARRANTY = new Property<Double>("percentageWarranty", Double.class, false);
	
	public static final Property<String> PAYMENTFRECUENCYNAME = new Property<String>("paymentFrecuencyName", String.class, false);
	
	public static final Property<Integer> CREDITCODE = new Property<Integer>("creditCode", Integer.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("productType", String.class, false);
	
	public static final Property<Double> AMOUNTREQUESTED = new Property<Double>("amountRequested", Double.class, false);
	
	public static final Property<BigDecimal> WARRANTYAMOUNT = new Property<BigDecimal>("warrantyAmount", BigDecimal.class, false);
	
	public static final Property<String> PAYMENTFRECUENCY = new Property<String>("paymentFrecuency", String.class, false);
	
	public static final Property<String> ISRENOVATION = new Property<String>("isRenovation", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
