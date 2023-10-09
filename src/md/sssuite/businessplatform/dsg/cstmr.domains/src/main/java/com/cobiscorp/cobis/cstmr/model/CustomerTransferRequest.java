package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class CustomerTransferRequest {

	public static final String EN_CUSTOMENE_869 = "EN_CUSTOMENE_869";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerTransferRequest";
	
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Boolean> ISCHECKED = new Property<Boolean>("isChecked", Boolean.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<BigDecimal> CREDITAMOUNT = new Property<BigDecimal>("creditAmount", BigDecimal.class, false);
	
	public static final Property<Character> ISGROUP = new Property<Character>("isGroup", Character.class, false);
	
	public static final Property<Integer> CICLES = new Property<Integer>("cicles", Integer.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeId", Integer.class, false);
	
	public static final Property<String> OFFICIALID = new Property<String>("officialId", String.class, false);
	
	public static final Property<String> WEEKSDELAY = new Property<String>("weeksDelay", String.class, false);
	
	public static final Property<String> REGISTRATIONDATE = new Property<String>("registrationDate", String.class, false);
	
	public static final Property<String> LASTUPDATEDATE = new Property<String>("lastUpdateDate", String.class, false);
	
	public static final Property<String> CUSTOMERSTATUS = new Property<String>("customerStatus", String.class, false);
	
	public static final Property<String> MARKETTYPE = new Property<String>("marketType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
