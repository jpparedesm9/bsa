package com.cobiscorp.cobis.paobj.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MetodoPagoReal {

	public static final String EN_2IFPBWMGF_419 = "EN_2IFPBWMGF_419";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MetodoPagoReal";
	
	
	public static final Property<String> PRODUCTO = new Property<String>("producto", String.class, false);
	
	public static final Property<String> DESCRIPCION = new Property<String>("descripcion", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
