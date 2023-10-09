package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DocumentoImpresion {

	public static final String EN_DCOIPRSIN424 = "EN_DCOIPRSIN424";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DocumentoImpresion";
	
	
	public static final Property<String> LUGAR = new Property<String>("lugar", String.class, false);
	
	public static final Property<String> REPRESENTANTE = new Property<String>("representante", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
