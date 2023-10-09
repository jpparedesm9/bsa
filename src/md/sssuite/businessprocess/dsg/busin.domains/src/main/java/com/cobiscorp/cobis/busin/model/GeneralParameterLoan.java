package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GeneralParameterLoan {

	public static final String EN_NEAPRMEAN473 = "EN_NEAPRMEAN473";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralParameterLoan";
	
	
	public static final Property<String> ALLOWSRENEWAL = new Property<String>("allowsRenewal", String.class, false);
	
	public static final Property<String> ALLOWSPREPAY = new Property<String>("allowsPrepay", String.class, false);
	
	public static final Property<Character> ACCEPTSADDITIONALPAYMENTS = new Property<Character>("acceptsAdditionalPayments", Character.class, false);
	
	public static final Property<String> PAYMENTTYPE = new Property<String>("paymentType", String.class, false);
	
	public static final Property<Character> EXTRAORDINARYEFFECTPAYMENT = new Property<Character>("extraordinaryEffectPayment", Character.class, false);
	
	public static final Property<String> PREPAYMENTTYPE = new Property<String>("prePaymentType", String.class, false);
	
	public static final Property<Character> PAYMENT = new Property<Character>("payment", Character.class, false);
	
	public static final Property<Character> EXCHANGERATE = new Property<Character>("exchangeRate", Character.class, false);
	
	public static final Property<Integer> PERIODICITY = new Property<Integer>("periodicity", Integer.class, false);
	
	public static final Property<Character> INTERESTPAYMENT = new Property<Character>("interestPayment", Character.class, false);
	
	public static final Property<Character> KEEPTERM = new Property<Character>("keepTerm", Character.class, false);
	
	public static final Property<Character> ONLYCOMPLETEFEEPAYMENTS = new Property<Character>("onlyCompleteFeePayments", Character.class, false);
	
	public static final Property<String> APPLYONLYCAPITAL = new Property<String>("applyOnlyCapital", String.class, false);
	
	public static final Property<Character> INTERESTPAYMENTTYPE = new Property<Character>("interestPaymentType", Character.class, false);
	
	public static final Property<String> CREDIT = new Property<String>("credit", String.class, false);
	
	public static final Property<Character> RATECHANGE = new Property<Character>("rateChange", Character.class, false);
	
	public static final Property<String> DEPOSITTYPE = new Property<String>("depositType", String.class, false);
	
	public static final Property<Character> READJUSTMENTPERIODICITY = new Property<Character>("readjustmentPeriodicity", Character.class, false);
	
	public static final Property<Character> ESPECIALREADJUSTMENT = new Property<Character>("especialReadjustment", Character.class, false);
	
	public static final Property<String> HELPTEXT = new Property<String>("helpText", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
