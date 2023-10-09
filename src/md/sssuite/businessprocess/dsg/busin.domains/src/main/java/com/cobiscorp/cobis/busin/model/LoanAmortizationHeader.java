package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanAmortizationHeader {

	public static final String EN_LOIATINER781 = "EN_LOIATINER781";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanAmortizationHeader";
	
	
	public static final Property<String> ROTCONCEPT = new Property<String>("RotConcept", String.class, false);
	
	public static final Property<String> ROTDESCRIPTION = new Property<String>("RotDescription", String.class, false);
	
	public static final Property<String> ROTPERCENTAGE = new Property<String>("RotPercentage", String.class, false);
	
	public static final Property<String> ROTITEMTYPE = new Property<String>("RotItemType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
