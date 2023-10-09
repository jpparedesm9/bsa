package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class AuthorizationTransferDetail {

	public static final String EN_AUTHORINI_858 = "EN_AUTHORINI_858";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AuthorizationTransferDetail";
	
	
	public static final Property<String> NAMES = new Property<String>("names", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
