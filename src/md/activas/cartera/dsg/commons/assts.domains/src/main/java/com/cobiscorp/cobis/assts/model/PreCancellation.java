package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PreCancellation {

	public static final String EN_PRECANCOO_259 = "EN_PRECANCOO_259";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PreCancellation";
	
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientID", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTOP = new Property<BigDecimal>("amountOP", BigDecimal.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<Boolean> ISINSURENCECHANGED = new Property<Boolean>("isInsurenceChanged", Boolean.class, false);
	
	public static final Property<String> BANKID = new Property<String>("bankID", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTINSURENCE = new Property<BigDecimal>("amountInsurence", BigDecimal.class, false);
	
	public static final Property<String> PROCESSDATE = new Property<String>("processDate", String.class, false);
	
	public static final Property<Integer> OPERATIONID = new Property<Integer>("operationID", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTPRE = new Property<BigDecimal>("amountPRE", BigDecimal.class, false);
	
	public static final Property<String> BANKNAME = new Property<String>("bankName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
