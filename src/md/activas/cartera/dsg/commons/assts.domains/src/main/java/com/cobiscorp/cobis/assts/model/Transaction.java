package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Transaction {

	public static final String EN_TRANSACON_612 = "EN_TRANSACON_612";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Transaction";
	
	
	public static final Property<String> CURRENCY = new Property<String>("currency", String.class, false);
	
	public static final Property<String> VALUEDATE = new Property<String>("valueDate", String.class, false);
	
	public static final Property<BigDecimal> AMMOUNT = new Property<BigDecimal>("ammount", BigDecimal.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final Property<String> REGISTERDATE = new Property<String>("registerDate", String.class, false);
	
	public static final Property<String> TRANSACTIONID = new Property<String>("transactionId", String.class, false);
	
	public static final Property<String> PAYMENTWAY = new Property<String>("paymentWay", String.class, false);
	
	public static final Property<String> TRANSACTIONSTATUS = new Property<String>("transactionStatus", String.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> CORRESPONSALID = new Property<String>("corresponsalId", String.class, false);
	
	public static final Property<String> TRANSACTIONTYPE = new Property<String>("transactionType", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
