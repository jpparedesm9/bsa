package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class GroupPaymenInfo {

	public static final String EN_GROUPPAEE_126 = "EN_GROUPPAEE_126";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GroupPaymenInfo";
	
	
	public static final Property<BigDecimal> VALUEAMOUNTUSEGUARANTEE = new Property<BigDecimal>("valueAmountUseGuarantee", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALAMOUNT = new Property<BigDecimal>("totalAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> COLLATERALBALANCE = new Property<BigDecimal>("collateralBalance", BigDecimal.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
