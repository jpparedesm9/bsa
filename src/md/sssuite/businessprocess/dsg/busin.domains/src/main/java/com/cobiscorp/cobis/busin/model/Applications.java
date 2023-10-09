package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Applications {

	public static final String EN_APPLICATO753 = "EN_APPLICATO753";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Applications";
	
	
	public static final Property<String> APPLICATIONCODE = new Property<String>("ApplicationCode", String.class, false);
	
	public static final Property<String> CREDITCODE = new Property<String>("CreditCode", String.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("Official", String.class, false);
	
	public static final Property<String> FLOWTYPE = new Property<String>("FlowType", String.class, false);
	
	public static final Property<String> PRINCIPALDEBTOR = new Property<String>("PrincipalDebtor", String.class, false);
	
	public static final Property<BigDecimal> PROPOSEDAMOUNT = new Property<BigDecimal>("ProposedAmount", BigDecimal.class, false);
	
	public static final Property<String> CURRENCYPROPOSAL = new Property<String>("CurrencyProposal", String.class, false);
	
	public static final Property<Boolean> SELECTION = new Property<Boolean>("Selection", Boolean.class, false);
	
	public static final Property<String> OFFICIALNAME = new Property<String>("OfficialName", String.class, false);
	
	public static final Property<String> DEBTORNAME = new Property<String>("DebtorName", String.class, false);
	
	public static final Property<String> CITY = new Property<String>("City", String.class, false);
	
	public static final Property<String> ALTERNATECODE = new Property<String>("alternateCode", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
