package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LineHeader {

	public static final String EN_LINEEADER382 = "EN_LINEEADER382";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LineHeader";
	
	
	public static final Property<Character> ROTARY = new Property<Character>("Rotary", Character.class, false);
	
	public static final Property<String> COMMITTED = new Property<String>("Committed", String.class, false);
	
	public static final Property<Double> AMOUNTPROPOSED = new Property<Double>("AmountProposed", Double.class, false);
	
	public static final Property<String> CURRENCYPROPOSED = new Property<String>("CurrencyProposed", String.class, false);
	
	public static final Property<Date> ENTRYDATE = new Property<Date>("EntryDate", Date.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("ExpirationDate", Date.class, false);
	
	public static final Property<String> OFFICER = new Property<String>("Officer", String.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<Integer> PROVINCE = new Property<Integer>("Province", Integer.class, false);
	
	public static final Property<Integer> GEOGRAOHICDESTINATION = new Property<Integer>("GeograohicDestination", Integer.class, false);
	
	public static final Property<String> OFFICERNAME = new Property<String>("officerName", String.class, false);
	
	public static final Property<Double> AMOUNTLOCALCURRENCY = new Property<Double>("AmountLocalCurrency", Double.class, false);
	
	public static final Property<String> NUMBER = new Property<String>("Number", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final Property<Integer> CREDITCODE = new Property<Integer>("CreditCode", Integer.class, false);
	
	public static final Property<Double> AMOUNTUSED = new Property<Double>("AmountUsed", Double.class, false);
	
	public static final Property<Double> AVAILABLEAMOUNT = new Property<Double>("AvailableAmount", Double.class, false);
	
	public static final Property<Integer> OFFICECODE = new Property<Integer>("OfficeCode", Integer.class, false);
	
	public static final Property<Integer> CITYCODE = new Property<Integer>("CityCode", Integer.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("Code", Integer.class, false);
	
	public static final Property<String> NUMBERTESTIMONY = new Property<String>("NumberTestimony", String.class, false);
	
	public static final Property<Double> MAXIMUNQUOTELINE = new Property<Double>("MaximunQuoteLine", Double.class, false);
	
	public static final Property<Double> MAXIMUNQUOTE = new Property<Double>("MaximunQuote", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
