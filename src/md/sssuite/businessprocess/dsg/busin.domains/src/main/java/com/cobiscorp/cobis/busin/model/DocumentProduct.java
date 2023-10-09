package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DocumentProduct {

	public static final String EN_OUMTPROUT175 = "EN_OUMTPROUT175";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DocumentProduct";
	
	
	public static final Property<String> DOCUMENT = new Property<String>("Document", String.class, false);
	
	public static final Property<Boolean> YESNOT = new Property<Boolean>("YesNot", Boolean.class, false);
	
	public static final Property<String> NEMONIC = new Property<String>("Nemonic", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<String> NROIMPRESSIONS = new Property<String>("NroImpressions", String.class, false);
	
	public static final Property<String> TEMPLATE = new Property<String>("Template", String.class, false);
	
	public static final Property<String> REPORTPARAMGUARANTOR = new Property<String>("ReportParamGuarantor", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
