package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class WarrantySituation {

	public static final String EN_WANTYSTTO414 = "EN_WANTYSTTO414";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantySituation";
	
	
	public static final Property<String> AMOUNT = new Property<String>("amount", String.class, false);
	
	public static final Property<Date> LEGALSTATUS = new Property<Date>("legalStatus", Date.class, false);
	
	public static final Property<Character> COMMERCIALORINDUSTRY = new Property<Character>("commercialOrIndustry", Character.class, false);
	
	public static final Property<Date> LASTVALUATION = new Property<Date>("lastValuation", Date.class, false);
	
	public static final Property<String> ADMISSIBILITY = new Property<String>("admissibility", String.class, false);
	
	public static final Property<Character> SINISTER = new Property<Character>("sinister", Character.class, false);
	
	public static final Property<Character> EXPIRATIONCONTROL = new Property<Character>("expirationControl", Character.class, false);
	
	public static final Property<String> INSTRUCTION = new Property<String>("instruction", String.class, false);
	
	public static final Property<Character> DEPLETIVE = new Property<Character>("depletive", Character.class, false);
	
	public static final Property<Date> EXPIRATION = new Property<Date>("expiration", Date.class, false);
	
	public static final Property<Character> PENALTY = new Property<Character>("penalty", Character.class, false);
	
	public static final Property<Date> CONSTITUTION = new Property<Date>("constitution", Date.class, false);
	
	public static final Property<String> CLASSWARRANTY = new Property<String>("classWarranty", String.class, false);
	
	public static final Property<String> LEGALSUFFICIENCY = new Property<String>("legalSufficiency", String.class, false);
	
	public static final Property<Boolean> GUARANTEEFUND = new Property<Boolean>("guaranteeFund", Boolean.class, false);
	
	public static final Property<Boolean> INSPECTTYPE = new Property<Boolean>("inspectType", Boolean.class, false);
	
	public static final Property<Boolean> JUDICIALCOLLECTIONTYPE = new Property<Boolean>("judicialCollectionType", Boolean.class, false);
	
	public static final Property<Date> RETURNDATE = new Property<Date>("returnDate", Date.class, false);
	
	public static final Property<String> INSPECTREASON = new Property<String>("inspectReason", String.class, false);
	
	public static final Property<BigDecimal> TOTALINITIALVALUE = new Property<BigDecimal>("totalInitialValue", BigDecimal.class, false);
	
	public static final Property<String> PERIODICITY = new Property<String>("periodicity", String.class, false);
	
	public static final Property<String> SUITABLE = new Property<String>("suitable", String.class, false);
	
	public static final Property<Date> RETIREMENTDATE = new Property<Date>("retirementDate", Date.class, false);
	
	public static final Property<Boolean> SHAREDTYPE = new Property<Boolean>("sharedType", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
