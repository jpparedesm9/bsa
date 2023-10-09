package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class AccountInfomation {

	public static final String EN_ACCOUNTOA_293 = "EN_ACCOUNTOA_293";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "AccountInfomation";
	
	
	public static final Property<String> ACCOUNTSTATUS = new Property<String>("accountStatus", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<BigDecimal> AVAILABLEBALANCE = new Property<BigDecimal>("availableBalance", BigDecimal.class, false);
	
	public static final Property<String> ACCOUNTBANK = new Property<String>("accountBank", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
