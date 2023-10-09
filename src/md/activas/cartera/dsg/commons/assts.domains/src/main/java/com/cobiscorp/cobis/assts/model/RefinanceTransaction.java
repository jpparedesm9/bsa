package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RefinanceTransaction {

	public static final String EN_REFINANCC_637 = "EN_REFINANCC_637";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinanceTransaction";
	
	
	public static final Property<Integer> REFINANCETRANSACTIONINT = new Property<Integer>("refinanceTransactionint", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
