package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class RefinanceLoanFilter {

	public static final String EN_REFINANCA_619 = "EN_REFINANCA_619";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinanceLoanFilter";
	
	
	public static final Property<String> ADDICIONALPAYMETHOD = new Property<String>("addicionalPayMethod", String.class, false);
	
	public static final Property<Integer> CURRENCYTYPEAUX = new Property<Integer>("currencyTypeAux", Integer.class, false);
	
	public static final Property<BigDecimal> INTERESTBALANCE = new Property<BigDecimal>("interestBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ARREARSBALANCE = new Property<BigDecimal>("arrearsBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ADDITIONALVALUE = new Property<BigDecimal>("additionalValue", BigDecimal.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<Boolean> REFRESHDATA = new Property<Boolean>("refreshData", Boolean.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<Integer> CURRENCYTYPE = new Property<Integer>("currencyType", Integer.class, false);
	
	public static final Property<String> PERIODICITY = new Property<String>("periodicity", String.class, false);
	
	public static final Property<BigDecimal> TOTALREFINANCE = new Property<BigDecimal>("totalRefinance", BigDecimal.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<String> NEWLOANCURRENCY = new Property<String>("newLoanCurrency", String.class, false);
	
	public static final Property<String> PAYMETHODCURRENCY = new Property<String>("payMethodCurrency", String.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCE = new Property<BigDecimal>("capitalBalance", BigDecimal.class, false);
	
	public static final Property<String> NEWLOANLABEL = new Property<String>("newLoanLabel", String.class, false);
	
	public static final Property<BigDecimal> OTHERBALANCE = new Property<BigDecimal>("otherBalance", BigDecimal.class, false);
	
	public static final Property<String> OVERDUE = new Property<String>("overDue", String.class, false);
	
	public static final Property<String> OPERATIONTYPE = new Property<String>("operationType", String.class, false);
	
	public static final Property<BigDecimal> ADITIONALBALANCE = new Property<BigDecimal>("aditionalBalance", BigDecimal.class, false);
	
	public static final Property<Integer> NEWLOANTERM = new Property<Integer>("newLoanTerm", Integer.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientID", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
