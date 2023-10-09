package com.cobiscorp.cobis.paobj.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DatosBusquedaPagoObjetado {

	public static final String EN_DATOSBUES_272 = "EN_DATOSBUES_272";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DatosBusquedaPagoObjetado";
	
	
	public static final Property<String> ESGRUPO = new Property<String>("esGrupo", String.class, false);
	
	public static final Property<String> CRITERIOBUSQUEDA = new Property<String>("criterioBusqueda", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
