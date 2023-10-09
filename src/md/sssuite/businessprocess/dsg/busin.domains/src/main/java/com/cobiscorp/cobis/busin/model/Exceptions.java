package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Exceptions {

	public static final String EN_EXCEPTINS513 = "EN_EXCEPTINS513";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Exceptions";
	
	
	public static final Property<String> MNEMONIC = new Property<String>("mnemonic", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Boolean> APROVED = new Property<Boolean>("Aproved", Boolean.class, false);
	
	public static final Property<String> AUTHORIZED = new Property<String>("Authorized", String.class, false);
	
	public static final Property<String> DETAIL = new Property<String>("detail", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("Observations", String.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("Official", String.class, false);
	
	public static final Property<String> ACTIVITY = new Property<String>("Activity", String.class, false);
	
	public static final Property<Date> ENDDATE = new Property<Date>("EndDate", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
