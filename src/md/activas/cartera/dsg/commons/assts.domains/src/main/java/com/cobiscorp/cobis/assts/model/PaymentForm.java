package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentForm {

	public static final String EN_PAYMENTZD_123 = "EN_PAYMENTZD_123";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentForm";
	
	
	public static final Property<Integer> CURRENCYID = new Property<Integer>("currencyId", Integer.class, false);
	
	public static final Property<String> CURRENCYNAME = new Property<String>("currencyName", String.class, false);
	
	public static final Property<String> PAYFORMID = new Property<String>("payFormId", String.class, false);
	
	public static final Property<String> PAYFORMNAME = new Property<String>("payFormName", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientId", Integer.class, false);
	
	public static final Property<String> CLIENTFULLNAME = new Property<String>("clientFullName", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> CHECKNUMBER = new Property<String>("checkNumber", String.class, false);
	
	public static final Property<BigDecimal> PAYAMOUNT = new Property<BigDecimal>("payAmount", BigDecimal.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeId", Integer.class, false);
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> PAYQUOTELBL = new Property<String>("payQuoteLbl", String.class, false);
	
	public static final Property<String> ACCOUNTNUMBER = new Property<String>("accountNumber", String.class, false);
	
	public static final Property<Boolean> RESTRICTIVECROSSING = new Property<Boolean>("restrictiveCrossing", Boolean.class, false);
	
	public static final Property<String> ECONOMICDESTINATION = new Property<String>("economicDestination", String.class, false);
	
	public static final Property<Integer> CURRENCYIDAUX = new Property<Integer>("currencyIdAux", Integer.class, false);
	
	public static final Property<String> CURRENCYFLAGAUX = new Property<String>("currencyFlagAux", String.class, false);
	
	public static final Property<String> PAYFORMCATEGORY = new Property<String>("payFormCategory", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
