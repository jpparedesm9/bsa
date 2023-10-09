package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LeftOverPayment {

	public static final String EN_LEFTOVEAR_480 = "EN_LEFTOVEAR_480";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LeftOverPayment";
	
	
	public static final Property<Integer> CURRENCYTYPE = new Property<Integer>("currencyType", Integer.class, false);
	
	public static final Property<String> PAYMENTTYPE = new Property<String>("paymentType", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> NOTE = new Property<String>("note", String.class, false);
	
	public static final Property<String> NUMCHECK = new Property<String>("numCheck", String.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LEFTOVERQUOTATIONVALUE = new Property<BigDecimal>("leftoverQuotationValue", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
