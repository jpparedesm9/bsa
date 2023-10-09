package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ApprovalCriteriaQuestion {

	public static final String EN_APOALRUSO644 = "EN_APOALRUSO644";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ApprovalCriteriaQuestion";
	
	
	public static final Property<Double> INTERNALSCORE = new Property<Double>("internalScore", Double.class, false);
	
	public static final Property<String> OTHERDEBTCICQUESTION = new Property<String>("otherDebtCICQuestion", String.class, false);
	
	public static final Property<String> SHAREDENTITYQUESTION = new Property<String>("sharedEntityQuestion", String.class, false);
	
	public static final Property<String> COMPAREDEXPLUSIVECUSTOMERQUESTION = new Property<String>("comparedExplusiveCustomerQuestion", String.class, false);
	
	public static final Property<String> CURRENTRATEFIE = new Property<String>("currentRateFIE", String.class, false);
	
	public static final Property<String> CUSTOMERCPOPQUESTION = new Property<String>("customerCPOPQuestion", String.class, false);
	
	public static final Property<String> RECORDSMATCHINGQUESTION = new Property<String>("recordsMatchingQuestion", String.class, false);
	
	public static final Property<String> CUSTOMERNOCPOPQUESTION = new Property<String>("customerNoCPOPQuestion", String.class, false);
	
	public static final Property<String> PREVIOUSRATEFIE = new Property<String>("previousRateFIE", String.class, false);
	
	public static final Property<Integer> MAXIMUMDISCOUNTCUSTOMERTYPE = new Property<Integer>("maximumDiscountCustomerType", Integer.class, false);
	
	public static final Property<String> APPLYREBATECROP = new Property<String>("applyRebateCROP", String.class, false);
	
	public static final Property<Double> TARIFFRATE = new Property<Double>("tariffRate", Double.class, false);
	
	public static final Property<Double> REBATECUSTOMERTYPE = new Property<Double>("rebateCustomerType", Double.class, false);
	
	public static final Property<Double> PROPOSEDRATE = new Property<Double>("proposedRate", Double.class, false);
	
	public static final Property<String> RATEAPPLY = new Property<String>("rateApply", String.class, false);
	
	public static final Property<String> REBATEREQUEST = new Property<String>("rebateRequest", String.class, false);
	
	public static final Property<Integer> REBATE = new Property<Integer>("rebate", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
