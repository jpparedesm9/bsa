package com.cobiscorp.cobis.paobj.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DatosRegularizarPagos {

	public static final String EN_1EKQDWBQZ_965 = "EN_1EKQDWBQZ_965";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DatosRegularizarPagos";
	
	
	public static final Property<String> FORMAPAGO = new Property<String>("formaPago", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
