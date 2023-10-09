package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DetailPaymentForm {

	public static final String EN_DETAILPNN_835 = "EN_DETAILPNN_835";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailPaymentForm";
	
	
	public static final Property<Integer> DISBURSEMENTID = new Property<Integer>("disbursementId", Integer.class, false);
	
	public static final Property<String> DISBURSEMENTRATE = new Property<String>("disbursementrate", String.class, false);
	
	public static final Property<Integer> CURRENCYID = new Property<Integer>("currencyId", Integer.class, false);
	
	public static final Property<String> CURRENCYDESCRIPTION = new Property<String>("currencyDescription", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> TYPEQUOTATION = new Property<String>("typeQuotation", String.class, false);
	
	public static final Property<Double> QUOTE = new Property<Double>("quote", Double.class, false);
	
	public static final Property<BigDecimal> AMOUNTOP = new Property<BigDecimal>("amountOp", BigDecimal.class, false);
	
	public static final Property<String> QUOTETYPEOP = new Property<String>("quoteTypeOp", String.class, false);
	
	public static final Property<Double> QUOTEOP = new Property<Double>("quoteOp", Double.class, false);
	
	public static final Property<BigDecimal> AMOUNTMN = new Property<BigDecimal>("amountMn", BigDecimal.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<String> BENEFICIARY = new Property<String>("beneficiary", String.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeId", Integer.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<String> PRODUCTCATEGORY = new Property<String>("productCategory", String.class, false);
	
	public static final Property<Integer> PRENOTIFICATION = new Property<Integer>("preNotification", Integer.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("observations", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
