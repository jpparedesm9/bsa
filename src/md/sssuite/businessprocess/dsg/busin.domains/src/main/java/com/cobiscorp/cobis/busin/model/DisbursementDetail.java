package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DisbursementDetail {

	public static final String EN_DBSMTDEAL924 = "EN_DBSMTDEAL924";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DisbursementDetail";
	
	
	public static final Property<String> DISBURSEMENTFORM = new Property<String>("DisbursementForm", String.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<BigDecimal> DISBURSEMENTVALUE = new Property<BigDecimal>("DisbursementValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PRICEQUOTE = new Property<BigDecimal>("PriceQuote", BigDecimal.class, false);
	
	public static final Property<String> DISBURSEMENTFORMID = new Property<String>("DisbursementFormId", String.class, false);
	
	public static final Property<Integer> DISBURSEMENTID = new Property<Integer>("DisbursementId", Integer.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTMOP = new Property<BigDecimal>("AmountMOP", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VALUEML = new Property<BigDecimal>("ValueMl", BigDecimal.class, false);
	
	public static final Property<String> ATX = new Property<String>("Atx", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
