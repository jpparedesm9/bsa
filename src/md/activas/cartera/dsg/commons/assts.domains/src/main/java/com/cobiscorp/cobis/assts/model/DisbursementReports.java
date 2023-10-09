package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DisbursementReports {

	public static final String EN_DISBURSOP_905 = "EN_DISBURSOP_905";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DisbursementReports";
	
	
	public static final Property<String> CODE = new Property<String>("code", String.class, false);
	
	public static final Property<Boolean> CONSOLIDATEDACCOUNT = new Property<Boolean>("consolidatedAccount", Boolean.class, false);
	
	public static final Property<Boolean> GROUPSTATEMENT = new Property<Boolean>("groupStatement", Boolean.class, false);
	
	public static final Property<Boolean> GROUPAMORTIZATIONTABLE = new Property<Boolean>("groupAmortizationTable", Boolean.class, false);
	
	public static final Property<Boolean> DISBURSEMENTORDER = new Property<Boolean>("disbursementOrder", Boolean.class, false);
	
	public static final Property<Boolean> SETTLEMENTSHEET = new Property<Boolean>("settlementSheet", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
