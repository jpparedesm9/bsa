package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class CondonationDetailAux {

	public static final String EN_CONDONATI_592 = "EN_CONDONATI_592";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CondonationDetailAux";
	
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Integer> PERCENTAGE = new Property<Integer>("percentage", Integer.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<BigDecimal> MAXIMUMPERCENTAGE = new Property<BigDecimal>("maximumPercentage", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALVALUE = new Property<BigDecimal>("totalValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VALUETOCONDONE = new Property<BigDecimal>("valueToCondone", BigDecimal.class, false);
	
	public static final Property<String> LOANBANKID = new Property<String>("loanBankID", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
