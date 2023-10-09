package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MethodsRetention {

	public static final String EN_METHODSRT_271 = "EN_METHODSRT_271";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MethodsRetention";
	
	
	public static final Property<String> PRODUCT = new Property<String>("product", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);
	
	public static final Property<String> DISBURSEMENT = new Property<String>("disbursement", String.class, false);
	
	public static final Property<String> PAYMENT = new Property<String>("payment", String.class, false);
	
	public static final Property<Integer> RETENTIONDAYS = new Property<Integer>("retentiondays", Integer.class, false);
	
	public static final Property<Integer> VALUECODE = new Property<Integer>("valueCode", Integer.class, false);
	
	public static final Property<String> PAYMENTAUT = new Property<String>("paymentAut", String.class, false);
	
	public static final Property<Integer> CURRENCYRETENTION = new Property<Integer>("currencyRetention", Integer.class, false);
	
	public static final Property<String> PAYMENTATX = new Property<String>("paymentATX", String.class, false);
	
	public static final Property<String> DESCCURRENCY = new Property<String>("descCurrency", String.class, false);
	
	public static final Property<String> PCOBIS = new Property<String>("pcobis", String.class, false);
	
	public static final Property<String> DESCCOBIS = new Property<String>("descCOBIS", String.class, false);
	
	public static final Property<String> REVERSEPRO = new Property<String>("reversePro", String.class, false);
	
	public static final Property<String> AFFECTATION = new Property<String>("affectation", String.class, false);
	
	public static final Property<String> ACTIVEPASSIVE = new Property<String>("activePassive", String.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<Integer> BANKINSTRUMENT = new Property<Integer>("bankInstrument", Integer.class, false);
	
	public static final Property<String> DESCRIPBANK = new Property<String>("descripBank", String.class, false);
	
	public static final Property<String> CANAL = new Property<String>("canal", String.class, false);
	
	public static final Property<String> DESCRIPTIONCANAL = new Property<String>("descriptionCanal", String.class, false);
	
	public static final Property<String> BANKSERVICES = new Property<String>("bankServices", String.class, false);
	
	public static final Property<String> PAYMENTMETHODS = new Property<String>("paymentMethods", String.class, false);
	
	public static final Property<String> TRANSACCTION = new Property<String>("transacction", String.class, false);
	
	public static final Property<String> CODECATEGORY = new Property<String>("codeCategory", String.class, false);
	
	public static final Property<String> DESCRIPTIONCATEGORY = new Property<String>("descriptionCategory", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
