package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DetailRejectedDispersions {

	public static final String EN_DETAILRDN_659 = "EN_DETAILRDN_659";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DetailRejectedDispersions";
	
	
	public static final Property<String> ACCOUNT = new Property<String>("account", String.class, false);
	
	public static final Property<Integer> CONSECUTIVE = new Property<Integer>("consecutive", Integer.class, false);
	
	public static final Property<String> DATETIMEACTION = new Property<String>("dateTimeAction", String.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<String> CUSTOMERNAMES = new Property<String>("customerNames", String.class, false);
	
	public static final Property<Boolean> SELECTION = new Property<Boolean>("selection", Boolean.class, false);
	
	public static final Property<String> BUC = new Property<String>("buc", String.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<BigDecimal> VALUEDISPERSION = new Property<BigDecimal>("valueDispersion", BigDecimal.class, false);
	
	public static final Property<String> DISPERSIONTYPE = new Property<String>("dispersionType", String.class, false);
	
	public static final Property<String> CUSTOMERCODE = new Property<String>("customerCode", String.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<String> GROUPCODE = new Property<String>("groupCode", String.class, false);
	
	public static final Property<String> CAUSAL = new Property<String>("causal", String.class, false);
	
	public static final Property<String> ACTION = new Property<String>("action", String.class, false);
	
	public static final Property<Integer> LINE = new Property<Integer>("line", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
