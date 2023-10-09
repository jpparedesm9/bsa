package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SummaryLoanStatus {

	public static final String EN_SUMMARYAT_170 = "EN_SUMMARYAT_170";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SummaryLoanStatus";
	
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTERESTARREAR = new Property<BigDecimal>("interestArrear", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERITEMS = new Property<BigDecimal>("otherItems", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTAL = new Property<BigDecimal>("total", BigDecimal.class, false);
	
	public static final Property<String> STATUSAMORTIZATION = new Property<String>("statusAmortization", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
