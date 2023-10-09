package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DataComboBox {

	public static final String EN_DAACOMBOO973 = "EN_DAACOMBOO973";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DataComboBox";
	
	
	public static final Property<Boolean> ACTIVITYDESTINATIONCREDIT = new Property<Boolean>("ActivityDestinationCredit", Boolean.class, false);
	
	public static final Property<Boolean> CREDITPORPUSE = new Property<Boolean>("CreditPorpuse", Boolean.class, false);
	
	public static final Property<Boolean> CREDITDESTINATION = new Property<Boolean>("CreditDestination", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
