package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class HeaderCreditLine {

	public static final String EN_HEADERCLE_403 = "EN_HEADERCLE_403";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "HeaderCreditLine";
	
	
	public static final Property<String> PRODUCTO = new Property<String>("producto", String.class, false);
	
	public static final Property<String> TIPOOPERACION = new Property<String>("tipoOperacion", String.class, false);
	
	public static final Property<String> CLIENTE = new Property<String>("cliente", String.class, false);
	
	public static final Property<String> MONEDA = new Property<String>("moneda", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
