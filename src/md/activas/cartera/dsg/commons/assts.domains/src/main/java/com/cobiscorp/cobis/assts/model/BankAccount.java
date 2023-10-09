package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class BankAccount {

	public static final String EN_BANKACCNN_291 = "EN_BANKACCNN_291";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "BankAccount";
	
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> ACCOUNTNAME = new Property<String>("accountName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
