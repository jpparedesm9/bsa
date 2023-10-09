package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class HeaderPunishment {

	public static final String EN_EDRPNSMET212 = "EN_EDRPNSMET212";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "HeaderPunishment";
	
	
	public static final Property<Double> SPECIFICFORECAST = new Property<Double>("SpecificForecast", Double.class, false);
	
	public static final Property<Double> PERCENTAGERECOVERED = new Property<Double>("PercentageRecovered", Double.class, false);
	
	public static final Property<Date> COURTDATE = new Property<Date>("CourtDate", Date.class, false);
	
	public static final Property<Date> DISBURSEMENTDATE = new Property<Date>("DisbursementDate", Date.class, false);
	
	public static final Property<String> CREDITSTATUS = new Property<String>("CreditStatus", String.class, false);
	
	public static final Property<String> CUSTOMERORIGINALACTIVITY = new Property<String>("CustomerOriginalActivity", String.class, false);
	
	public static final Property<Integer> NUMBERCREDITSEARNED = new Property<Integer>("NumberCreditsEarned", Integer.class, false);
	
	public static final Property<Integer> COURTDAYSLATE = new Property<Integer>("CourtDaysLate", Integer.class, false);
	
	public static final Property<Integer> APPLICATIONDAYSLATE = new Property<Integer>("ApplicationDaysLate", Integer.class, false);
	
	public static final Property<String> OFFICIALGRANT = new Property<String>("OfficialGrant", String.class, false);
	
	public static final Property<String> RESPONSIBLECURRENT = new Property<String>("ResponsibleCurrent", String.class, false);
	
	public static final Property<String> ACTUALUSELOAN = new Property<String>("ActualUseLoan", String.class, false);
	
	public static final Property<String> TROUBLE = new Property<String>("Trouble", String.class, false);
	
	public static final Property<String> IMPOSSIBILITYDESCRIPTION = new Property<String>("ImpossibilityDescription", String.class, false);
	
	public static final Property<String> DESCRIPNOTRECOVERGARANTIES = new Property<String>("DescripNotRecoverGaranties", String.class, false);
	
	public static final Property<BigDecimal> DISBURSEDAMOUNT = new Property<BigDecimal>("DisbursedAmount", BigDecimal.class, false);
	
	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("ApplicationNumber", Integer.class, false);
	
	public static final Property<Integer> IDREQUESTED = new Property<Integer>("IDRequested", Integer.class, false);
	
	public static final Property<Integer> AGENCY = new Property<Integer>("Agency", Integer.class, false);
	
	public static final Property<Integer> CITYCODE = new Property<Integer>("CityCode", Integer.class, false);
	
	public static final Property<String> CURRENCYREQUEST = new Property<String>("CurrencyRequest", String.class, false);
	
	public static final Property<String> CREDITTARGET = new Property<String>("CreditTarget", String.class, false);
	
	public static final Property<String> NUMBEROPERATION = new Property<String>("NumberOperation", String.class, false);
	
	public static final Property<String> CONSISTENCYAPPLICATION = new Property<String>("ConsistencyApplication", String.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("Observation", String.class, false);
	
	public static final Property<Integer> PROVINCE = new Property<Integer>("Province", Integer.class, false);
	
	public static final Property<String> USERL = new Property<String>("UserL", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<Character> STATUS = new Property<Character>("Status", Character.class, false);
	
	public static final Property<Integer> PARENTGROUPID = new Property<Integer>("ParentGroupID", Integer.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("GroupID", Integer.class, false);
	
	public static final Property<String> SINDICO1 = new Property<String>("Sindico1", String.class, false);
	
	public static final Property<String> SINDICO2 = new Property<String>("Sindico2", String.class, false);
	
	public static final Property<Integer> STEP = new Property<Integer>("Step", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
