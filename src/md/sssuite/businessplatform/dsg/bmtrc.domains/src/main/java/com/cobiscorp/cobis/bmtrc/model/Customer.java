package com.cobiscorp.cobis.bmtrc.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Customer {

	public static final String EN_CUSTOMERR_928 = "EN_CUSTOMERR_928";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Customer";
	
	
	public static final Property<String> YEAR = new Property<String>("year", String.class, false);
	
	public static final Property<Integer> LEFTFINGER = new Property<Integer>("leftFinger", Integer.class, false);
	
	public static final Property<String> MOTHERSURNAME = new Property<String>("motherSurname", String.class, false);
	
	public static final Property<String> REGISTRYSITUATION = new Property<String>("registrySituation", String.class, false);
	
	public static final Property<String> ROLE = new Property<String>("role", String.class, false);
	
	public static final Property<String> BIRTHDAY = new Property<String>("birthDay", String.class, false);
	
	public static final Property<String> CREDENTIALNUMBER = new Property<String>("credentialNumber", String.class, false);
	
	public static final Property<String> WITHOUTFINGERPRINTVALUE = new Property<String>("withoutFingerprintValue", String.class, false);
	
	public static final Property<String> BIRTHCITY = new Property<String>("birthCity", String.class, false);
	
	public static final Property<Boolean> WITHOUTFINGERPRINT = new Property<Boolean>("withoutFingerprint", Boolean.class, false);
	
	public static final Property<Integer> HASH = new Property<Integer>("hash", Integer.class, false);
	
	public static final Property<String> CURP = new Property<String>("curp", String.class, false);
	
	public static final Property<String> CHANNEL = new Property<String>("channel", String.class, false);
	
	public static final Property<String> CIC = new Property<String>("cic", String.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("customer", String.class, false);
	
	public static final Property<Integer> IDCUSTOMER = new Property<Integer>("idCustomer", Integer.class, false);
	
	public static final Property<Integer> RIGHTFINGER = new Property<Integer>("rightFinger", Integer.class, false);
	
	public static final Property<String> BUC = new Property<String>("buc", String.class, false);
	
	public static final Property<String> SURNAME = new Property<String>("surname", String.class, false);
	
	public static final Property<String> TYPETHEFTREPORT = new Property<String>("typeTheftReport", String.class, false);
	
	public static final Property<String> VALIDATIONSTATUS = new Property<String>("validationStatus", String.class, false);
	
	public static final Property<String> OCR = new Property<String>("ocr", String.class, false);
	
	public static final Property<String> VOTERKEY = new Property<String>("voterKey", String.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> YEAREMISSION = new Property<String>("yearEmission", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
