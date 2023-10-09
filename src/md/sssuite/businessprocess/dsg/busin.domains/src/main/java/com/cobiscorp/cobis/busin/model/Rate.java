package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Rate {

	public static final String EN_TASASTZLU900 = "EN_TASASTZLU900";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Rate";
	
	
	public static final Property<String> ACCORDINGTARIFFRATE = new Property<String>("AccordingTariffRate", String.class, false);
	
	public static final Property<String> PROPOSEDRATE = new Property<String>("ProposedRate", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
