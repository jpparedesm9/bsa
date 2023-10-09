package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class WarningRisk {

	public static final String EN_WARNINGRI_699 = "EN_WARNINGRI_699";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarningRisk";
	
	
	public static final Property<String> OBSERVATIONS = new Property<String>("observations", String.class, false);
	
	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<String> ALERTTYPE = new Property<String>("alertType", String.class, false);
	
	public static final Property<Date> CONSULTDATE = new Property<Date>("consultDate", Date.class, false);
	
	public static final Property<Double> AMOUNT = new Property<Double>("amount", Double.class, false);
	
	public static final Property<String> OPERATIONTYPE = new Property<String>("operationType", String.class, false);
	
	public static final Property<String> CONTRACT = new Property<String>("contract", String.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("productType", String.class, false);
	
	public static final Property<String> STAGE = new Property<String>("stage", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> ETIQUET = new Property<String>("etiquet", String.class, false);
	
	public static final Property<String> GROUPNAME = new Property<String>("groupName", String.class, false);
	
	public static final Property<Date> DICTATESDATE = new Property<Date>("dictatesDate", Date.class, false);
	
	public static final Property<String> CUSTOMERRFC = new Property<String>("customerRFC", String.class, false);
	
	public static final Property<String> LISTTYPE = new Property<String>("listType", String.class, false);
	
	public static final Property<Date> ALERTDATE = new Property<Date>("alertDate", Date.class, false);
	
	public static final Property<Integer> ALERTCODE = new Property<Integer>("alertCode", Integer.class, false);
	
	public static final Property<String> GENERATEREPORTS = new Property<String>("generateReports", String.class, false);
	
	public static final Property<Date> OPERATIONDATE = new Property<Date>("operationDate", Date.class, false);
	
	public static final Property<Date> REPORTDATE = new Property<Date>("reportDate", Date.class, false);
	
	public static final Property<String> GROUP = new Property<String>("group", String.class, false);
	
	public static final Property<String> STATUSALERT = new Property<String>("statusAlert", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
