package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class EconomicInformation {

	public static final String EN_ECONOMIOT_754 = "EN_ECONOMIOT_754";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EconomicInformation";
	
	
	public static final Property<Boolean> HASOTHERINCOME = new Property<Boolean>("hasOtherIncome", Boolean.class, false);
	
	public static final Property<Character> PERSONTYPE = new Property<Character>("personType", Character.class, false);
	
	public static final Property<Double> OPERATINGCOST = new Property<Double>("operatingCost", Double.class, false);
	
	public static final Property<String> EXPENSELEVEL = new Property<String>("expenseLevel", String.class, false);
	
	public static final Property<Double> LIABILITIES = new Property<Double>("liabilities", Double.class, false);
	
	public static final Property<Integer> PERSONSECUENTIAL = new Property<Integer>("personSecuential", Integer.class, false);
	
	public static final Property<Double> MONTHLYTRXAMOUNT = new Property<Double>("monthlyTrxAmount", Double.class, false);
	
	public static final Property<Double> ASSETS = new Property<Double>("assets", Double.class, false);
	
	public static final Property<String> CATEGORYALM = new Property<String>("categoryALM", String.class, false);
	
	public static final Property<String> TUTORID = new Property<String>("tutorId", String.class, false);
	
	public static final Property<String> MONTHLYINCOME = new Property<String>("monthlyIncome", String.class, false);
	
	public static final Property<Integer> BUSINESSYEARS = new Property<Integer>("businessYears", Integer.class, false);
	
	public static final Property<Double> AVAILABLEBALANCE = new Property<Double>("availableBalance", Double.class, false);
	
	public static final Property<String> TUTORNAME = new Property<String>("tutorName", String.class, false);
	
	public static final Property<Boolean> ISLINKED = new Property<Boolean>("isLinked", Boolean.class, false);
	
	public static final Property<Double> OTHERINCOMES = new Property<Double>("otherIncomes", Double.class, false);
	
	public static final Property<Double> SALES = new Property<Double>("sales", Double.class, false);
	
	public static final Property<String> OTHERINCOMESOURCE = new Property<String>("otherIncomeSource", String.class, false);
	
	public static final Property<String> RELATIONID = new Property<String>("relationId", String.class, false);
	
	public static final Property<Double> SALESCOST = new Property<Double>("salesCost", Double.class, false);
	
	public static final Property<Double> AVAILABLERESULTS = new Property<Double>("availableResults", Double.class, false);
	
	public static final Property<Character> RETENTIONSUBJECT = new Property<Character>("retentionSubject", Character.class, false);
	
	public static final Property<String> INTERNALQUALIFICATION = new Property<String>("internalQualification", String.class, false);
	
	public static final Property<Double> AVAILABLETOTAL = new Property<Double>("availableTotal", Double.class, false);
	
	public static final Property<Double> BUSINESSINCOME = new Property<Double>("businessIncome", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
