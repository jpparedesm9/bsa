package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConciliationSearch {

	public static final String EN_CONCILICC_147 = "EN_CONCILICC_147";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConciliationSearch";
	
	
	public static final Property<String> CUSTOMERCODE = new Property<String>("customerCode", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<Double> AMOUNT = new Property<Double>("amount", Double.class, false);
	
	public static final Property<Date> DATEUNTIL = new Property<Date>("dateUntil", Date.class, false);
	
	public static final Property<Character> PAYMENTSTATE = new Property<Character>("paymentState", Character.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<String> CONCILIATE = new Property<String>("conciliate", String.class, false);
	
	public static final Property<Date> PAYMENTRECEIPTDATE = new Property<Date>("paymentReceiptDate", Date.class, false);
	
	public static final Property<String> NOTCONCILIATIONREASON = new Property<String>("notConciliationReason", String.class, false);
	
	public static final Property<Date> CONCILIATIONDATE = new Property<Date>("conciliationDate", Date.class, false);
	
	public static final Property<Double> PAYMENTRECEIPTAMOUNT = new Property<Double>("paymentReceiptAmount", Double.class, false);
	
	public static final Property<Character> CONCILIATIONSTATUS = new Property<Character>("conciliationStatus", Character.class, false);
	
	public static final Property<Date> DATEFROM = new Property<Date>("dateFrom", Date.class, false);
	
	public static final Property<Date> UPLOADCONCILIATIONFILEDATE = new Property<Date>("uploadConciliationFileDate", Date.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<String> CONCILIATIONUSER = new Property<String>("conciliationUser", String.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<Double> AMOUNTREPORTEDINFILE = new Property<Double>("amountReportedInFile", Double.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
