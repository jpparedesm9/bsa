package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CuentaGrupal {

	public static final String EN_CUENTAGUP_436 = "EN_CUENTAGUP_436";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CuentaGrupal";
	
	
	public static final Property<String> CUENTAGRUPAL = new Property<String>("cuentaGrupal", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
