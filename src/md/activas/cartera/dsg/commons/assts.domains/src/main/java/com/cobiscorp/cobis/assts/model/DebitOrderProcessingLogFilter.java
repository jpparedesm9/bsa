package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DebitOrderProcessingLogFilter {

	public static final String EN_DEBITORDG_194 = "EN_DEBITORDG_194";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DebitOrderProcessingLogFilter";
	
	
	public static final Property<Date> FROMDATE = new Property<Date>("fromDate", Date.class, false);
	
	public static final Property<Date> PROCESSDATE = new Property<Date>("processDate", Date.class, false);
	
	public static final Property<String> CLIENTID = new Property<String>("clientId", String.class, false);
	
	public static final Property<String> ACCOUNTNUMBERSANTANDER = new Property<String>("accountNumberSantander", String.class, false);
	
	public static final Property<String> FILENAME = new Property<String>("filename", String.class, false);
	
	public static final Property<Date> UNTILDATE = new Property<Date>("untilDate", Date.class, false);
	
	public static final Property<String> LOANNUMBER = new Property<String>("loanNumber", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> TYPEERROR = new Property<String>("typeError", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
