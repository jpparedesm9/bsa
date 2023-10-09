package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class GroupPayment {

	public static final String EN_GROUPPATE_487 = "EN_GROUPPATE_487";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GroupPayment";
	
	
	public static final Property<String> GROUPID = new Property<String>("groupId", String.class, false);
	
	public static final Property<Integer> EXPIREDQUOTAS = new Property<Integer>("expiredQuotas", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<BigDecimal> COLLATERALBALANCE = new Property<BigDecimal>("collateralBalance", BigDecimal.class, false);
	
	public static final Property<String> ROL = new Property<String>("rol", String.class, false);
	
	public static final Property<BigDecimal> EXPIREDAMOUNT = new Property<BigDecimal>("expiredAmount", BigDecimal.class, false);
	
	public static final Property<Integer> OPERATION = new Property<Integer>("operation", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
