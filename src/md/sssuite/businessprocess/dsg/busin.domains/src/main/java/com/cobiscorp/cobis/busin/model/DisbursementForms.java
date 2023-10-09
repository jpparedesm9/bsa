package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DisbursementForms {

	public static final String EN_DBRSMNFRM527 = "EN_DBRSMNFRM527";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DisbursementForms";
	
	
	public static final Property<String> DISBURSEMENTRATE = new Property<String>("DisbursemenTrate", String.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("Amount", BigDecimal.class, false);
	
	public static final Property<Character> CONTRIBUTIONRATE = new Property<Character>("ContributionRate", Character.class, false);
	
	public static final Property<Double> QUOTE = new Property<Double>("Quote", Double.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("Account", String.class, false);
	
	public static final Property<String> BENEFICIARY = new Property<String>("Beneficiary", String.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("Observations", String.class, false);
	
	public static final Property<Integer> BENEFICIARYID = new Property<Integer>("BeneficiaryId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
