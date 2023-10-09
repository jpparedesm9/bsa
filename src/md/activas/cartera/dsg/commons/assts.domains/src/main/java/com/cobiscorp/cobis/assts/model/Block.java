package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Block {

	public static final String EN_BLOCKYZZG_360 = "EN_BLOCKYZZG_360";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Block";
	
	
	public static final Property<String> BLOCKED = new Property<String>("blocked", String.class, false);
	
	public static final Property<Date> DISBURSEMENTDATE = new Property<Date>("disbursementDate", Date.class, false);
	
	public static final Property<String> USER = new Property<String>("user", String.class, false);
	
	public static final Property<String> REGISTERCODE = new Property<String>("registerCode", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> ACTIVE = new Property<String>("active", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<BigDecimal> QUOTA = new Property<BigDecimal>("quota", BigDecimal.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<Date> DATELASTUPDATE = new Property<Date>("dateLastUpdate", Date.class, false);
	
	public static final Property<BigDecimal> AVAILABLE = new Property<BigDecimal>("available", BigDecimal.class, false);
	
	public static final Property<String> ENABLEDAUT = new Property<String>("enabledAut", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
