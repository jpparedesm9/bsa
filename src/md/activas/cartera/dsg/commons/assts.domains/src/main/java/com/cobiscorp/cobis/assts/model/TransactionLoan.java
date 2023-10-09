package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class TransactionLoan {

	public static final String EN_TRANSACOA_147 = "EN_TRANSACOA_147";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TransactionLoan";
	
	
	public static final Property<String> TRANSACTIONID = new Property<String>("transactionId", String.class, false);
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<String> DATETRAN = new Property<String>("dateTran", String.class, false);
	
	public static final Property<String> DATEREF = new Property<String>("dateRef", String.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
