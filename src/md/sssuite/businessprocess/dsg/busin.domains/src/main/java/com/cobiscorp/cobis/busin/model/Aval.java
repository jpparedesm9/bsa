package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Aval {

	public static final String EN_AVALGIHQU_667 = "EN_AVALGIHQU_667";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Aval";
	
	
	public static final Property<String> RFC = new Property<String>("rFC", String.class, false);
	
	public static final Property<String> BCBLACKLISTS = new Property<String>("bcBlacklists", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Integer> IDCUSTOMER = new Property<Integer>("idCustomer", Integer.class, false);
	
	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);
	
	public static final Property<String> CREDITBUREAU = new Property<String>("creditBureau", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
