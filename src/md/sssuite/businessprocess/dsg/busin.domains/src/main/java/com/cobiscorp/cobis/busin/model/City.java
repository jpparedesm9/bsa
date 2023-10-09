package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class City {

	public static final String EN_1BVRSACFM_931 = "EN_1BVRSACFM_931";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "City";
	
	
	public static final Property<Integer> CODIGOCIUDAD = new Property<Integer>("codigoCiudad", Integer.class, false);
	
	public static final Property<String> CIUDAD = new Property<String>("ciudad", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
