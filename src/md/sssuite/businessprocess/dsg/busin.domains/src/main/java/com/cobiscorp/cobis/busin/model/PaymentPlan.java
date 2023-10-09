package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentPlan {

	public static final String EN_AYMENTLAN712 = "EN_AYMENTLAN712";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentPlan";
	
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> TABLETYPE = new Property<String>("tableType", String.class, false);
	
	public static final Property<BigDecimal> CAPITAL = new Property<BigDecimal>("capital", BigDecimal.class, false);
	
	public static final Property<BigDecimal> QUOTA = new Property<BigDecimal>("quota", BigDecimal.class, false);
	
	public static final Property<Integer> DAYSPERYEAR = new Property<Integer>("daysPerYear", Integer.class, false);
	
	public static final Property<Character> CALCULATIONBASED = new Property<Character>("calculationBased", Character.class, false);
	
	public static final Property<String> TERMTYPE = new Property<String>("termType", String.class, false);
	
	public static final Property<String> QUOTATYPE = new Property<String>("quotaType", String.class, false);
	
	public static final Property<Integer> CAPITALPERIODGRACE = new Property<Integer>("capitalPeriodGrace", Integer.class, false);
	
	public static final Property<Integer> INTERESTPERIODGRACE = new Property<Integer>("interestPeriodGrace", Integer.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("term", Integer.class, false);
	
	public static final Property<String> QUOTAINTEREST = new Property<String>("quotaInterest", String.class, false);
	
	public static final Property<Integer> CAPITALPERIOD = new Property<Integer>("capitalPeriod", Integer.class, false);
	
	public static final Property<Integer> INTERESTPERIOD = new Property<Integer>("interestPeriod", Integer.class, false);
	
	public static final Property<Character> FIXEDPPAYMENTDATE = new Property<Character>("fixedpPaymentDate", Character.class, false);
	
	public static final Property<Integer> PAYMENTDAY = new Property<Integer>("paymentDay", Integer.class, false);
	
	public static final Property<Integer> MONTHNOPAYMENT = new Property<Integer>("monthNoPayment", Integer.class, false);
	
	public static final Property<Integer> GRACEARREARSDAYS = new Property<Integer>("graceArrearsDays", Integer.class, false);
	
	public static final Property<Character> AVOIDHOLIDAYS = new Property<Character>("avoidHolidays", Character.class, false);
	
	public static final Property<String> INTERESTSPERIODGRACE = new Property<String>("interestsPeriodGrace", String.class, false);
	
	public static final Property<String> BASCALCULATIONINTEREST = new Property<String>("basCalculationInterest", String.class, false);
	
	public static final Property<Boolean> CALCULATIONSTATUS = new Property<Boolean>("calculationStatus", Boolean.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
