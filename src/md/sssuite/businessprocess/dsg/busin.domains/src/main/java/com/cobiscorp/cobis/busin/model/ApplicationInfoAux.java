package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ApplicationInfoAux {

	public static final String EN_APPLICANF_240 = "EN_APPLICANF_240";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ApplicationInfoAux";
	
	
	public static final Property<BigDecimal> INGRESOSMENSUALES = new Property<BigDecimal>("ingresosMensuales", BigDecimal.class, false);
	
	public static final Property<String> REASONNOTACCEPTED = new Property<String>("reasonNotAccepted", String.class, false);
	
	public static final Property<String> NIVELCOLECTIVO = new Property<String>("nivelColectivo", String.class, false);
	
	public static final Property<Character> ISENTREPRENEURSHIP = new Property<Character>("isEntrepreneurship", Character.class, false);
	
	public static final Property<String> ISPARTNER = new Property<String>("isPartner", String.class, false);
	
	public static final Property<BigDecimal> MONTHLYPAYMENTCAPACITY = new Property<BigDecimal>("monthlyPaymentCapacity", BigDecimal.class, false);
	
	public static final Property<String> COLECTIVO = new Property<String>("colectivo", String.class, false);
	
	public static final Property<Character> GROUPACCEPTRENEW = new Property<Character>("groupAcceptRenew", Character.class, false);
	
	public static final Property<Character> ISPROMOTION = new Property<Character>("isPromotion", Character.class, false);
	
	public static final Property<Double> PERCENTAGEGUARANTEE = new Property<Double>("percentageGuarantee", Double.class, false);
	
	public static final Property<Character> CUSTOMEREXPERIENCE = new Property<Character>("customerExperience", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
