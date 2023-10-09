package com.cobiscorp.cobis.wrrnt.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class GenericTransaction {

	public static final String EN_1IFLNNCYO_648 = "EN_1IFLNNCYO_648";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GenericTransaction";
	
	
	public static final Property<String> CAUSE = new Property<String>("cause", String.class, false);
	
	public static final Property<String> ATTRIBUTE8486 = new Property<String>("attribute8486", String.class, false);
	
	public static final Property<BigDecimal> NEWVALUE = new Property<BigDecimal>("newValue", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
