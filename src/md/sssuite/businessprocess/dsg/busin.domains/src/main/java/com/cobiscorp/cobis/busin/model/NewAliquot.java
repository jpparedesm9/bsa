package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class NewAliquot {

	public static final String EN_NEWALIQTO_726 = "EN_NEWALIQTO_726";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "NewAliquot";
	
	
	public static final Property<String> REFERENCIA = new Property<String>("referencia", String.class, false);
	
	public static final Property<String> EJECUTIVO = new Property<String>("ejecutivo", String.class, false);
	
	public static final Property<String> IDEJECUTIVO = new Property<String>("idEjecutivo", String.class, false);

	public static final Property<String> GRUPAL = new Property<String>("grupal", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
