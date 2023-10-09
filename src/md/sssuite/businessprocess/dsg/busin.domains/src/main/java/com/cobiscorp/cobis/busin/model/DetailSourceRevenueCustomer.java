package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DetailSourceRevenueCustomer {

	public static final String EN_DLURCEUOR970 = "EN_DLURCEUOR970";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailSourceRevenueCustomer";
	
	
	public static final Property<String> ACLARACIONFIE = new Property<String>("aclaracionFie", String.class, false);
	
	public static final Property<String> SUBACTIVIDADECONOMICA = new Property<String>("subActividadEconomica", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
