package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CodeVerification {

	public static final String EN_CODEVERAT_366 = "EN_CODEVERAT_366";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CodeVerification";
	
	
	public static final Property<Integer> CSTMRCODE = new Property<Integer>("cstmrCode", Integer.class, false);

	public static final Property<String> CODE = new Property<String>("code", String.class, false);
	
    public static final Property<String> PHONENUMBER = new Property<String>("phoneNumber", String.class, false);
	
	public static final Property<String> VALTYPE = new Property<String>("valType", String.class, false);
	
	public static final Property<Integer> FAILURECOUNTER = new Property<Integer>("failureCounter", Integer.class, false);
	
	public static final Property<Integer> ADDRESSID = new Property<Integer>("addressId", Integer.class, false);
	
	public static final Property<String> PTOKENLEN = new Property<String>("pTokenLen", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
