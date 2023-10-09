package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LoanAdditionalInformation {

	public static final String EN_LOANADDOI_167 = "EN_LOANADDOI_167";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanAdditionalInformation";
	
	
	public static final Property<Date> DATETODISBURSE = new Property<Date>("dateToDisburse", Date.class, false);
	
	public static final Property<BigDecimal> AMOUNTTOCANCEL = new Property<BigDecimal>("amountToCancel", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTOPERATION = new Property<BigDecimal>("amountOperation", BigDecimal.class, false);
	
	public static final Property<BigDecimal> QUOTATION = new Property<BigDecimal>("quotation", BigDecimal.class, false);
	
	public static final Property<String> LBLAMOUNTTOCANCEL = new Property<String>("lblAmountToCancel", String.class, false);
	
	public static final Property<Character> RENOVATION = new Property<Character>("renovation", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
