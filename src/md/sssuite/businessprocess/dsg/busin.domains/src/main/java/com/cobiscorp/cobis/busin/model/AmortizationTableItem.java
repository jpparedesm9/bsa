package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class AmortizationTableItem {

	public static final String EN_MRIZATITM884 = "EN_MRIZATITM884";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AmortizationTableItem";
	
	
	public static final Property<String> OPERATIONNUMBER = new Property<String>("OperationNumber", String.class, false);
	
	public static final Property<Integer> DIVIDEND = new Property<Integer>("Dividend", Integer.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("ExpirationDate", Date.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("Balance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM1 = new Property<BigDecimal>("Item1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM2 = new Property<BigDecimal>("Item2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM3 = new Property<BigDecimal>("Item3", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM4 = new Property<BigDecimal>("Item4", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM5 = new Property<BigDecimal>("Item5", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM6 = new Property<BigDecimal>("Item6", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM7 = new Property<BigDecimal>("Item7", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM8 = new Property<BigDecimal>("Item8", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM9 = new Property<BigDecimal>("Item9", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM10 = new Property<BigDecimal>("Item10", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM11 = new Property<BigDecimal>("Item11", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM12 = new Property<BigDecimal>("Item12", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ITEM13 = new Property<BigDecimal>("Item13", BigDecimal.class, false);
	
	public static final Property<BigDecimal> FEE = new Property<BigDecimal>("Fee", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
