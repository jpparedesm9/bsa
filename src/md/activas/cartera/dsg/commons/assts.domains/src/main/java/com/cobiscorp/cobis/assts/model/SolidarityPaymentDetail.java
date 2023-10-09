package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SolidarityPaymentDetail {

	public static final String EN_SOLIDARII_497 = "EN_SOLIDARII_497";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SolidarityPaymentDetail";
	
	
	public static final Property<BigDecimal> PAIDOUT = new Property<BigDecimal>("paidOut", BigDecimal.class, false);
	
	public static final Property<Integer> GROUPCODE = new Property<Integer>("groupCode", Integer.class, false);
	
	public static final Property<Integer> OPERATIONSON = new Property<Integer>("operationSon", Integer.class, false);
	
	public static final Property<Integer> DIVIDEND = new Property<Integer>("dividend", Integer.class, false);
	
	public static final Property<String> GROUPOPERATIONCODE = new Property<String>("groupOperationCode", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<BigDecimal> PAYMENTAMOUNT = new Property<BigDecimal>("paymentAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> FEE = new Property<BigDecimal>("fee", BigDecimal.class, false);
	
	public static final Property<BigDecimal> EXPIRED = new Property<BigDecimal>("expired", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
