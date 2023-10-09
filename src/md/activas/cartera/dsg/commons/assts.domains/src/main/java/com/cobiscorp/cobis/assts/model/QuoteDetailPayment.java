package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class QuoteDetailPayment {

	public static final String EN_QUOTEDETP_862 = "EN_QUOTEDETP_862";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuoteDetailPayment";
	
	
	public static final Property<Integer> NUMQUOTE = new Property<Integer>("numQuote", Integer.class, false);
	
	public static final Property<Date> EXPIRED = new Property<Date>("expired", Date.class, false);
	
	public static final Property<BigDecimal> PAYMENT = new Property<BigDecimal>("payment", BigDecimal.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
