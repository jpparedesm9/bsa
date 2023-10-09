package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LoanWarranty {

	public static final String EN_LOANWARRY_642 = "EN_LOANWARRY_642";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanWarranty";
	
	
	public static final Property<String> WARRANTY = new Property<String>("warranty", String.class, false);
	
	public static final Property<String> STATUSWARRANTY = new Property<String>("statusWarranty", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerID", Integer.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("customer", String.class, false);
	
	public static final Property<BigDecimal> CURRENTVALUE = new Property<BigDecimal>("currentValue", BigDecimal.class, false);
	
	public static final Property<Integer> CURRENCYID = new Property<Integer>("currencyID", Integer.class, false);
	
	public static final Property<String> CREATEDON = new Property<String>("createdOn", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
