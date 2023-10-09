package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class EconomicInformationLegalPerson {

	public static final String EN_ECONOMINE_838 = "EN_ECONOMINE_838";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EconomicInformationLegalPerson";
	
	
	public static final Property<String> COMPANYID = new Property<String>("companyId", String.class, false);
	
	public static final Property<BigDecimal> TOTALCAPITAL = new Property<BigDecimal>("totalCapital", BigDecimal.class, false);
	
	public static final Property<String> COMMENT = new Property<String>("comment", String.class, false);
	
	public static final Property<BigDecimal> REVENUES = new Property<BigDecimal>("revenues", BigDecimal.class, false);
	
	public static final Property<BigDecimal> EXPENSES = new Property<BigDecimal>("expenses", BigDecimal.class, false);
	
	public static final Property<String> RELATION = new Property<String>("relation", String.class, false);
	
	public static final Property<Boolean> RETENTIONTAX = new Property<Boolean>("retentionTax", Boolean.class, false);
	
	public static final Property<BigDecimal> NETWORTH = new Property<BigDecimal>("netWorth", BigDecimal.class, false);
	
	public static final Property<Integer> NUMBEROFEMPLOYESS = new Property<Integer>("numberOfEmployess", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
