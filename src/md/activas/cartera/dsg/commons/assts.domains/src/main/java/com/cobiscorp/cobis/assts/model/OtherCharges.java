package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class OtherCharges {

	public static final String EN_INGOTRCSA_824 = "EN_INGOTRCSA_824";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "OtherCharges";
	
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("sequential", Integer.class, false);
	
	public static final Property<Integer> INIDIV = new Property<Integer>("iniDiv", Integer.class, false);
	
	public static final Property<Integer> DIVUP = new Property<Integer>("divUp", Integer.class, false);
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<String> COMMENTARY = new Property<String>("commentary", String.class, false);
	
	public static final Property<Character> CATEGORYTYPE = new Property<Character>("categoryType", Character.class, false);
	
	public static final Property<String> VALUEAPPLY = new Property<String>("valueApply", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<BigDecimal> VALUEMIN = new Property<BigDecimal>("valueMin", BigDecimal.class, false);
	
	public static final Property<BigDecimal> VALUEMAX = new Property<BigDecimal>("valueMax", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BASECALCULATION = new Property<BigDecimal>("baseCalculation", BigDecimal.class, false);
	
	public static final Property<Character> BALANCEOP = new Property<Character>("balanceOp", Character.class, false);
	
	public static final Property<Character> BALANCEDESEMP = new Property<Character>("balanceDesemp", Character.class, false);
	
	public static final Property<BigDecimal> RATE = new Property<BigDecimal>("rate", BigDecimal.class, false);
	
	public static final Property<Integer> DECTAPL = new Property<Integer>("decTapl", Integer.class, false);
	
	public static final Property<String> RANGE = new Property<String>("range", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
