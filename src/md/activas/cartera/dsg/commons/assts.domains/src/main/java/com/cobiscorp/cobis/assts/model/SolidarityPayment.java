package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SolidarityPayment {

	public static final String EN_SOLIDARNA_994 = "EN_SOLIDARNA_994";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SolidarityPayment";
	
	
	public static final Property<Integer> MAXFEE = new Property<Integer>("maxFee", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNTSOLIDARITYPAYMENT = new Property<BigDecimal>("amountSolidarityPayment", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCEGUARANTEE = new Property<BigDecimal>("balanceGuarantee", BigDecimal.class, false);
	
	public static final Property<Integer> MODIFICATIONFEEAUX = new Property<Integer>("modificationFeeAux", Integer.class, false);
	
	public static final Property<String> TYPECREDIT = new Property<String>("typeCredit", String.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<Integer> OWEDQUOTAS = new Property<Integer>("owedQuotas", Integer.class, false);
	
	public static final Property<Boolean> PAYDEBITACCOUNTS = new Property<Boolean>("payDebitAccounts", Boolean.class, false);
	
	public static final Property<String> ADVISOR = new Property<String>("advisor", String.class, false);
	
	public static final Property<Date> APPLICATIONDATE = new Property<Date>("applicationDate", Date.class, false);
	
	public static final Property<BigDecimal> RATE = new Property<BigDecimal>("rate", BigDecimal.class, false);
	
	public static final Property<String> GROUPOPERATIONCODE = new Property<String>("groupOperationCode", String.class, false);
	
	public static final Property<String> BRANCHOFFICE = new Property<String>("branchOffice", String.class, false);
	
	public static final Property<Integer> GROUPCYCLE = new Property<Integer>("groupCycle", Integer.class, false);
	
	public static final Property<BigDecimal> GROUPAMOUNT = new Property<BigDecimal>("groupAmount", BigDecimal.class, false);
	
	public static final Property<String> TERM = new Property<String>("term", String.class, false);
	
	public static final Property<Integer> MODIFICATIONFEE = new Property<Integer>("modificationFee", Integer.class, false);
	
	public static final Property<Integer> GROUPCODE = new Property<Integer>("groupCode", Integer.class, false);
	
	public static final Property<String> NAMEGROUP = new Property<String>("nameGroup", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
