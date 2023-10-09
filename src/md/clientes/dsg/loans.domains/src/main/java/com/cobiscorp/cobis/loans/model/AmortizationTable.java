package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class AmortizationTable {

	public static final String EN_AMORTIZAB_356 = "EN_AMORTIZAB_356";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AmortizationTable";
	
	
	public static final Property<BigDecimal> ITEM4 = new Property<BigDecimal>("item4", BigDecimal.class, false);
	
	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);
	
	public static final Property<BigDecimal> ITEM8 = new Property<BigDecimal>("item8", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM10 = new Property<BigDecimal>("item10", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM3 = new Property<BigDecimal>("item3", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM2 = new Property<BigDecimal>("item2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM12 = new Property<BigDecimal>("item12", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("balance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM11 = new Property<BigDecimal>("item11", BigDecimal.class, false);
	
	public static final Property<Integer> DIVIDEND = new Property<Integer>("dividend", Integer.class, false);
	
	public static final Property<BigDecimal> FEE = new Property<BigDecimal>("fee", BigDecimal.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<BigDecimal> ITEM13 = new Property<BigDecimal>("item13", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM7 = new Property<BigDecimal>("item7", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM1 = new Property<BigDecimal>("item1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM6 = new Property<BigDecimal>("item6", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM9 = new Property<BigDecimal>("item9", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM5 = new Property<BigDecimal>("item5", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
