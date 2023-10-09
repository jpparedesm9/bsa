package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class UnusualOperations {

	public static final String EN_UNUSUALNR_757 = "EN_UNUSUALNR_757";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "UnusualOperations";
	
	
	public static final Property<String> COMMENTARY = new Property<String>("commentary", String.class, false);
	
	public static final Property<String> CUSTOMERSECONDSURNAME = new Property<String>("customerSecondSurname", String.class, false);
	
	public static final Property<String> CUSTOMERSURNAME = new Property<String>("customerSurname", String.class, false);
	
	public static final Property<Date> HIGHDATE = new Property<Date>("highDate", Date.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Date> REPORTDATE = new Property<Date>("reportDate", Date.class, false);
	
	public static final Property<String> TYPEOPERATION = new Property<String>("typeOperation", String.class, false);
	
	public static final Property<String> CUSTOMERSECONDNAME = new Property<String>("customerSecondName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
