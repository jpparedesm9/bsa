package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class LoanRates {

	public static final String EN_LOANRATES_507 = "EN_LOANRATES_507";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanRates";
	
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<String> UPDATEDON = new Property<String>("updatedOn", String.class, false);
	
	public static final Property<Integer> QUOTA = new Property<Integer>("quota", Integer.class, false);
	
	public static final Property<String> ITEM = new Property<String>("item", String.class, false);
	
	public static final Property<String> VALUETOAPPLY = new Property<String>("valueToApply", String.class, false);
	
	public static final Property<String> SIGNTOAPPLY = new Property<String>("signToApply", String.class, false);
	
	public static final Property<String> SPREADAPPLY = new Property<String>("spreadApply", String.class, false);
	
	public static final Property<BigDecimal> CURRENTRATE = new Property<BigDecimal>("currentRate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ANUALEFFECTIVERATE = new Property<BigDecimal>("anualEffectiveRate", BigDecimal.class, false);
	
	public static final Property<String> REFERENTIALRATE = new Property<String>("referentialRate", String.class, false);
	
	public static final Property<BigDecimal> VALUEREFERENCERATE = new Property<BigDecimal>("valueReferenceRate", BigDecimal.class, false);
	
	public static final Property<String> DATEREFERENCERATE = new Property<String>("dateReferenceRate", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
