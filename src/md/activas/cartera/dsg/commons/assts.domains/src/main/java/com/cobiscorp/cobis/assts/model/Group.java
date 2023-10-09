package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Group {

	public static final String EN_GROUPJUAD_782 = "EN_GROUPJUAD_782";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Group";
	
	
	public static final Property<String> GROUPSTATUS = new Property<String>("groupStatus", String.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<BigDecimal> COLLATERALBALANCE = new Property<BigDecimal>("collateralBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LOANBALANCE = new Property<BigDecimal>("loanBalance", BigDecimal.class, false);
	
	public static final Property<String> LOANBALCURRENCYNEM = new Property<String>("loanBalCurrencyNem", String.class, false);
	
	public static final Property<Character> COLLATERALPAYMENTSTATUS = new Property<Character>("collateralPaymentStatus", Character.class, false);
	
	public static final Property<String> COLBALCURRENCYNEM = new Property<String>("colBalCurrencyNem", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
