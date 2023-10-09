package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DebitOrderProcessingLog {

	public static final String EN_DEBITORGE_499 = "EN_DEBITORGE_499";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DebitOrderProcessingLog";
	
	
	public static final Property<String> NAMECLIENT = new Property<String>("nameClient", String.class, false);
	
	public static final Property<String> LOANNUMBER = new Property<String>("loanNumber", String.class, false);
	
	public static final Property<Date> UNTILDATE = new Property<Date>("untilDate", Date.class, false);
	
	public static final Property<BigDecimal> PAYMENTAMOUNT = new Property<BigDecimal>("paymentAmount", BigDecimal.class, false);
	
	public static final Property<Date> ORDERGENERATIONDATE = new Property<Date>("orderGenerationDate", Date.class, false);
	
	public static final Property<String> ERRORDESCRIPTION = new Property<String>("errorDescription", String.class, false);
	
	public static final Property<String> CLIENTID = new Property<String>("clientId", String.class, false);
	
	public static final Property<Date> FROMDATE = new Property<Date>("fromDate", Date.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<String> ACCOUNTNUMBERSANTANDER = new Property<String>("accountNumberSantander", String.class, false);
	
	public static final Property<String> ERRORTYPE = new Property<String>("errorType", String.class, false);
	
	public static final Property<String> FILENAME = new Property<String>("filename", String.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
