package com.cobiscorp.cobis.mbile.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class TerminalFiltro {

	public static final String EN_TERMINAIL_466 = "EN_TERMINAIL_466";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TerminalFiltro";
	
	
	public static final Property<String> FILTERVALUE = new Property<String>("filterValue", String.class, false);
	
	public static final Property<String> FILTERNAME = new Property<String>("filterName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		return new ArrayList<Property<?>>();		
	}

}
