package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class WarrantyHeaderRequest {

	public static final String EN_WANTYRUES577 = "EN_WANTYRUES577";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantyHeaderRequest";
	
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> REQUESTTYPE = new Property<String>("RequestType", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("Amount", BigDecimal.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("Currency", Integer.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("Balance", BigDecimal.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final Property<String> REASON = new Property<String>("Reason", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
