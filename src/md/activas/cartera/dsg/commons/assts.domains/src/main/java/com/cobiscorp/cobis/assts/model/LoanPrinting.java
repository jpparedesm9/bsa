package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanPrinting {

	public static final String EN_LOANPRING_206 = "EN_LOANPRING_206";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanPrinting";
	
	
	public static final Property<String> LOANPRINTING = new Property<String>("loanPrinting", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
