package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RiskEntity {

	public static final String EN_RISKBXOVX_304 = "EN_RISKBXOVX_304";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RiskEntity";
	
	
	public static final Property<String> DESCRIPCION = new Property<String>("descripcion", String.class, false);
	
	public static final Property<Double> PORVENCER = new Property<Double>("porVencer", Double.class, false);
	
	public static final Property<Double> VENCIDO = new Property<Double>("vencido", Double.class, false);
	
	public static final Property<Double> TOTAL = new Property<Double>("total", Double.class, false);
	
	public static final Property<Double> TOTALFINAL = new Property<Double>("totalFinal", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
