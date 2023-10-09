package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentApplication {

	public static final String EN_PAYMENTPN_239 = "EN_PAYMENTPN_239";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentApplication";
	
	
	public static final Property<Integer> OPERATION = new Property<Integer>("operation", Integer.class, false);
	
	public static final Property<BigDecimal> DEBITAMOUNT = new Property<BigDecimal>("debitAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> DEBITEDAMOUNT = new Property<BigDecimal>("debitedAmount", BigDecimal.class, false);
	
	public static final Property<String> GROUPREFERENCE = new Property<String>("groupReference", String.class, false);
	
	public static final Property<Date> PROCESSDATE = new Property<Date>("processDate", Date.class, false);
	
	public static final Property<String> TRANSACTION = new Property<String>("transaction", String.class, false);
	
	public static final Property<String> IDENTIFICATION = new Property<String>("identification", String.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<Date> SENDDATE = new Property<Date>("sendDate", Date.class, false);
	
	public static final Property<String> PAYMENTTYPE = new Property<String>("paymentType", String.class, false);
	
	public static final Property<String> DEBITACCOUNT = new Property<String>("debitAccount", String.class, false);
	
	public static final Property<Character> STATEMENT = new Property<Character>("statement", Character.class, false);
	
	public static final Property<String> TYPEIDENTIFICATION = new Property<String>("typeIdentification", String.class, false);
	
	public static final Property<String> RECORDACCOUNT = new Property<String>("recordAccount", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
