package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class TransactionDetail {

	public static final String EN_TRANSACOI_988 = "EN_TRANSACOI_988";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TransactionDetail";
	
	
	public static final Property<String> TRANSACTIONCONCEPT = new Property<String>("transactionConcept", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> TRANSACTIONSTATUS = new Property<String>("transactionStatus", String.class, false);
	
	public static final Property<String> TRANSACTIONFEE = new Property<String>("transactionFee", String.class, false);
	
	public static final Property<String> VALUECODE = new Property<String>("valueCode", String.class, false);
	
	public static final Property<String> SEQUENCE = new Property<String>("sequence", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
