package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class OriginalHeader {

	public static final String EN_ORIGINARE_498 = "EN_ORIGINARE_498";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "OriginalHeader";
	
	
	public static final Property<String> CURRENCYREQUESTED = new Property<String>("currencyRequested", String.class, false);
	
	public static final Property<String> IDREQUESTED = new Property<String>("iDRequested", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final Property<String> SUBTYPE = new Property<String>("subType", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTAPROVED = new Property<BigDecimal>("amountAproved", BigDecimal.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("applicationNumber", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTREQUESTED = new Property<BigDecimal>("amountRequested", BigDecimal.class, false);
	
	public static final Property<Date> INITIALDATE = new Property<Date>("initialDate", Date.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("productType", String.class, false);
	
	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);
	
	public static final Property<String> OFFICERNAME = new Property<String>("officerName", String.class, false);
	
	public static final Property<String> PAYMENTFREQUENCY = new Property<String>("paymentFrequency", String.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
