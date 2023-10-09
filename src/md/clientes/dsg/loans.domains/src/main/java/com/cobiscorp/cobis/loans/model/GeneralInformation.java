package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class GeneralInformation {

	public static final String EN_GENERALIN_872 = "EN_GENERALIN_872";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralInformation";
	
	
	public static final Property<String> DATEPAYMENT = new Property<String>("datePayment", String.class, false);
	
	public static final Property<Integer> CURRENTCYCLE = new Property<Integer>("currentCycle", Integer.class, false);
	
	public static final Property<String> BRANCHOFFICE = new Property<String>("branchOffice", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<String> CURRENTDATE = new Property<String>("currentDate", String.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTAPPROVED = new Property<BigDecimal>("amountApproved", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
