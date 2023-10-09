package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Term {

	public static final String EN_TERMLHHZR028 = "EN_TERMLHHZR028";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Term";
	
	
	public static final Property<String> TYPETERM = new Property<String>("TypeTerm", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final Property<String> TYPEOFFEE = new Property<String>("TypeofFee", String.class, false);
	
	public static final Property<Integer> PERIODICITYCAPITAL = new Property<Integer>("PeriodicityCapital", Integer.class, false);
	
	public static final Property<Integer> PERIODICITYOFINTEREST = new Property<Integer>("PeriodicityofInterest", Integer.class, false);
	
	public static final Property<Integer> CALCULATIONBASE = new Property<Integer>("CalculationBase", Integer.class, false);
	
	public static final Property<Character> FEECALCULATIONDAYS = new Property<Character>("FeeCalculationDays", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
