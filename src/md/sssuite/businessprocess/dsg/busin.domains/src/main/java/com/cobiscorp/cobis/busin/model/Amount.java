package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Amount {

	public static final String EN_AMOUNTJEN270 = "EN_AMOUNTJEN270";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Amount";
	
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final Property<BigDecimal> AGREEDAMOUNT = new Property<BigDecimal>("AgreedAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTPAID = new Property<BigDecimal>("AmountPaid", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCECUTOFFDATE = new Property<BigDecimal>("BalanceCutoffDate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCEDATE = new Property<BigDecimal>("BalanceDate", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
