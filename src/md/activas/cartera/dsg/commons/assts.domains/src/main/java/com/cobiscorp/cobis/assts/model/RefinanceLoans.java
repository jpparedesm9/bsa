package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class RefinanceLoans {

	public static final String EN_REFINANLC_582 = "EN_REFINANLC_582";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinanceLoans";
	
	
	public static final Property<String> LOAN = new Property<String>("loan", String.class, false);
	
	public static final Property<String> LINE = new Property<String>("line", String.class, false);
	
	public static final Property<BigDecimal> INITIALAMOUNT = new Property<BigDecimal>("initialAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALTOREFINANCE = new Property<BigDecimal>("totalToRefinance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALBALANCE = new Property<BigDecimal>("totalBalance", BigDecimal.class, false);
	
	public static final Property<Integer> CURRENCYCODE = new Property<Integer>("currencyCode", Integer.class, false);
	
	public static final Property<BigDecimal> QUOTATION = new Property<BigDecimal>("quotation", BigDecimal.class, false);
	
	public static final Property<Integer> TRANSACTIONID = new Property<Integer>("transactionID", Integer.class, false);
	
	public static final Property<String> OFFICIALID = new Property<String>("officialID", String.class, false);
	
	public static final Property<Integer> ORIGINALTERM = new Property<Integer>("originalTerm", Integer.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCE = new Property<BigDecimal>("capitalBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTERESTBALANCE = new Property<BigDecimal>("interestBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> DEFAULTBALANCE = new Property<BigDecimal>("defaultBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERCONCEPTSBALANCE = new Property<BigDecimal>("otherConceptsBalance", BigDecimal.class, false);
	
	public static final Property<Integer> RESIDUALTERM = new Property<Integer>("residualTerm", Integer.class, false);
	
	public static final Property<String> LOANSTATUS = new Property<String>("loanStatus", String.class, false);
	
	public static final Property<String> CURRENCYTYPE = new Property<String>("currencyType", String.class, false);
	
	public static final Property<Integer> OVERDUEFEES = new Property<Integer>("overdueFees", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
