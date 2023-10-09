package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class TableType {

	public static final String EN_TABLETYPE721 = "EN_TABLETYPE721";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TableType";
	
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> FIXEDPAYMENTDATE = new Property<String>("FixedPaymentDate", String.class, false);
	
	public static final Property<Integer> PAYMENTDAY = new Property<Integer>("PaymentDay", Integer.class, false);
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("Capital", BigDecimal.class, false);
	
	public static final Property<Integer> PAYMENTMONTHLY = new Property<Integer>("PaymentMonthly", Integer.class, false);
	
	public static final Property<Character> FEEFINAL = new Property<Character>("FeeFinal", Character.class, false);
	
	public static final Property<Character> AVOIDHOLIDAYS = new Property<Character>("Avoidholidays", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
