package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConciliationManualSearch {

	public static final String EN_CONCILISL_936 = "EN_CONCILISL_936";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConciliationManualSearch";
	
	
	public static final Property<String> CONCILIATE = new Property<String>("conciliate", String.class, false);
	
	public static final Property<Integer> CODECO = new Property<Integer>("codeCo", Integer.class, false);
	
	public static final Property<Date> VALUEDATE = new Property<Date>("valueDate", Date.class, false);
	
	public static final Property<String> CONCILIATIONUSER = new Property<String>("conciliationUser", String.class, false);
	
	public static final Property<Integer> CORRESPTRANSACTIONCODE = new Property<Integer>("correspTransactionCode", Integer.class, false);
	
	public static final Property<String> ISREVERSE = new Property<String>("isReverse", String.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("observation", String.class, false);
	
	public static final Property<Date> CONCILIATIONDATE = new Property<Date>("conciliationDate", Date.class, false);
	
	public static final Property<String> USERPAYMENT = new Property<String>("userPayment", String.class, false);
	
	public static final Property<String> RECORDSDATE = new Property<String>("recordsDate", String.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<String> PAYMENTREFERENCE = new Property<String>("paymentReference", String.class, false);
	
	public static final Property<String> CORRESPONDENT = new Property<String>("correspondent", String.class, false);
	
	public static final Property<Integer> CUSTOMCODE = new Property<Integer>("customCode", Integer.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<String> PAYMENTSTATE = new Property<String>("paymentState", String.class, false);
	
	public static final Property<Integer> SEQUENTIALCODE = new Property<Integer>("sequentialCode", Integer.class, false);
	
	public static final Property<String> NOTCONCILIATIONREASON = new Property<String>("notConciliationReason", String.class, false);
	
	public static final Property<Boolean> ISSELECTED = new Property<Boolean>("isSelected", Boolean.class, false);
	
	public static final Property<String> OPERATION = new Property<String>("operation", String.class, false);
	
	public static final Property<Integer> CODERELATION = new Property<Integer>("codeRelation", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
