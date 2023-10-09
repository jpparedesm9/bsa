package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PrintingDocuments {

	public static final String EN_PRINTINDC_109 = "EN_PRINTINDC_109";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PrintingDocuments";
	
	
	public static final Property<Integer> CODIGO = new Property<Integer>("codigo", Integer.class, false);
	
	public static final Property<String> DOCUMENTOS = new Property<String>("documentos", String.class, false);
	
	public static final Property<Boolean> ITEM = new Property<Boolean>("item", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
