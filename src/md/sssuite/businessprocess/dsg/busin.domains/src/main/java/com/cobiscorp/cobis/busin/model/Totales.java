package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Totales {

	public static final String EN_TOTALESQV_770 = "EN_TOTALESQV_770";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Totales";
	
	
	public static final Property<Double> TOTALFINAL = new Property<Double>("totalFinal", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
