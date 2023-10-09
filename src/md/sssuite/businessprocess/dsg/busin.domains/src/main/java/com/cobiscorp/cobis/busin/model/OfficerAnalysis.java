package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class OfficerAnalysis {

	public static final String EN_FICRALYSS039 = "EN_FICRALYSS039";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "OfficerAnalysis";
	
	
	public static final Property<String> CREDITLINEVALID = new Property<String>("CreditLineValid", String.class, false);
	
	public static final Property<String> CREDITLINEVALIDCUSTOM = new Property<String>("CreditLineValidCustom", String.class, false);
	
	public static final Property<String> APPLICATIONNUMBER = new Property<String>("ApplicationNumber", String.class, true);
	
	public static final Property<BigDecimal> SUGGESTEDAMOUNT = new Property<BigDecimal>("SuggestedAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTTODISBURSE = new Property<BigDecimal>("AmounttoDisburse", BigDecimal.class, false);
	
	public static final Property<Integer> SUGGESTEDCURRENCY = new Property<Integer>("Suggestedcurrency", Integer.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("ProductType", String.class, false);
	
	public static final Property<String> TERMFRECUENCY = new Property<String>("TermFrecuency", String.class, false);
	
	public static final Property<Integer> TERM = new Property<Integer>("Term", Integer.class, false);
	
	public static final Property<String> OFFICER = new Property<String>("Officer", String.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<Integer> PROVINCE = new Property<Integer>("Province", Integer.class, false);
	
	public static final Property<Integer> CITY = new Property<Integer>("City", Integer.class, false);
	
	public static final Property<String> CREDITLINE = new Property<String>("CreditLine", String.class, false);
	
	public static final Property<String> SERCTORNEG = new Property<String>("SerctorNeg", String.class, false);
	
	public static final Property<String> OFFICIERNAME = new Property<String>("OfficierName", String.class, false);
	
	public static final Property<String> OBSERVATIONREPROG = new Property<String>("observationReprog", String.class, false);
	
	public static final Property<String> PARROQUIA = new Property<String>("Parroquia", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		pks.add(APPLICATIONNUMBER);
		return pks;
	}

}
