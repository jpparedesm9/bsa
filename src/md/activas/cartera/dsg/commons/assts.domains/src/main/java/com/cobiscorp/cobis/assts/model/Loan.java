package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Loan {

	public static final String EN_LOANKYMRI_882 = "EN_LOANKYMRI_882";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Loan";
	
	
	public static final Property<String> NUMPROCEDURE = new Property<String>("numProcedure", String.class, false);
	
	public static final Property<String> QUOTACREDIT = new Property<String>("quotaCredit", String.class, false);
	
	public static final Property<Integer> STATUSID = new Property<Integer>("statusID", Integer.class, false);
	
	public static final Property<String> LASTPROCESSDATE = new Property<String>("lastProcessDate", String.class, false);
	
	public static final Property<BigDecimal> BALANCEDUE = new Property<BigDecimal>("balanceDue", BigDecimal.class, false);
	
	public static final Property<Integer> CATEGORY = new Property<Integer>("category", Integer.class, false);
	
	public static final Property<String> OPERATIONTYPEID = new Property<String>("operationTypeID", String.class, false);
	
	public static final Property<Integer> CODCURRENCY = new Property<Integer>("codCurrency", Integer.class, false);
	
	public static final Property<Integer> NEWSTATUSID = new Property<Integer>("newStatusID", Integer.class, false);
	
	public static final Property<Character> ISDISBURSMENT = new Property<Character>("isDisbursment", Character.class, false);
	
	public static final Property<String> MIGRATEDOPER = new Property<String>("migratedOper", String.class, false);
	
	public static final Property<Integer> LOANID = new Property<Integer>("loanID", Integer.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("officeID", Integer.class, false);
	
	public static final Property<String> CURRENCYNAME = new Property<String>("currencyName", String.class, false);
	
	public static final Property<Date> STARTDATE = new Property<Date>("startDate", Date.class, false);
	
	public static final Property<String> LOANBANKID = new Property<String>("loanBankID", String.class, false);
	
	public static final Property<String> IDTYPE = new Property<String>("idType", String.class, false);
	
	public static final Property<Date> ENDDATE = new Property<Date>("endDate", Date.class, false);
	
	public static final Property<String> IDENTITYCARDNUMBER = new Property<String>("identityCardNumber", String.class, false);
	
	public static final Property<String> DESOPERATIONTYPE = new Property<String>("desOperationType", String.class, false);
	
	public static final Property<String> REDESCONT = new Property<String>("redesCont", String.class, false);
	
	public static final Property<String> NEWSTATUS = new Property<String>("newStatus", String.class, false);
	
	public static final Property<Character> GROUP = new Property<Character>("group", Character.class, false);
	
	public static final Property<String> PREVIOUSOPER = new Property<String>("previousOper", String.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("clientID", Integer.class, false);
	
	public static final Property<String> OPERATIONTYPE = new Property<String>("operationType", String.class, false);
	
	public static final Property<String> CLIENTNAME = new Property<String>("clientName", String.class, false);
	
	public static final Property<Date> DISBURSEMENTDATE = new Property<Date>("disbursementDate", Date.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<String> OFFICER = new Property<String>("officer", String.class, false);
	
	public static final Property<BigDecimal> NEXTPAYMENT = new Property<BigDecimal>("nextPayment", BigDecimal.class, false);
	
	public static final Property<BigDecimal> EFFECTIVEANUALRATE = new Property<BigDecimal>("effectiveAnualRate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<String> ADJUSTMENT = new Property<String>("adjustment", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("office", String.class, false);
	
	public static final Property<Date> FEEENDDATE = new Property<Date>("feeEndDate", Date.class, false);
	
	public static final Property<Integer> OFFICERID = new Property<Integer>("officerID", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
