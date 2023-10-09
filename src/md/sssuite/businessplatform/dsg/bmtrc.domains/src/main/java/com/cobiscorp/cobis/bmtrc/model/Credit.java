package com.cobiscorp.cobis.bmtrc.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Credit {

	public static final String EN_CREDITKKB_484 = "EN_CREDITKKB_484";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Credit";
	
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("productType", String.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final Property<String> CYCLENUMBER = new Property<String>("cycleNumber", String.class, false);
	
	public static final Property<Integer> CREDITCODE = new Property<Integer>("creditCode", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTREQUESTED = new Property<BigDecimal>("amountRequested", BigDecimal.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("sector", String.class, false);
	
	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);
	
	public static final Property<BigDecimal> APPROVEDAMOUNT = new Property<BigDecimal>("approvedAmount", BigDecimal.class, false);
	
	public static final Property<String> PAYMENTFRECUENCY = new Property<String>("paymentFrecuency", String.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final Property<Integer> OFFICE = new Property<Integer>("office", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
